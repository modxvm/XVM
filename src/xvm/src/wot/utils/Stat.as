/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Defines;

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
    return isNaN(value) ? 0 : Number(value);
  }
  
  public static function ToString(value: Number)
  {
    return value ? String(value) : "";
  }

  public static function FormatText(playerName: String, format: String)
  {
    var sWins: String = "";
    var sBattles: String = "";
    var sKb: String = "";
    var sRating: String = "";
    var sEff: String = "";

    var eff: Number = 0;
    var rating: Number = 0;
    var kb: Number = 0;
    
    if (Stat.s_player_ratings)
    {
      var pname: String = Stat.CleanPlayerName(playerName).toUpperCase();
      var stat = Stat.s_player_ratings[pname];
      if (stat)
      {
        rating = ToNumber(stat.rating);
        sRating = rating ? String(rating) + "%" : "";

        eff = ToNumber(stat.eff);
        sEff = ToString(eff);

        if (rating && eff)
        {
          var bn: Number = ToNumber(stat.battles);
          kb = bn > 0 ? Math.round(bn / 1000) : 0;
          sKb = kb >= 0 ? String(kb) + "k" : "";
          sBattles = ToString(bn);
          sWins = bn >= 0 ? String(ToNumber(stat.wins)) : "";
        }
      }
    }

    // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
    format = format.split("{{kb}}").join(sKb);
    format = format.split("{{battles}}").join(sBattles);
    format = format.split("{{wins}}").join(sWins);
    format = format.split("{{rating}}").join(sRating);
    format = format.split("{{eff}}").join(sEff);

    format = format.split("{{c:eff}}").join(eff > 0 ? GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, eff) : "");
    format = format.split("{{c:rating}}").join(rating > 0 ? GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, rating) : "");
    format = format.split("{{c:kb}}").join(GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, kb));

    format = wot.utils.Utils.trim(format);

    return format;
  }
  
  public static function DecorateField(playerName: String, txt: String, format: String, ratingPosition: Number)
  {
    if (!s_player_ratings)
      return txt;
    var pname = CleanPlayerName(playerName).toUpperCase();
    var ratingText = Stat.FormatText(playerName, format);
    return (ratingPosition == Defines.POSITION_LEFT)
      ? ratingText + " " + txt
      : txt + " " + ratingText;
  }

  // Logic functions

  public static function AddPlayerData(reference: Object, playerId: Number, playerName: String,
    originalText: String, team: Number)
  {
    if (playerId <= 0 || !playerName)
      return;

    var pname = CleanPlayerName(playerName);
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
      //wot.utils.Logger.add(str);
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
    var lv= new LoadVars();
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
    //Logger.add("Stat.UpdateAll()");

    for (var pname in s_player_data)
    {
      var pdata = s_player_data[pname];
      pdata.reference.updateCallback(pdata);
    }
  }

}
