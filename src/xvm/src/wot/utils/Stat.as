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
import wot.utils.Locale;
import wot.utils.Logger;
import wot.utils.Utils;
import wot.utils.VehicleInfo;

  // s_player_data members:
  //   reference: Object,
  //   updateFunc: Function,
  //   playerId: Number,
  //   fullPlayerName: fullPlayerName,
  //   name: String,
  //   clan: String,
  //   originalText: String,
  //   icon: String,
  //   vehicleName: String,
  //   team: Defines.TEAM_ALLY | Defines.TEAM_ENEMY,
  //   loaded: Boolean

  // s_player_ratings members:
  //   battles
  //   wins
  //   rating
  //   eff
  //   t_battles
  //   t_wins
  //   t_rating

class wot.utils.Stat
{
  // Config
  public static var s_player_ids = [];
  public static var s_player_names: Array = [];
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
    var sTWins: String = "";
    var sTBattles: String = "";
    var sTKb: String = "";
    var sTRating: String = "";

    var eff: Number = 0;
    var rating: Number = 0;
    var kb: Number = -1;
    var t_rating: Number = 0;
    var t_kb: Number = -1;

    if (Stat.s_player_ratings)
    {
      var pname: String = Utils.GetNormalizedPlayerName(data.label || data.name);
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

          t_rating = Utils.toInt(stat.t_rating);
          sTRating = t_rating ? String(t_rating) + "%" : "--%";

          if (t_rating)
          {
            var bn: Number = Utils.toInt(stat.t_battles);
            t_kb = bn > 0 ? Math.round(bn / 100) / 10 : -1;
            sTKb = t_kb >= 0 ? String(t_kb) + "k" : "";
            sTBattles = bn > 0 ? Utils.toString(bn) : "";
            sTWins = bn > 0 ? String(Utils.toInt(stat.t_wins)) : "";
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

    format = format.split("{{t-kb}}").join(sTKb);
    format = format.split("{{t-battles}}").join(sTBattles);
    format = format.split("{{t-wins}}").join(sTWins);
    format = format.split("{{t-rating}}").join(sTRating);

    // This code is stupid, and needs to be rewritten
    format = format.split("{{kb:3}}").join(Utils.padLeft(sKb, 3));
    format = format.split("{{rating:3}}").join(Utils.padLeft(sRating, 3));
    format = format.split("{{eff:4}}").join(Utils.padLeft(sEff, 4));

    format = format.split("{{t-kb:4}}").join(Utils.padLeft(sTKb, 4));
    format = format.split("{{t-rating:3}}").join(Utils.padLeft(sTRating, 3));

    // Dynamic colors
    format = format.split("{{c:eff}}").join(eff < 0 ? ""
      : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, eff, "#", isDead));
    format = format.split("{{c:rating}}").join(rating < 0 ? ""
      : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, rating, "#", isDead));
    format = format.split("{{c:kb}}").join(
      GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, kb, "#", isDead));

    format = format.split("{{c:t-rating}}").join(rating < 0 ? ""
      : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, t_rating, "#", isDead));
    format = format.split("{{c:t-kb}}").join(
      GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, t_kb, "#", isDead));

    format = Utils.trim(format);

    return format;
  }

  public static function DecorateField(data: Object, txt: String, format: String, ratingPosition: Number)
  {
    if (!s_player_ratings)
      return txt;
    //Logger.add("DecorateField: " + data.label + " / " + data.name);
    var pname = Utils.GetNormalizedPlayerName(data.label || data.name);
    var ratingText = Stat.FormatText(data, format, false);
    if (!ratingText || ratingText == "")
      return txt;
    return (ratingPosition == Defines.POSITION_LEFT)
      ? ratingText + " " + txt
      : txt + " " + ratingText;
  }

  // Logic functions

  public static function processForFogOfWar(data)
  {
    var fullPlayerName = data.label || data.name;
    var pname: String = Utils.GetNormalizedPlayerName(fullPlayerName);
    var clan: String = Utils.GetClanName(fullPlayerName);
    if (data.uid && !s_player_names[pname] && !s_player_data[pname])
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
        //Logger.add(data.uid + " is not a uid!");
      }
    }
    else
    {
      // just try to load
      retrieveStatsIngame();
    }
  }

  private static function retrieveStatsIngame()
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
            Stat.retrieving = true;
            // stop timer execution
            Stat.timer.stop();
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
                var p_name = Utils.GetNormalizedPlayerName(p_stat.name);
                if (Stat.s_player_ratings[p_name])
                {
                  //Logger.add(p_name + " already in ratings");
                  continue;
                }
                _is_str_new = true;
                //Logger.addObject(p_stat, "Adding to "+p_name+" :");
                Stat.CalculateRating(p_stat);
                Stat.s_player_ratings[p_name] = p_stat;
                Stat.s_player_data[p_name].loaded = true;
                // TODO: Add callback to update GUI
              };
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
                  for (var i = 0; i < stats_new.players.length; ++i)
                  {
                    var p_stat_new = stats_new.players[i];
                    var p_name_new = Utils.GetNormalizedPlayerName(p_stat_new.name);
                    if (Stat.s_player_ratings[p_name_new])
                    {
                      //Logger.add(p_name_new + " already in ratings");
                      continue;
                    }
                    //Logger.addObject(p_stat_new, "Adding to "+p_name_new+" :");
                    Stat.CalculateRating(p_stat_new);
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

  public static function AddPlayerData(reference: Object, updateFunc: Function,
    playerId: Number, playerName: String, originalText: String, icon: String, team: Number)
  {
    if (playerId <= 0 || !playerName)
      return;

    var pname = Utils.GetNormalizedPlayerName(playerName);
    var clan = Utils.GetClanName(playerName);
    //Logger.add("AddPlayerData(" + playerName + "): " + pname + " level=" + level);
    if (!s_player_data[pname])
    {
      s_player_ids.push(playerId);
      s_player_names.push(pname);
      s_player_data[pname] = {
        reference: reference,
        updateFunc: updateFunc,
        playerId: playerId,
        fullPlayerName: playerName,
        name: pname,
        clan: clan,
        originalText: originalText,
        icon: icon,
        vehicleName: VehicleInfo.getShortName(icon),
        team: team,
        loaded: false
      };
    }
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
    for (var pname in s_player_data)
    {
      var pdata = s_player_data[pname];
      if (!pdata.loaded)
      {
        var str: String = String(pdata.playerId) + "=" + pdata.fullPlayerName + "&" + pdata.vehicleName;
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
        Stat.LoadData();
      }
      lv.load(command + players_to_load.join(","));
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
        //Logger.add("lv: "+str);
        if (!str || str == undefined)
          return;
        var stats = JSON.parse(str);

        for (var i = 0; i < stats.players.length; ++i)
        {
          if (!Stat.s_player_ratings)
            Stat.s_player_ratings = {};
          var stat = stats.players[i];
          Stat.CalculateRating(stat);
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

  public static function CalculateRating(data)
  {
    data.rating = data.battles > 0 ? Math.round(data.wins / data.battles * 100) : 0;

    var t_rating = data.t_battles > 0 ? Math.round(data.t_wins / data.t_battles * 100) : 0;

    var pdata = s_player_data[data.name.toUpperCase()];
    var vi = VehicleInfo.getInfo(pdata.icon);
    if (!vi || vi.level == 0)
      data.t_rating = 0;
    else
      data.t_rating = data.rating - (data.rating - t_rating) * data.t_battles / (vi.level * 10);

    Logger.addObject(data);
  }
  
  private static function UpdateAll()
  {
    //Logger.add("Stat.UpdateAll()");

    for (var pname in s_player_data)
    {
      var pdata = s_player_data[pname];
      if (pdata.reference && pdata.updateFunc)
        pdata.updateFunc.call(pdata.reference, pdata);
    }
  }

  /////////////////////////////////////

  // Result: { win1, win2, draw }
  public static function GetChances(): Object
  {
    Logger.dummy();

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
    //Logger.add("tier: " + tier);

    // Calculate average efficiency.
    var ae1 = AvgStat("eff", Defines.TEAM_ALLY);
    var ae2 = AvgStat("eff", Defines.TEAM_ENEMY);

    var ar1 = AvgStat("rating", Defines.TEAM_ALLY);
    var ar2 = AvgStat("rating", Defines.TEAM_ENEMY);

    var ab1 = AvgStat("battles", Defines.TEAM_ALLY);
    var ab2 = AvgStat("battles", Defines.TEAM_ENEMY);

    var art1 = AvgStat("t_rating", Defines.TEAM_ALLY);
    var art2 = AvgStat("t_rating", Defines.TEAM_ENEMY);

    var abt1 = AvgStat("t_battles", Defines.TEAM_ALLY);
    var abt2 = AvgStat("t_battles", Defines.TEAM_ENEMY);
    //Logger.add(ae1 + " " + ae2 + " - " + ar1 + " " + ar2 + " - " + ab1 + " " + ab2);

    var m1 = 0;
    var m2 = 0;
    var mt1 = 0;
    var mt2 = 0;
    for (var i in s_player_names)
    {
      var pname = s_player_names[i];
      var pdata = s_player_data[pname];

      var vi = VehicleInfo.getInfo(pdata.icon);

      if (!vi || vi.level == 0)
        return { error: "No data for: " + VehicleInfo.getName(pdata.icon) };

      var eff: Number = s_player_ratings[pname].eff || ((pdata.team == Defines.TEAM_ALLY) ? ae1 : ae2);
      var gwr: Number = (s_player_ratings[pname].rating || ((pdata.team == Defines.TEAM_ALLY) ? ar1 : ar2)) / 100.0;
      var bat: Number = (s_player_ratings[pname].battles || ((pdata.team == Defines.TEAM_ALLY) ? ab1 : ab2)) / 100000.0;
      var gwrt: Number = (s_player_ratings[pname].t_rating || ((pdata.team == Defines.TEAM_ALLY) ? art1 : art2)) / 100.0;
      var batt: Number = (s_player_ratings[pname].t_battles || ((pdata.team == Defines.TEAM_ALLY) ? abt1 : abt2)) / 1000.0;
      //Logger.addObject(s_player_ratings[pname], "s_player_ratings[" + pname + "]");

      var tx = (vi.tiers[0] + vi.tiers[1]) / 2.0 - tier;
      var mx = eff * (1 + gwr - 0.48) * (1 + bat) * (1 + 0.25 * tx);
      var mxt = eff * (1 + gwrt - 0.48) * (1 + batt) * (1 + 0.25 * tx);
      if (pdata.team == Defines.TEAM_ALLY) m1 += mx else m2 += mx;
      if (pdata.team == Defines.TEAM_ALLY) mt1 += mxt else mt2 += mxt;
      //Logger.add("mx=" + mx + " tx=" + tx + " eff=" + int(eff) + " gwr=" + int(gwr) + " kb=" + int(bat));
      //Logger.add("m1=" + m1 + " m2=" + m2 + " team: " + (pdata.team == Defines.TEAM_ALLY ? "ally" : "enemy") + " " + pdata.originalText);
    }

    if (m1 == 0 && m2 == 0) m1 = m2 = 1;
    if (m1 == 0) m1 = m2;
    if (m2 == 0) m2 = m1;
    //Logger.add("m1=" + Math.round(m1) + " m2=" + Math.round(m2));

    if (mt1 == 0 && mt2 == 0) mt1 = mt2 = 1;
    if (mt1 == 0) mt1 = mt2;
    if (mt2 == 0) mt2 = mt1;

    return
    {
      m1: Math.round(m1),
      m2: Math.round(m2),
      m: NormalizeResult(m1, m2),
      m_raw: m1 / (m1 + m2) * 100,

      mt1: Math.round(mt1),
      mt2: Math.round(mt2),
      mt: NormalizeResult(mt1, mt2),
      mt_raw: mt1 / (mt1 + mt2) * 100
    };
  }

  private static function NormalizeResult(a, b)
  {
    return Math.round(Math.max(0.05, Math.min(0.95, (0.5 + (a / (a + b) - 0.5) * 5.0))) * 100);
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
    var vis = [];
    for (var i = 0; i < s_player_names.length; ++i)
    {
      var pdata = s_player_data[s_player_names[i]];
      var vi = VehicleInfo.getInfo(pdata.icon);
      if (!vi || vi == 0)
        return 0;
      vis.push(vi);
    }

    // 1. Find top tank tiers
    var tierMin = 1;
    var tierMax = 1;
    for (var i = 0; i < vis.length; ++i)
    {
      var vi = vis[i];
      if (vi.tiers[1] < tierMax)
        continue;
      if (vi.tiers[1] > tierMax)
      {
        tierMax = vi.tiers[1];
        tierMin = vi.tiers[0];
        continue;
      }
      if (vi.tiers[0] > tierMin)
        tierMin = vi.tiers[0];
    }
    //Logger.add("tiers=" + tierMin + ".." + tierMax);

    for (var i = 0; i < vis.length; ++i)
    {
      var vi = vis[i];
      if (vi.tiers[1] < tierMin)
        continue;
      if (vi.tiers[1] == tierMin)
        return tierMin;
      tierMax = Math.min(vi.tiers[1], tierMax);
      //Logger.add("tiers=" + tierMin + ".." + tierMax);
    }

    //Logger.add("avg tier: " + (tierMax + tierMin) / 2.0);
    return (tierMax + tierMin) / 2.0;
  }

  public static function ShowChances(tf: TextField): String
  {
    var chances = Stat.GetChances();
    if (chances != null)
    {
      tf.html = true;
      if (chances.error)
        tf.htmlText = tf.text + " | <font color='#FF8080'> " + Locale.get("Chances error") + ": " + chances.error + "</font>";
      else
      {
        var color = GraphicsUtil.brightenColor(
          Number(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, chances.m_raw, "0x")), 50);
        tf.htmlText = tf.text +
          " <font color='#" + color.toString(16) + "'>" +
          "/ " + Locale.get("Win chances") + ": " +
          Locale.get("Global") + ": " + chances.m + "%" + ", " +
          Locale.get("By tank") + ": " + chances.mt + "%</font>";
      }
    }
    return tf.htmlText;
  }
}
