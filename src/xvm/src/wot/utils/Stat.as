/**
 * ...
 * @author sirmax2
 * @author johnp
 */
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Utils;

class wot.utils.Stat
{
  // Config
  public static var s_player_ids = [];
  public static var s_player_names = [];
  public static var s_player_data = {};
  public static var s_player_ratings = null;
  public static var s_loadDataStarted = false;
  public static var s_loaded = false;

  // Misc functions

  public static function CleanPlayerName(str)
  {
    str = str.toLowerCase();
    var pos = str.indexOf("[");
    return pos === -1 ? str : str.slice(0, pos);
  }

  public static function GetDynamicColorValue(type: Number, value: Number)
  {
    if (value == undefined || value == null)
      return "#FFFBFB";

    var path: String = "rating/colors/";
    switch (type)
    {
      case Defines.DYNAMIC_COLOR_EFF:
        path += "eff";
        break;
      case Defines.DYNAMIC_COLOR_RATING:
        path += "rating";
        break;
      case Defines.DYNAMIC_COLOR_KB:
        path += "kb";
        break;
      default:
        return "#FFFEFE";
    }

    var cfg: Array = Config.value(path);
    if (!cfg)
      return "#FFFDFD";
    for (var i = 0; i < cfg.length; i++)
    {
      var cvalue: Number = Number(cfg[i]["value"]);
      var color: Number = Number(String(cfg[i]["color"]));
      if (!cvalue || !color)
        return "#FFFCFC";
      if (value < cvalue)
        return "#" + color.toString(16);
    }

    return "#FFFFFF";
  }

  public static function ToNumber(value)
  {
    var n: Number = parseInt(value);
    return isNaN(n) ? 0 : n;
  }

  public static function ToString(value: Number)
  {
    return value ? String(value) : "";
  }

  private static var _is_new: Boolean = true;
  private static var retrieving: Boolean = false;
  private static var retrieved: Boolean = true;
  private static var runningIngame: Boolean = false;
  private static var added: Boolean = false;
  // so we don't have to create it at function execution
  private static var timer: TimelineLite = new TimelineLite( { onComplete:Stat.retrieveStatsIngame, onCompleteParams:[] } );
  public static function FormatText(data, format: String)
  {
    //wot.utils.Logger.add("FormatText(): " + data.label + " " + data.name);
    var sWins: String = "";
    var sBattles: String = "";
    var sKb: String = "";
    var sRating: String = "";
    var sEff: String = "";

    var eff: Number = 0;
    var rating: Number = 0;
    var kb: Number = -1;

    if (Stat.s_player_ratings)
    {
      var pname: String = Stat.CleanPlayerName(data.label || data.name).toUpperCase();
      if (!data.uid || data.uid == undefined)
        data.uid = s_player_data[pname].playerId;
      var stat = Stat.s_player_ratings[pname];
      if (stat)
      {
        //wot.utils.Logger.add("stats available");
        //if (stat.notInDb)
        //  wot.utils.Logger.add(pname+" is not in Database.");;
        rating = ToNumber(stat.rating);
        sRating = rating ? String(rating) + "%" : "--%";

        eff = ToNumber(stat.eff);
        sEff = eff ? String(eff) : "--";

        if (rating)
        {
          var bn: Number = ToNumber(stat.battles);
          kb = bn > 0 ? Math.round(bn / 1000) : -1;
          sKb = kb >= 0 ? String(kb) + "k" : "";
          sBattles = bn > 0 ? ToString(bn) : "";
          sWins = bn > 0 ? String(ToNumber(stat.wins)) : "";
        }
      }
      else if (Config.bool("rating/loadEnemyStatsInFogOfWar"))
        processForFogOfWar(data);
    }

    // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
    format = format.split("{{kb}}").join(sKb);
    format = format.split("{{battles}}").join(sBattles);
    format = format.split("{{wins}}").join(sWins);
    format = format.split("{{rating}}").join(sRating);
    format = format.split("{{eff}}").join(sEff);

    // This code is stupid, and need to be rewritten
    format = format.split("{{kb:3}}").join(Utils.padLeft(sKb, 3));
    format = format.split("{{rating:3}}").join(Utils.padLeft(sRating, 3));
    format = format.split("{{eff:4}}").join(Utils.padLeft(sEff, 4));

    // Dynamic colors
    format = format.split("{{c:eff}}").join(eff > 0 ? GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, eff) : "");
    format = format.split("{{c:rating}}").join(rating > 0 ? GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, rating) : "");
    format = format.split("{{c:kb}}").join(GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, kb));

    format = wot.utils.Utils.trim(format);

    return format;
  }

  public static function processForFogOfWar(data)
  {
    //wot.utils.Logger.add("processFogOfWar");

    var pname: String = Stat.CleanPlayerName(data.label || data.name).toUpperCase();
    if (data.uid && s_player_names[pname] == undefined && !s_player_names[pname] &&
      s_player_data[pname] == undefined && !s_player_data[pname] &&
      !s_player_data.contains(pname))
    {
      //wot.utils.Logger.add("fix: "+data.uid);
      try
      {
        parseInt(data.uid);

        // add player data
        s_player_ids.push(data.uid);
        s_player_names.push(pname);
        var team = (data.team == "team1") ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY;
        s_player_data[pname] =
        {
          reference: null,
          playerId: data.uid,
          name: pname,
          originalText: (data.vehicle != undefined) ? data.vehicle : data.originalText,
          team: team,
          loaded: false
        };

        var str: String = pname + "-" + data.uid;
        var lv:LoadVars = new LoadVars();
        lv.onData = function(success)
        {
          //wot.utils.Logger.addObject(success, "lv add");
          if (!Stat.retrieved)
          {
            //wot.utils.Logger.add("not retrieved !");
            return;
          }
          if (Stat.runningIngame)
            return;
          Stat.runningIngame = true;
          var lv_run = new LoadVars();
          lv_run.onData = function(res)
          {
            //wot.utils.Logger.addObject(res, "lv_run add");
            Stat._is_new = true;
            Stat.retrieved = false;
            Stat.added = true;
            // Load Stats after 1 sec
            Stat.timer.insert(new TweenLite(null, 1));
          }
          lv_run.load(Defines.COMMAND_RUNINGAME);
        }
        var cmd = _is_new ? Defines.COMMAND_SET : Defines.COMMAND_ADD;
        _is_new = false;
        lv.load(cmd + " " + str);
      }
      catch (FormatException)
      {
        //wot.utils.Logger.add(data.uid + " is not a uid!");
      }
    }
    else if (data.uid && s_player_names[pname] != undefined && s_player_data[pname] != undefined)
    {
      // didn't get ratings for them, but not notInDb -> try to load again
      var str: String = pname + "-" + data.uid;
      var lv:LoadVars = new LoadVars();
      lv.onData = function(success)
      {
        //wot.utils.Logger.addObject(success, "lv add");
        if (!Stat.retrieved)
        {
          //wot.utils.Logger.add("not retrieved yet!");
          return;
        }
        if (Stat.runningIngame)
        {
          //wot.utils.Logger.add("already running!");
          return;
        }
        Stat.runningIngame = true;
        var lv_run = new LoadVars();
        lv_run.onData = function(res)
        {
          //wot.utils.Logger.addObject(res, "lv_run add");
          Stat._is_new = true;
          Stat.retrieved = false;
          // Load Stats after 1 sec
          //var timer: TimelineLite = new TimelineLite({onComplete:Stat.retrieveStatsIngame, onCompleteParams:[]});
          Stat.timer.insert(new TweenLite(null, 1));
        }
        lv_run.load(Defines.COMMAND_RUNINGAME);
      }
      var cmd = _is_new ? Defines.COMMAND_SET : Defines.COMMAND_ADD;
      _is_new = false;
      lv.load(cmd + " " + str);
    }
    else
    {
      retrieveStatsIngame();
      //wot.utils.Logger.add("DEBUG: "+pname+" - "+data.uid);
      //wot.utils.er.add("retrieving: "+retrieving);
      //wot.utils.Logger.add("retrieved: "+retrieved);
      //wot.utils.Logger.add("runningIngame: "+runningIngame);
    }
  }

  public static function DecorateField(data: Object, txt: String, format: String, ratingPosition: Number)
  {
    if (!s_player_ratings)
      return txt;
    var pname = CleanPlayerName((data.label != undefined) ? data.label : data.name).toUpperCase();
    var ratingText = Stat.FormatText(data, format);
    return (ratingPosition == Defines.POSITION_LEFT)
      ? ratingText + " " + txt
      : txt + " " + ratingText;
  }

  // Logic functions

  private static function retrieveStatsIngame()
  {
    if (!retrieving && ! retrieved)
    {
      // retrieve stats
      //wot.utils.Logger.add("Retrieve stats");
      retrieving = true;

      // check if retrieving stats from server finished
      var lv_check:LoadVars = new LoadVars();
      lv_check.onData = function(check)
      {
        //wot.utils.Logger.add("check: "+check)
        if (check == "FINISHED")
        {
          // not running, but catching before getting would be a fail
          //Stat.runningIngame = false;

          // retrieve stats from proxy
          var lv_ret:LoadVars = new LoadVars();
          lv_ret.onData = function(str)
          {
            var _is_str_new = false;
            Stat.retrieving = false;
            Stat.added = false;
            if (!str || str == undefined)
              return;
            var stats = net.wargaming.io.JSON.parse(str);
            //wot.utils.Logger.add("lv retrieve");
            for (var i = 0; i < stats.players.length; i++)
            {
              var p_stat = stats.players[i];
              var p_name = Stat.CleanPlayerName(p_stat.name).toUpperCase();
              if (Stat.s_player_ratings[p_name] != undefined)
              {
                //wot.utils.Logger.add(p_name + " already in ratings");
                continue;
              }
              _is_str_new = true;
              //wot.utils.Logger.addObject(p_stat, "Adding to "+p_name+" :");
              p_stat.rating = p_stat.battles > 0 ? Math.round(p_stat.wins / p_stat.battles * 100) : 0;
              Stat.s_player_ratings[p_name] = p_stat;
              Stat.s_player_data[p_name].loaded = true;
            };

            // If there's no new data submitted, try with @GET_LAST_STAT
            if (!_is_str_new)
            {
              //wot.utils.Logger.add("Nothing new");
              var lv_ret_new:LoadVars = new LoadVars();
              lv_ret_new.onData = function(str_new)
              {
                if (!str_new || str_new == undefined)
                  return;
                var stats_new = net.wargaming.io.JSON.parse(str_new);
                //wot.utils.Logger.add("lv retrieve_new");
                for (var i = 0; i < stats_new.players.length; i++)
                {
                  var p_stat_new = stats_new.players[i];
                  var p_name_new = Stat.CleanPlayerName(p_stat_new.name).toUpperCase();
                  if (Stat.s_player_ratings[p_name_new] != undefined)
                  {
                    //wot.utils.Logger.add(p_name_new + " already in ratings");
                    continue;
                  }
                  //wot.utils.Logger.addObject(p_stat_new, "Adding to "+p_name_new+" :");
                  p_stat_new.rating = p_stat_new.battles > 0 ? Math.round(p_stat_new.wins / p_stat_new.battles * 100) : 0;
                  Stat.s_player_ratings[p_name_new] = p_stat_new;
                  Stat.s_player_data[p_name_new].loaded = true;
                };
              }
              lv_ret_new.load(Defines.COMMAND_GET_LAST_STAT);
            }
            Stat.runningIngame = false;
            Stat.retrieving = false;
            if (!Stat.added)
              Stat.retrieved = true;
            // TODO: Add callback to update GUI
            //Stat.UpdateAll();
          }
          lv_ret.load(Defines.COMMAND_RETRIEVE);
        }
        else
        {
          Stat.retrieving = false;
        }
      }
      lv_check.load(Defines.COMMAND_READY);
    }
  }

  public static function AddPlayerData(reference: Object, playerId: Number, playerName: String,
    originalText: String, team: Number)
  {
    if (playerId <= 0 || !playerName)
      return;

    var pname = CleanPlayerName(playerName);
    //wot.utils.Logger.add("AddPlayerData("+playerName+"): "+pname);
    if (!s_player_data[pname])
    {
      s_player_ids.push(playerId);
      s_player_names.push(pname);
      s_player_data[pname] = {
        reference: reference,
        playerId: playerId,
        name: pname,
        originalText: originalText,
        team: team,
        loaded: false
      };
    }
  }

  public static function StartLoadData()
  {
    //wot.utils.Logger.add("Stat.StartLoadData(): "+ s_loadDataStarted);
    if (s_loadDataStarted)
      return;
    s_loadDataStarted = true;
    LoadData();
  }

  private static var _s_isNew = true;
  private static function LoadData()
  {
    //wot.utils.Logger.add("Stat.LoadData()");

    var is_new = _s_isNew;
    _s_isNew = false;

    var players_to_load = [];
    var len = 0;
    for (var pname in s_player_data)
    {
      var pdata = s_player_data[pname];
      if (!pdata.loaded)
      {
        var str: String = pname + "-" + String(pdata.playerId);
        if (len + str.length > Defines.MAX_PATH)
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
        Stat.LoadData();
      }
      var fn = is_new ? Defines.COMMAND_SET : Defines.COMMAND_ADD;
      lv.load(fn + " " + players_to_load.join(","));
    }
    else
    {
      LoadStatData(Defines.COMMAND_RUN);
    }
  }

  public static function LoadStatData(command)
  {
    if (s_loaded)
      return;
    s_loaded = true;

    var lv:LoadVars = new LoadVars();
    lv.onData = function(str)
    {
      //wot.utils.Logger.add("lv: "+str);
      var stats = net.wargaming.io.JSON.parse(str);
      for (var i = 0; i < stats.players.length; i++)
      {
        if (!Stat.s_player_ratings)
          Stat.s_player_ratings = {};
        var stat = stats.players[i];

        stat.rating = stat.battles > 0 ? Math.round(stat.wins / stat.battles * 100) : 0;
        Stat.s_player_ratings[stat.name.toUpperCase()] = stat;
      };

      if (stats.info && stats.info.xvm)
        wot.BattleLoading.setInfoFieldData(stats.info.xvm);

      Stat.UpdateAll();
    };
    lv.load(command);
  }

  public static function LoadPlayerInfo()
  {
    var lv = new LoadVars();
    lv.onLoad = function(success)
    {
      if (!success)
        return;
      Stat.s_player_ids = [];
      Stat.s_player_names = [];
      var playerInfo = this.split(",");
      for (var pi in playerInfo)
      {
        var info = (playerInfo[pi]).split("-");
        Stat.s_player_names.push(info[0]);
        Stat.s_player_ids.push(info[1]);
      }
    };
    lv.load(Defines.COMMAND_GET);
  }

  private static function UpdateAll()
  {
    //wot.utils.Logger.add("Stat.UpdateAll()");

    for (var pname in s_player_data)
    {
      var pdata = s_player_data[pname];
      if (pdata.reference)
        pdata.reference.updateCallback(pdata);
    }
  }

}
