import com.xvm.JSONx;
import com.xvm.Comm;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Logger;
import com.xvm.Macros;
import com.xvm.StatData;
import com.xvm.Utils;
import com.xvm.VehicleInfo;

class com.xvm.StatLoader
{
    public static var s_players_count = 0;
    public static var teams = { t1:0, t2:0 };
    private static var s_loading = false;
    private static var dirty:Boolean = false;

    // data: {
    //   uid|id|playerId,
    //   label|playerName,
    //   vehicle|vehicleName,
    //   icon|tankIcon,
    //   himself,
    //   vehId|playerID,
    //   vehicleState
    // }
    public static function AddPlayerData(data:Object, team:Number)
    {
        var id = data.uid || data.id || data.playerId || 0;
        var label = data.label || data.playerName;
        var vehicle = data.vehicle || data.vehicleName;
        var icon = data.icon || data.tankIcon;
        var vehId = data.vehId || data.playerID || 0;
        var vehicleState = data.vehicleState || 3; // IS_ALIVE = 1, IS_AVATAR_READY = 2, IS_UNKNOWN = 4

        //Logger.add("AddPlayerData: " + playerName + ", " + vehicle + ", " + icon);

        if (id <= 0 || !label)
            return;

        if (data.clanAbbrev)
            label += "[" + data.clanAbbrev + "]";

        var pname = Utils.GetNormalizedPlayerName(label);
        var clan = Utils.GetClanName(label);

        if (team == Defines.TEAM_ALLY)
            teams.t1 = 1;
        else
            teams.t2 = 1;

        if (!StatData.s_data[pname])
            s_players_count++;
        StatData.s_data[pname] = {
            playerId: id,
            fullPlayerName: label.split(" ").join(""),
            label: pname,
            clanAbbrev: clan,
            vehicle: vehicle,
            vehicleKey: VehicleInfo.getInfo2(icon).name.toUpperCase(),
            icon: icon,
            team: team,
      	    vehicleId: vehId,
            vehicleState: vehicleState,
            selected: data.himself,
            loadstate: !StatData.s_data[pname].loadstate ? Defines.LOADSTATE_NONE : StatData.s_data[pname].loadstate,
            stat: StatData.s_data[pname] ? StatData.s_data[pname].stat : undefined
        };
        if (StatData.s_data[pname].loadstate == Defines.LOADSTATE_NONE)
            dirty = true;
    }

    public static function StartLoadData()
    {
        if (s_loading)
            return;
        s_loading= true;
        StartLoadDataInternal();
    }

    private static function StartLoadDataInternal()
    {
        var rq = [];
        for (var pname in StatData.s_data)
        {
            var pdata = StatData.s_data[pname];
            if (pdata.loadstate != Defines.LOADSTATE_NONE)
                continue;
            pdata.loadstate = Defines.LOADSTATE_LOADING;
            var pd = {
                id:pdata.playerId,
                n:pdata.fullPlayerName,
                v:pdata.vehicleKey,
                s:pdata.selected ? 1 : 0,
                t:pdata.team
            }
            rq.push(JSONx.stringify(pd, "", true));
        }

        var n = rq.length;
        Logger.add("StatLoader: Loading data: " + s_players_count + " total, " + n + " to load");
        for (var i = 0; i < n; ++i)
        {
            Comm.SyncEncoded(i == 0 ? Defines.COMMAND_SET : Defines.COMMAND_ADD, rq[i], null, function(event) {
                n--;
                try
                {
                    var response = JSONx.parse(event.str);
                    if (n == 0)
                        Comm.Async(Defines.COMMAND_GET_ASYNC, response.resultId, null, null, StatLoader.LoadStatDataCallback);
                    // TODO: what if bad resultId?
                }
                catch (e)
                {
                    Logger.add("Error parsing response: " + e);
                    if (n == 0)
                        StatLoader.LoadStatDataCallback({error:e});
                }
            });
        }

        dirty = false;
    }

    private static function LoadStatDataCallback(event)
    {
        var finallyBugWorkaround: Boolean = false; // Workaround: finally block have a bug - it can be called twice. Why? How?
        try
        {
            var response = JSONx.parse(event.str);

            if (response.info && response.info.xvm)
                GlobalEventDispatcher.dispatchEvent({ type: "set_info", ver: response.info.xvm.ver, message: response.info.xvm.message });

            if (response.players)
            {
                var players_length = response.players.length;
                for (var i = 0; i < players_length; ++i)
                {
                    var stat = response.players[i];
                    var name = stat.name.toUpperCase();
                    stat = StatLoader.CalculateStatValues(stat);
                    if (!StatData.s_data[name])
                    {
                        StatLoader.s_players_count++;
                        StatData.s_data[name] = { };
                    }
                    StatData.s_data[name].stat = stat;
                    StatData.s_data[name].loadstate = (StatData.s_data[name].vehicleKey == "UNKNOWN")
                        ? Defines.LOADSTATE_UNKNOWN : Defines.LOADSTATE_DONE;
                    StatData.s_empty = false;
                    Macros.RegisterStatMacros(stat.name, stat);
                    //Logger.addObject(StatData.s_data[name], "s_data[" + name + "]");
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

            StatData.s_loaded = true;
            StatLoader.s_loading = false;
            //Logger.add("Stat Loaded");
            GlobalEventDispatcher.dispatchEvent( { type: "stat_loaded" } );

            if (StatLoader.dirty)
                var timer = _global.setTimeout(function() { StatLoader.StartLoadData(); }, 50);
        }
    }

    public static function CalculateStatValues(stat, forceTeff): Object
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
            stat.xeff = Utils.XEFF(stat.e);

        // xwn
        stat.xwn = null;
        if (stat.wn != null)
            stat.xwn = Utils.XWN(stat.wn);

        // tdb, tfb, tsb, tdv, te, teff (last)
        stat.tdb = null;
        stat.tfb = null;
        stat.tsb = null;
        stat.tdv = null;
        stat.te = null;
        stat.teff = null;
        // skip tb less then 10, because of WG bug:
        // http://www.koreanrandom.com/forum/topic/1643-/page-19#entry26189
        // forceTeff used in UserInfo, there is not this bug there.
        if (stat.tb == null || stat.tl == null || (forceTeff != true && stat.tb < 10 + stat.tl * 2))
            return stat;

        stat.tdb = stat.td == null || stat.td < 0 ? null : Math.round(stat.td / stat.tb);
        stat.tfb = stat.tf == null || stat.tf < 0 ? null : Math.round(stat.tf / stat.tb * 10) / 10;
        stat.tsb = stat.ts == null || stat.ts < 0 ? null : Math.round(stat.ts / stat.tb * 10) / 10;
        //Logger.addObject(stat);

        var vi2 = VehicleInfo.getInfo2("/-" + stat.vn + ".");
        if (!vi2 || !vi2.type || !vi2.level)
        {
            //Logger.add("WARNING: vehicle info (3) missed: " + stat.vn);
            return stat;
        }

        stat.tdv = stat.td == null || stat.td < 0 ? null : Math.round(stat.td / stat.tb / vi2.hptop * 10) / 10;

        var EC = { CD: 3, CF: 1 };
//        Logger.addObject(stat);
//        Logger.addObject(EC);
        if (EC.CD != null && EC.CD > 0 && (stat.tdb == null || stat.tdb <= 0))
            return stat;
        if (EC.CF != null && EC.CF > 0 && (stat.tfb == null || stat.tfb <= 0))
            return stat;

        var dD = stat.tdb - vi2.avg.D;
        var dF = stat.tfb - vi2.avg.F;
        var minD = vi2.avg.D * 0.4;
        var minF = vi2.avg.F * 0.4;
        var d = 1 + dD / (vi2.top.D - vi2.avg.D);
        var f = 1 + dF / (vi2.top.F - vi2.avg.F);
        var d2 = stat.tdb < vi2.avg.D ? stat.tdb / vi2.avg.D : d;
        var f2 = stat.tfb < vi2.avg.F ? stat.tfb / vi2.avg.F : f;
        d = stat.tdb < vi2.avg.D ? 1 + dD / (vi2.avg.D - minD) : d;
        f = stat.tfb < vi2.avg.F ? 1 + dF / (vi2.avg.F - minF) : f;

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

    public static function LoadLastStat(event)
    {
        if (event)
            GlobalEventDispatcher.removeEventListener("config_loaded", StatLoader.LoadLastStat);
        GlobalEventDispatcher.addEventListener("process_fow", StatLoader.ProcessForFogOfWar);
        if (Config.s_config.rating.showPlayersStatistics && !StatData.s_loaded)
            Comm.Sync(Defines.COMMAND_GET_PLAYERS, null, null, GetPlayersCallback);
    }

    private static function GetPlayersCallback(event)
    {
        try
        {
            //Logger.add(event.str);
            var players = JSONx.parse(event.str);
            for (var i = 0; i < players.length; ++i)
            {
                var p = players[i];
                var vi2 = VehicleInfo.getInfo2("/-" + p.v + ".");
                AddPlayerData({
                   uid: p.id,
                   label: p.n,
                   vehicle: vi2 ? vi2.name : p.v,
                   icon: "../maps/icons/vehicle/contour/" + (vi2 ? vi2.nation + "-" + vi2.name : "unknown-" + p.v) + ".png",
                   himself: p.s,
                   vehId: 0,
                   vehicleState: 3
                }, p.t);
            }
            var timer = _global.setTimeout(function() { StatLoader.StartLoadData(); }, 50);
        }
        catch (ex)
        {
            // do nothing
        }
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

        var pname: String = Utils.GetNormalizedPlayerName(data.label);
        if (StatData.s_data[pname] && StatData.s_data[pname].loadstate != Defines.LOADSTATE_NONE)
            return;

        AddPlayerData(data, event.team);

        var timer = _global.setTimeout(function() { StatLoader.StartLoadData(); }, 50);
    }

    public static function LoadUserData(value, isId)
    {
        //Logger.add("LoadUserData: " + value);

        var a:Array = (String(value) + "," + (isId == true ? "ID" : Config.s_game_region)).split("");
        var s:String = "";
        var a_length:Number = a.length;
        for (var i = 0; i < a_length; ++i)
        {
          var b:Number = a[i].charCodeAt(0);
          var c:String = (b < 128) ? b.toString(16) : escape(a[i].charAt(0)).split("%").join("");
          s += (c.length % 2 == 0 ? "" : "0") + c;
        }

        Comm.Async(Defines.COMMAND_INFO_ASYNC, -1, s, null, function(e) { StatLoader.LoadUserDataCallback(e, value, isId); } );
    }

    private static function LoadUserDataCallback(event, value, isId)
    {
        var data = null;
        if (event.error)
            data = {error:event.error};
        else if (!event.str)
            data = {error:"no data"};
        else
        {
            try
            {
                data = JSONx.parse(event.str);
            }
            catch (ex)
            {
                data = {error:ex};
            }
        }
        GlobalEventDispatcher.dispatchEvent( { type: "userdata_loaded", data: data, request: { value: value, isId: isId } } );
    }
}
