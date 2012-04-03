/**
 * ...
 * @author sirmax2
 * @author johnp
 */
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GraphicsUtil;
import wot.utils.JSON;
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

  private static var _is_new: Boolean = true;
  private static var retrieving: Boolean = false;
  private static var retrieved: Boolean = true;
  private static var runningIngame: Boolean = false;
  private static var added: Boolean = false;
  // so we don't have to create it at function execution:
  // try to retrieve stats after 0.3, 0.5, 1 and 3 seconds
  private static var timer: TimelineLite = new TimelineLite( { tweens: [
    new TweenLite(null, .3), new TweenLite(null, .5),
    new TweenLite(null, 1), new TweenLite(null, 3) ],
    onComplete:Stat.retrieveStatsIngame, onCompleteParams:[],
    paused: true});
  public static function FormatText(data, format: String, isDead: Boolean)
  {
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
      var pname: String = Utils.GetUpperPlayerName(data.label || data.name);
      if (!data.uid || data.uid == undefined)
        data.uid = s_player_data[pname].playerId;
      var stat = Stat.s_player_ratings[pname];

      if (stat)
      {
        if (!stat.notInDb)
        {
          rating = Utils.toInt(stat.rating);
          sRating = rating ? String(rating) + "%" : "--%";

          eff = Utils.toInt(stat.eff);
          sEff = eff ? String(eff) : "--";

          if (rating)
          {
            var bn: Number = Utils.toInt(stat.battles);
            kb = bn > 0 ? Math.round(bn / 1000) : -1;
            sKb = kb >= 0 ? String(kb) + "k" : "";
            sBattles = bn > 0 ? Utils.toString(bn) : "";
            sWins = bn > 0 ? String(Utils.toInt(stat.wins)) : "";
          }
        }
      }
      else if (Config.s_config.rating.loadEnemyStatsInFogOfWar)
        processForFogOfWar(data);
    }

    // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
    format = format.split("{{kb}}").join(sKb);
    format = format.split("{{battles}}").join(sBattles);
    format = format.split("{{wins}}").join(sWins);
    format = format.split("{{rating}}").join(sRating);
    format = format.split("{{eff}}").join(sEff);

    // This code is stupid, and needs to be rewritten
    format = format.split("{{kb:3}}").join(Utils.padLeft(sKb, 3));
    format = format.split("{{rating:3}}").join(Utils.padLeft(sRating, 3));
    format = format.split("{{eff:4}}").join(Utils.padLeft(sEff, 4));

    // Dynamic colors
    format = format.split("{{c:eff}}").join(eff <= 0 ? ""
      : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, eff, "#", isDead));
    format = format.split("{{c:rating}}").join(rating <= 0 ? ""
      : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, rating, "#", isDead));
    format = format.split("{{c:kb}}").join(
      GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, kb, "#", isDead));

    format = Utils.trim(format);

    return format;
  }

  public static function processForFogOfWar(data)
  {
    var pname: String = Utils.GetUpperPlayerName(data.label || data.name);
    if (data.uid && !s_player_names[pname] && !s_player_data[pname])
    {
      try
      {
        parseInt(data.uid);

        // add player data
        s_player_ids.push(data.uid);
        s_player_names.push(pname);
        s_player_data[pname] =
        {
          reference: null,
          playerId: data.uid,
          name: pname,
          originalText: data.vehicle || data.originalText,
          team: data.team == "team1" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY,
          loaded: false
        };

        var str: String = pname + "-" + data.uid;
        var lv: LoadVars = new LoadVars();
        lv.onData = function(success)
        {
          if (!Stat.retrieved || Stat.runningIngame)
            return;
          Stat.runningIngame = true;
          var lv_run = new LoadVars();
          lv_run.onData = function(res)
          {
            Stat._is_new = true;
            Stat.retrieved = false;
            Stat.added = true;
            // try to retrieve stats
            Stat.timer.gotoAndPlay(null);
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
    else
    {
      // just try to load
      retrieveStatsIngame();
    }
  }

  public static function DecorateField(data: Object, txt: String, format: String, ratingPosition: Number)
  {
    if (!s_player_ratings)
      return txt;
    var pname = Utils.GetUpperPlayerName(data.label || data.name);
    var ratingText = Stat.FormatText(data, format, false);
    if (!ratingText || ratingText == "")
      return txt;
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
        try
        {
          //wot.utils.Logger.add("check: "+check)
          if (check == "FINISHED")
          {
            Stat.retrieving = true;
            // retrieve stats from proxy
            var lv_ret:LoadVars = new LoadVars();
            lv_ret.onData = function(str)
            {
              if (!str || str == undefined)
                return;
              var _is_str_new = false;
              Stat.retrieving = false;
              Stat.added = false;
              var stats = JSON.parse(str);
              for (var i = 0; i < stats.players.length; ++i)
              {
                var p_stat = stats.players[i];
                var p_name = Utils.GetUpperPlayerName(p_stat.name);
                if (Stat.s_player_ratings[p_name])
                {
                  //wot.utils.Logger.add(p_name + " already in ratings");
                  continue;
                }
                _is_str_new = true;
                //wot.utils.Logger.addObject(p_stat, "Adding to "+p_name+" :");
                p_stat.rating = p_stat.battles > 0 ? Math.round(p_stat.wins / p_stat.battles * 100) : 0;
                Stat.s_player_ratings[p_name] = p_stat;
                Stat.s_player_data[p_name].loaded = true;
                // TODO: Add callback to update GUI
              };
              // If there's no new data submitted, try with @GET_LAST_STAT (FIXME)
              if (!_is_str_new)
              {
                //wot.utils.Logger.add("Nothing new");
                var lv_ret_new:LoadVars = new LoadVars();
                lv_ret_new.onData = function(str_new)
                {
                  if (!str_new || str_new == undefined)
                    return;
                  var stats_new = JSON.parse(str_new);
                  for (var i = 0; i < stats_new.players.length; ++i)
                  {
                    var p_stat_new = stats_new.players[i];
                    var p_name_new = Utils.GetUpperPlayerName(p_stat_new.name);
                    if (Stat.s_player_ratings[p_name_new])
                    {
                      //wot.utils.Logger.add(p_name_new + " already in ratings");
                      continue;
                    }
                    //wot.utils.Logger.addObject(p_stat_new, "Adding to "+p_name_new+" :");
                    p_stat_new.rating = p_stat_new.battles > 0 ? Math.round(p_stat_new.wins / p_stat_new.battles * 100) : 0;
                    Stat.s_player_ratings[p_name_new] = p_stat_new;
                    Stat.s_player_data[p_name_new].loaded = true;
                    // TODO: Add callback to update GUI
                  };
                }
                lv_ret_new.load(Defines.COMMAND_GET_LAST_STAT);
              }
              Stat.runningIngame = false;
              Stat.retrieving = false;
              if (!Stat.added)
                Stat.retrieved = true;
            }
            lv_ret.load(Defines.COMMAND_RETRIEVE);
          }
          else
          {
            Stat.retrieving = false;
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

  public static function AddPlayerData(reference: Object, playerId: Number, playerName: String,
    originalText: String, vehicleInfo: Object, team: Number)
  {
    if (playerId <= 0 || !playerName)
      return;

    var pname = Utils.GetUpperPlayerName(playerName);
    //wot.utils.Logger.add("AddPlayerData(" + playerName + "): " + pname + " level=" + level);
    if (!s_player_data[pname])
    {
      s_player_ids.push(playerId);
      s_player_names.push(pname);
      s_player_data[pname] = {
        reference: reference,
        playerId: playerId,
        name: pname,
        originalText: originalText,
        vehicleInfo: vehicleInfo,
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
      try
      {
        //wot.utils.Logger.add("lv: "+str);
        if (!str || str == undefined)
          return;
        var stats = JSON.parse(str);
        for (var i = 0; i < stats.players.length; ++i)
        {
          if (!Stat.s_player_ratings)
            Stat.s_player_ratings = {};
          var stat = stats.players[i];

          stat.rating = stat.battles > 0 ? Math.round(stat.wins / stat.battles * 100) : 0;
          Stat.s_player_ratings[stat.name.toUpperCase()] = stat;
        };

        if (stats.info && stats.info.xvm)
        {
          if (_global.xvm_battleloading)
            _global.xvm_battleloading.setInfoFieldData(stats.info.xvm);
        }

        Stat.UpdateAll();
      }
      catch (ex)
      {
        // do nothing
      }
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
        Stat.s_player_names.push(info[0].toUpperCase());
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
        pdata.reference.XVMStatUpdateCallback(pdata);
    }
  }

  /////////////////////////////////////
  
  // Result: { win1, win2, draw }
  public static function GetChances(): Object
  {
    var nally = 0;
    var nenemy = 0;
    for (var i in s_player_names)
    { 
      var pname = s_player_names[i];
      var pdata = s_player_data[pname];
      if (pdata.team == Defines.TEAM_ALLY) ++nally else ++nenemy;
    }

    // only equal and non empty team supported
    if (nally != nenemy || nally == 0)
      return null;

    if (!s_player_ratings)
      return null;

    var tier = guessBattleTier();
      
    // Calculate average efficiency.
    var ae1 = AvgStat("eff", Defines.TEAM_ALLY);
    var ae2 = AvgStat("eff", Defines.TEAM_ENEMY);

    var ar1 = AvgStat("rating", Defines.TEAM_ALLY);
    var ar2 = AvgStat("rating", Defines.TEAM_ENEMY);

    var ab1 = AvgStat("battles", Defines.TEAM_ALLY);
    var ab2 = AvgStat("battles", Defines.TEAM_ENEMY);
    
    var k1 = 0;
    var k2 = 0;
    var m1 = 0;
    var m2 = 0;
    for (var i in s_player_names)
    {
      var pname = s_player_names[i];
      var pdata = s_player_data[pname];
      var eff: Number = s_player_ratings[pname].eff || ((pdata.team == Defines.TEAM_ALLY) ? ae1 : ae2);
      var gwr: Number = (s_player_ratings[pname].rating || ((pdata.team == Defines.TEAM_ALLY) ? ar1 : ar2)) / 100.0;
      var bat: Number = (s_player_ratings[pname].battles || ((pdata.team == Defines.TEAM_ALLY) ? ab1 : ab2)) / 100000.0;
      //wot.utils.Logger.addObject(s_player_ratings[pname], "s_player_ratings[" + pname + "]");

      // 1
      var kx = eff * pdata.vehicleInfo.level;
      if (pdata.team == Defines.TEAM_ALLY) k1 += kx; else k2 += kx;
        
      // 2
      var tx = (pdata.vehicleInfo.tier1 + pdata.vehicleInfo.tier2) / 2.0 - tier;
      var mx = eff * (1 + gwr - 0.48) * (1 + bat) * (1 - 0.25 * tx);
      if (pdata.team == Defines.TEAM_ALLY) m1 += mx else m2 += mx;
      //wot.utils.Logger.add("tx=" + tx + " " + int(eff) + " " + int(gwr) + " " + int(bat));
      //wot.utils.Logger.add("mx=" + mx + " m1=" + m1 + " m2=" + m2 + " team: " + (pdata.team == Defines.TEAM_ALLY ? "ally" : "enemy") + " " + pdata.originalText);
    }

    // 1
    if (k1 == 0 && k2 == 0) k1 = k2 = 1;
    if (k1 == 0) k1 = k2;
    if (k2 == 0) k2 = k1;

    return
    {
      k1: Math.round(k1),
      k2: Math.round(k2),
      k: NormalizeResult(k1, k2),
      k_raw: k1 / (k1 + k2) * 100,

      m1: Math.round(m1),
      m2: Math.round(m2),
      m: NormalizeResult(m1, m2),
      m_raw: m1 / (m1 + m2) * 100
    };
  }

  private static function NormalizeResult(a, b)
  {
    return Math.round(Math.max(0.05, Math.min(0.95, (0.5 + (a / (a + b) - 0.5) * 5.0))) * 10000) / 100.0;
  }

  private static function AvgStat(arg: String, team: Number)
  {
    var v: Number = 0;
    var n: Number = 0;
    for (var i in s_player_names)
    {
      var pname = s_player_names[i];
      var pdata = s_player_data[pname];
      if (pdata.team != team)
        continue;

      var value: Number = s_player_ratings[pname][arg];
      if (!value)
        continue;

      ++n;
      v += value;
    };

    if (!n || !v)
      return 0;
    
    return 1.0 * v / n;
  }

  private static function guessBattleTier(): Number
  {
    var tierLo = 1;
    var tierHi = 13;
    for (var i in s_player_names)
    {
      var pname = s_player_names[i];
      var pdata = s_player_data[pname];

      if (pdata.vehicleInfo.level == 0)
        continue;

      tierLo = Math.max(pdata.vehicleInfo.tier1, tierLo);
      var tiertmp = Math.min(pdata.vehicleInfo.tier2, tierHi);
      if (tiertmp >= tierLo)
        tierHi = tiertmp;
      //wot.utils.Logger.add("tiers: " + tierLo + ".." + tierHi + " " + pdata.originalText);
      if (tierLo == tierHi)
        return tierLo;
    };
    
    //wot.utils.Logger.add("avg tier: " + (tierHi + tierLo ) / 2.0);
    return (tierHi + tierLo ) / 2.0;
  }
}
