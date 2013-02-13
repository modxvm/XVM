/**
 * ...
 * @author sirmax2
 * @author johnp
 */
import com.xvm.JSON;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.Macros;
import wot.utils.StatData;
import wot.utils.Utils;
import wot.utils.VehicleInfo;

class wot.utils.StatLoader
{
    public static var s_players_count = 0;
    public static var teams = { t1:0, t2:0 };
    public static var s_loadDataStarted = false;
    private static var s_loading = false;
    private static var dirty: Boolean = false;
    private static var requestId: Number = -1;

    private static var dummy = Logger.dummy; // avoid import warning

    // so we don't have to create it at function execution:
    // try to retrieve stats after 0.3, 0.8, 1.5, 3 and 5 seconds
    private static var currentTimeoutId = 0;
    private static var timeouts = [ 300, 500, 700, 1500, 2000 ];

    public static function AddPlayerData(playerId: Number, playerName: String, vehicle: String, icon: String,
        team: Number, selected: Boolean, realVehicleId: Number)
    {
        if (playerId <= 0 || !playerName)
            return;

        var pname = Utils.GetNormalizedPlayerName(playerName);
        var clan = Utils.GetClanName(playerName);

        //Logger.add("AddPlayerData(" + playerName + "): " + pname);

        if (team == Defines.TEAM_ALLY)
            teams.t1 = 1;
        else
            teams.t2 = 1;

        if (!StatData.s_data[pname])
            s_players_count++;
        StatData.s_data[pname] = {
            playerId: playerId,
            fullPlayerName: playerName.split(" ").join(""),
            label: pname,
            clanAbbrev: clan,
            vehicle: vehicle,
            vehicleId: VehicleInfo.getInfo2(icon).name,
            icon: icon,
            team: team,
      	    realVehicleId: realVehicleId ? realVehicleId : 0,
            selected: selected,
            loaded: StatData.s_data[pname] ? true : false,
            stat: StatData.s_data[pname] ? StatData.s_data[pname].stat : undefined
        };
        if (!StatData.s_data[pname].loaded)
            dirty = true;
    }

    public static function StartLoadData(cmd, isRecursiveCall)
    {
        //if (!isRecursiveCall)
        //  Logger.add("StatLoader.StartLoadData(): cmd=" + cmd);

        if (s_loadDataStarted && !isRecursiveCall)
            return;
        s_loadDataStarted = true;

        var command = (isRecursiveCall ? Defines.COMMAND_ADD : Defines.COMMAND_SET) + " ";

        var players_to_load = [];
        var len = 0;
        for (var pname in StatData.s_data)
        {
            var pdata = StatData.s_data[pname];
            if (!pdata.loaded)
            {
                //Logger.addObject(pdata, pname);
                var str: String = String(pdata.playerId) + "=" + pdata.fullPlayerName +
                    "&" + pdata.vehicleId + (pdata.selected ? "&1" : "");
                if (len + str.length > Defines.MAX_PATH - command.length)
                    break;
                pdata.loaded = true;
                players_to_load.push(str);
                len += str.length + 1;
            }
        }

        if (players_to_load.length > 0)
        {
            var lv:LoadVars = new LoadVars();
            lv.onData = function(str: String)
            {
                //Logger.add("lv: " + str);
                if (!str)
                    return;
                try
                {
                    var response = JSON.parse(str);
                    StatLoader.requestId = response.resultId;
                    StatLoader.StartLoadData(cmd, true);
                }
                catch (ex)
                {
                    StatLoader.requestId = -1;
                }
            }
            lv.load(command + players_to_load.join(","));
            return;
        }

        dirty = false;
        currentTimeoutId = 0;
        LoadStatData(cmd);
    }

    public static function LoadLastStat(event)
    {
        if (event)
            GlobalEventDispatcher.removeEventListener("config_loaded", StatLoader.LoadLastStat);
        GlobalEventDispatcher.addEventListener("process_fow", StatLoader.ProcessForFogOfWar);
        if (Config.s_config.rating.showPlayersStatistics && !StatData.s_loaded)
            LoadStatData(Defines.COMMAND_GET_LAST_STAT);
    }

    private static var requestCounter: Number = 0;
    private static function LoadStatData(command, isRecursiveCall)
    {
        //Logger.add("StatLoader.LoadStatData(): command=" + command);

        if (s_loading && !isRecursiveCall)
            return;
        s_loading = true;

        var lv:LoadVars = new LoadVars();
        lv.onData = function(str: String)
        {
            //Logger.add("lv: " + str);
            if (!str)
                return;

            var done = false;
            var finallyBugWorkaround: Boolean = false; // Workaround: finally block have a bug - it can be called twice. Why? How? F*ck!
            try
            {
                var response = JSON.parse(str);
                if (response.status == "NOT_READY")
                {
                    if (StatLoader.currentTimeoutId >= StatLoader.timeouts.length)
                        return;
                    var timer:Function = _global.setTimeout(function() { StatLoader.LoadStatData(command, true); },
                        StatLoader.timeouts[StatLoader.currentTimeoutId]);
                    StatLoader.currentTimeoutId++;
                    return;
                }

                done = true;

                if (response.info && response.info.xvm)
                    GlobalEventDispatcher.dispatchEvent({ type: "set_info", ver: response.info.xvm.ver, message: response.info.xvm.message });

                if (response.players)
                {
                    var players_length = response.players.length;
                    for (var i = 0; i < players_length; ++i)
                    {
                        var stat = response.players[i];
                        var name = stat.name.toUpperCase();
                        stat = StatLoader.CalculateStatValues(stat, name);
                        if (!StatData.s_data[name])
                        {
                            StatLoader.s_players_count++;
                            StatData.s_data[name] = { loaded: true };
                        }
                        StatData.s_data[name].stat = stat;
                        if (StatData.s_data[name].vehicleId == "UNKNOWN")
                            StatData.s_data[name].loaded = false;
                        Macros.RegisterStatMacros(stat.name, stat);
                        //Logger.addObject(stat, stat.name);
                    }
                }
            }
            catch (ex)
            {
                // do nothing
            }
            finally
            {
                if (finallyBugWorkaround)
                    return;
                finallyBugWorkaround = true;

                if (done)
                {
                    StatData.s_loaded = true;
                    StatLoader.s_loadDataStarted = false;
                    StatLoader.s_loading = false;
                    //Logger.add("Stat Loaded");
                    GlobalEventDispatcher.dispatchEvent( { type: "stat_loaded" } );

                    if (StatLoader.dirty)
                        var timer = _global.setTimeout(function() { StatLoader.StartLoadData(Defines.COMMAND_RUN_ASYNC); }, 50);
                }
            }
        };

        lv.load(command + ((command == Defines.COMMAND_RUN_ASYNC) ? " " + requestId + " " + requestCounter: ""));
        requestCounter++;
    }

    private static function CalculateStatValues(stat, name): Object
    {
        // rating (GWR)
        stat.r = stat.b > 0 ? Math.round(stat.w / stat.b * 100) : 0;

        if (!stat.tb || stat.tb <= 0 || !stat.tl || stat.tl <= 0)
            stat.tr = stat.r;
        else
        {
            var Or = stat.r;
            var Tr = Math.round(stat.tw / stat.tb * 100);
            var Tb = Math.min(stat.tb, 100);
            var Tl = Math.max(stat.tl, 10) * 10;
            stat.tr = Math.round(Or - (Or - Tr) * Tb / Tl);
        }

        // XVM Scale: http://www.koreanrandom.com/forum/topic/2625-xvm-scale

        // xeff
        stat.xeff = null;
        if (stat.e != null)
        {
            stat.xeff = Math.round(Math.max(0, Math.min(100,
              -0.000000002523 * Math.pow(stat.e, 3) +
              0.000003351 * Math.pow(stat.e, 2) +
              0.07331 * stat.e -
              31.57)));
        }

        // xwn
        stat.xwn = null;
        if (stat.wn != null)
        {
            stat.xwn = Math.round(Math.max(0, Math.min(100,
              0.000000001984 * Math.pow(stat.wn, 3) -
              0.00000191 * Math.pow(stat.wn, 2) +
              0.04803 * stat.wn -
              4.638)));
        }

        // tdb, tfb, tsb, tdv, te, teff (last)
        stat.tdb = null;
        stat.tfb = null;
        stat.tsb = null;
        stat.tdv = null;
        stat.te = null;
        stat.teff = null;
        // skip tb less then 10, because of WG bug:
        // http://www.koreanrandom.com/forum/topic/1643-/page-19#entry26189
        if (stat.tb == null || stat.tl == null || stat.tb < 10 + stat.tl * 2)
            return stat;

        stat.tdb = stat.td == null || stat.td < 0 ? null : Math.round(stat.td / stat.tb);
        stat.tfb = stat.tf == null || stat.tf < 0 ? null : Math.round(stat.tf / stat.tb * 10) / 10;
        stat.tsb = stat.ts == null || stat.ts < 0 ? null : Math.round(stat.ts / stat.tb * 10) / 10;
        //Logger.addObject(stat);

        var vi3 = VehicleInfo.getInfo3(stat.vn);
        if (!vi3 || !vi3.cl || !vi3.l)
        {
            Logger.add("WARNING: vehicle info (3) missed: " + stat.vn);
            return stat;
        }

        stat.tdv = stat.td == null || stat.td < 0 ? null : Math.round(stat.td / stat.tb / vi3.hp * 10) / 10;

        var EC = Config.s_config.consts.E[vi3.cl][vi3.l - 1];
//        Logger.addObject(stat);
//        Logger.addObject(EC);
        if (EC.CD != null && EC.CD > 0 && (stat.tdb == null || stat.tdb <= 0))
            return stat;
        if (EC.CF != null && EC.CF > 0 && (stat.tfb == null || stat.tfb <= 0))
            return stat;

        var dD = stat.tdb - vi3.avgD;
        var dF = stat.tfb - vi3.avgF;
        var minD = vi3.avgD * Config.s_config.consts.E.Kmin;
        var minF = vi3.avgF * Config.s_config.consts.E.Kmin;
        var d = 1 + dD / (vi3.topD - vi3.avgD);
        var f = 1 + dF / (vi3.topF - vi3.avgF);
        var d2 = stat.tdb < vi3.avgD ? stat.tdb / vi3.avgD : d;
        var f2 = stat.tfb < vi3.avgF ? stat.tfb / vi3.avgF : f;
        d = stat.tdb < vi3.avgD ? 1 + dD / (vi3.avgD - minD) : d;
        f = stat.tfb < vi3.avgF ? 1 + dF / (vi3.avgF - minF) : f;

        d = Math.max(0, d);
        f = Math.max(0, f);
        d2 = Math.max(0, d2);
        f2 = Math.max(0, f2);

        stat.te = (d * EC.CD + f * EC.CF) / (EC.CD + EC.CF);
        stat.teff2 = (d2 * EC.CD + f2 * EC.CF) / (EC.CD + EC.CF);
//        Logger.add(stat.vn + " D:" + d + " F:" + f + " S:" + s);

        stat.teff = Math.max(1, Math.round(stat.te * 1000));
        stat.teff2 = Math.max(1, Math.round(stat.teff2 * 1000));
        stat.te = (stat.teff == 0) ? 0
            : (stat.teff < 300) ? 1
            : (stat.teff < 500) ? 2
            : (stat.teff < 700) ? 3
            : (stat.teff < 900) ? 4
            : (stat.teff < 1100) ? 5
            : (stat.teff < 1300) ? 6
            : (stat.teff < 1550) ? 7
            : (stat.teff < 1800) ? 8
            : (stat.teff < 2000) ? 9 : 10;

//        Logger.add(stat.vn + " teff=" + stat.teff + " e:" + stat.te);
//        Logger.addObject(stat);

        return stat;
    }

    // Fog of War

    private static function ProcessForFogOfWar(event)
    {
        if (!event)
            return;
        var data = event.data;
        if (!data.uid)
            return;

        //Logger.add("ProcessForFogOfWar(): " + data.label);
        //Logger.addObject(data);

        var fullPlayerName = data.label + (data.clanAbbrev ? "[" + data.clanAbbrev + "]" : "");
        var pname: String = Utils.GetNormalizedPlayerName(fullPlayerName);

        if (StatData.s_data[pname])
            return;

        AddPlayerData(data.uid, fullPlayerName, data.vehicle, data.icon,
            data.team == "team1" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);

        var timer = _global.setTimeout(function() { StatLoader.StartLoadData(Defines.COMMAND_RUN_ASYNC); }, 50);
    }
}
