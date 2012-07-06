/**
 * ...
 * @author sirmax2
 * @author johnp
 */
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.xvm.JSON;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.StatData;
import wot.utils.Utils;
import wot.utils.VehicleInfo;

class wot.utils.StatLoader
{
  public static var s_players_count = 0;
  public static var s_loadDataStarted = false;
  public static var s_loaded = false;

  private static var s_loading = false;
  private static var _is_new: Boolean = true;
  private static var retrieving: Boolean = false;
  private static var retrieved: Boolean = true;
  private static var runningIngame: Boolean = false;
  private static var added: Boolean = false;

  private static var dummy = Logger.dummy; // avoid import warning

  // so we don't have to create it at function execution:
  // try to retrieve stats after 0.3, 0.5, 1 and 3 seconds
  private static var timer: TimelineLite = new TimelineLite( {
    tweens: [ new TweenLite(null, .3), new TweenLite(null, .5), new TweenLite(null, 1), new TweenLite(null, 3) ],
    onComplete: StatLoader.RetrieveStatsIngame,
    onCompleteParams: [],
    paused: true } );

  public static function AddPlayerData(playerId: Number, playerName: String, originalText: String, icon: String,
    team: Number, selected: Boolean)
  {
    if (playerId <= 0 || !playerName)
      return;

    var pname = Utils.GetNormalizedPlayerName(playerName);
    var clan = Utils.GetClanName(playerName);

    //Logger.add("AddPlayerData(" + playerName + "): " + pname);

    if (!StatData.s_data[pname])
      s_players_count++;
    StatData.s_data[pname] = {
      playerId: playerId,
      fullPlayerName: playerName,
      name: pname,
      clan: clan,
      originalText: originalText,
      icon: icon,
      vehicleName: VehicleInfo.getShortName(icon),
      team: team,
      selected: selected,
      loaded: false,
      stat: StatData.s_data[pname] ? StatData.s_data[pname].stat : undefined
    };
  }

  public static function StartLoadData()
  {
    //Logger.add("Stat.StartLoadData(): "+ s_loadDataStarted);
    if (s_loadDataStarted)
      return;
    s_loadDataStarted = true;
    LoadData();
  }

  private static var _s_isNew = true;
  private static function LoadData()
  {
    //Logger.add("Stat.LoadData()");

    var is_new = _s_isNew;
    _s_isNew = false;
    var command = (is_new ? Defines.COMMAND_SET : Defines.COMMAND_ADD) + " ";

    var players_to_load = [];
    var len = 0;
    for (var pname in StatData.s_data)
    {
      var pdata = StatData.s_data[pname];
      if (!pdata.loaded)
      {
        var str: String = String(pdata.playerId) + "=" + pdata.fullPlayerName +
          "&" + pdata.vehicleName + (pdata.selected ? "&1" : "");
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
      lv.onLoad = function(success)
      {
        StatLoader.LoadData();
      }
      lv.load(command + players_to_load.join(","));
    }
    else
    {
      LoadStatData(Defines.COMMAND_RUN);
    }
  }

  public static function LoadLastStat(event)
  {
    if (event)
      GlobalEventDispatcher.removeEventListener("config_loaded", StatLoader.LoadLastStat);
    if (Config.s_config.rating.showPlayersStatistics)
      LoadStatData(Defines.COMMAND_GET_LAST_STAT);
  }

  public static function LoadStatData(command)
  {
    if (s_loading || s_loaded)
      return;
    s_loading = true;

    var lv:LoadVars = new LoadVars();
    lv.onData = function(str: String)
    {
      try
      {
        //Logger.add("lv: "+str);
        if (!str)
          return;
        var stats = JSON.parse(str);

        var players_length = stats.players.length;
        for (var i = 0; i < players_length; ++i)
        {
          var stat = stats.players[i];
          stat = StatLoader.CalculateRating(stat);
          var name = stat.name.toUpperCase();
          if (!StatData.s_data[name])
          {
            StatLoader.s_players_count++;
            StatData.s_data[name] = { };
          }
          StatData.s_data[name].stat = stat;
          //Logger.addObject(stat, stat.name);
        };

        if (stats.info && stats.info.xvm)
          GlobalEventDispatcher.dispatchEvent({ type: "set_info", ver: stats.info.xvm.ver, message: stats.info.xvm.message });

          StatLoader.s_loaded = true;
          GlobalEventDispatcher.dispatchEvent( { type: "stat_loaded" } );
      }
      catch (ex)
      {
        // do nothing
      }
    };
    lv.load(command);
  }

  public static function CalculateRating(stat): Object
  {
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
    //Logger.addObject(stat);
    return stat;
  }

  // Fog of War

  public static function ProcessForFogOfWar(data)
  {
    var fullPlayerName = data.label || data.name;
    var pname: String = Utils.GetNormalizedPlayerName(fullPlayerName);
    var clan: String = Utils.GetClanName(fullPlayerName);
    if (data.uid && !StatData.s_data[pname])
    {
      try
      {
        parseInt(data.uid);

        // add player data
        AddPlayerData(null, null, data.uid, fullPlayerName, data.vehicle || data.originalText, data.icon,
          data.team == "team1" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY)

        var str: String = data.uid + "=" + fullPlayerName + "&" + VehicleInfo.getShortName(data.icon);
        var lv: LoadVars = new LoadVars();
        lv.onData = function(success)
        {
          if (!StatLoader.retrieved || StatLoader.runningIngame)
            return;
          StatLoader.runningIngame = true;
          var lv_run = new LoadVars();
          lv_run.onData = function(res)
          {
            StatLoader._is_new = true;
            StatLoader.retrieved = false;
            StatLoader.added = true;
            // try to retrieve stats
            StatLoader.timer.gotoAndPlay(null);
          }
          lv_run.load(Defines.COMMAND_RUNINGAME);
        }
        var cmd = _is_new ? Defines.COMMAND_SET : Defines.COMMAND_ADD;
        _is_new = false;
        lv.load(cmd + " " + str);
      }
      catch (FormatException)
      {
        //Logger.add(data.uid + " is not a uid!");
      }
    }
    else
    {
      // just try to load
      StatLoader.RetrieveStatsIngame();
    }
  }

  private static function RetrieveStatsIngame()
  {
    if (!retrieving && ! retrieved)
    {
      // retrieve stats
      //Logger.add("Retrieve stats");
      retrieving = true;

      // check if retrieving stats from server finished
      var lv_check:LoadVars = new LoadVars();
      lv_check.onData = function(check)
      {
        try
        {
          //Logger.add("check: "+check)
          if (check == "FINISHED")
          {
            StatLoader.retrieving = true;
            // stop timer execution
            StatLoader.timer.stop();
            // retrieve stats from proxy
            var lv_ret:LoadVars = new LoadVars();
            lv_ret.onData = function(str)
            {
              if (!str || str == undefined)
                return;
              var _is_str_new = false;
              StatLoader.retrieving = false;
              StatLoader.added = false;
              var stats = JSON.parse(str);
              var players_length = stats.players.length;
              for (var i = 0; i < players_length; ++i)
              {
                var p_stat = stats.players[i];
                var p_name = Utils.GetNormalizedPlayerName(p_stat.name);
                if (StatData.s_data[p_name].stat)
                {
                  //Logger.add(p_name + " already in ratings");
                  continue;
                }
                _is_str_new = true;
                //Logger.addObject(p_stat, "Adding to "+p_name+" :");
                StatData.s_data[p_name].stat = StatLoader.CalculateRating(p_stat);
                StatData.s_data[p_name].loaded = true;
                // TODO: Add callback to update GUI
              };
              GlobalEventDispatcher.dispatchEvent({type: "stat_loaded"});

              // If there's no new data submitted, try with @GET_LAST_STAT (FIXME)
              if (!_is_str_new)
              {
                //Logger.add("Nothing new");
                var lv_ret_new:LoadVars = new LoadVars();
                lv_ret_new.onData = function(str_new)
                {
                  if (!str_new || str_new == undefined)
                    return;
                  var stats_new = JSON.parse(str_new);
                  var players_length2 = stats_new.players.length;
                  for (var i = 0; i < players_length2; ++i)
                  {
                    var p_stat_new = stats_new.players[i];
                    var p_name_new = Utils.GetNormalizedPlayerName(p_stat_new.name);
                    if (StatData.s_data[p_name_new].stat)
                    {
                      //Logger.add(p_name_new + " already in ratings");
                      continue;
                    }
                    //Logger.addObject(p_stat_new, "Adding to "+p_name_new+" :");
                    StatLoader.CalculateRating(p_stat_new);
                    StatData.s_data[p_name_new].stat = p_stat_new;
                    StatData.s_data[p_name_new].loaded = true;
                    // TODO: Add callback to update GUI
                  };
                  GlobalEventDispatcher.dispatchEvent({type: "stat_loaded"});
                }
                lv_ret_new.load(Defines.COMMAND_GET_LAST_STAT);
              }
              StatLoader.runningIngame = false;
              StatLoader.retrieving = false;
              if (!StatLoader.added)
                StatLoader.retrieved = true;
            }
            lv_ret.load(Defines.COMMAND_RETRIEVE);
          }
          else
          {
            StatLoader.retrieving = false;
          }
        }
        catch (ex)
        {
          // do nothing
        }
      }
      lv_check.load(Defines.COMMAND_READY);
    }
  }
}