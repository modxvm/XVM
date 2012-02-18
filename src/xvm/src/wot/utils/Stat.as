/**
 * ...
 * @author sirmax2
 */
import wot.utils.Defines;

class wot.utils.Stat
{
  // Config
  public static var s_player_ids = [];
  public static var s_player_names = [];
  public static var s_player_data = {};
  public static var s_player_ratings = null;
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
    if (!value || value == 0)
      return "#FFFFFF";

    var color: Number = 0xFFFFFF;
    switch (type)
    {
      case Defines.DYNAMIC_COLOR_EFF:
        color =
          (value < 600) ? 0x990000 :
          (value < 900) ? 0xCC0000 :
          (value < 1200) ? 0xFF6633 :
          (value < 1500) ? 0x99FF33 :
          (value < 1800) ? 0x33FF33 :
          0x660066;
        break;
        
      case Defines.DYNAMIC_COLOR_RATING:
        color =
          (value < 49) ? 0xFF0000 :
          (value < 51) ? 0xFFFF00 :
          0x00FF00;
        break;
      
      case Defines.DYNAMIC_COLOR_KB:
        color =
          (value < 1) ? 0x33FF33 :
          (value < 3) ? 0x99FF33 :
          (value < 5) ? 0xFF6633 :
          (value < 8) ? 0xCC0000 :
          (value < 12) ? 0x990000 :
          0x660066;
        break;
    }
    
    return "#" + color.toString(16);
  }

  public static function GetDynamicColorFormat(format: String, value: Number)
  {
  }
  
  /*public static function GetColorHtmlText(num: Number, txt: String)
  {
    if (!num)
      return txt;

    if (Config.value("rating/playersPanel/colorizeType") == "{{c:rating}}") {
      var rating = Stat.s_player_ratings[pname.toUpperCase()].rating;
      if (rating) {
        var color = (rating < 49) ? 0xFF0000 : ((rating < 51) ? 0xFFFF00 : 0x00FF00);
      }
    } else if (Config.value("rating/playersPanel/colorizeType") == "{{c:eff}}") {
      var eff = Stat.s_player_ratings[pname.toUpperCase()].eff;
      if (eff) {
         var color = (eff < 1800) ? 0x33FF33  : (eff < 1500) ? 0x99FF33  : (eff < 1200) ? 
                      0xFF6633 : (eff < 900) ? 0xCC0000) : (eff < 600) ? 0x990000 : 0x660066;
      }
    } else if (Config.value("rating/playersPanel/colorizeType") == "{{c:kb}}") {
      var kb = Stat.s_player_ratings[pname.toUpperCase()].kb;
      if (kb) {
        var color = (kb < 1) ? 0x33FF33  : (kb < 3) ? 0x99FF33  : (kb < 5) ? 
                      0xFF6633 : (kb < 8) ? 0xCC0000) : (kb < 12) ? 0x990000 : 0x660066;
      }
    } else {
      var color = 0xFFFFFF;
    }
    
    return ("<font color=\'#" + color.toString(16) + "\'>" + txt + "</font>");
  }*/

  public static function FormatText(playerName: String, format: String)
  {
    // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
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
      
      var bn: Number = Number(Stat.s_player_ratings[pname].battles);
      kb = bn > 0 ? Math.round(bn / 1000) : 0;
      sKb = kb > 0 ? String(kb) + "k" : "";
      sBattles = bn > 0 ? String(bn) : "";
      sWins = bn > 0 ? String(Number(Stat.s_player_ratings[pname].wins)) : "";

      rating = Number(Stat.s_player_ratings[pname].rating);
      sRating = rating ? String(rating) + "%" : "";

      eff = Number(Stat.s_player_ratings[pname].eff);
      sEff = eff != 0 ? String(eff) : "";
    }

    format = format.split("{{kb}}").join(sKb);
    format = format.split("{{battles}}").join(sBattles);
    format = format.split("{{wins}}").join(sWins);
    format = format.split("{{rating}}").join(sRating);
    format = format.split("{{eff}}").join(sEff);

    format = format.split("{{c:eff}}").join(GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, eff));
    format = format.split("{{c:rating}}").join(GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, rating));
    format = format.split("{{c:kb}}").join(GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, kb));

    format = wot.utils.Utils.trim(format);

    return format;
  }
  
  public static function DecorateField(playerName: String, txt: String, format: String, ratingPosition: Number)
  {
    if (!s_player_ratings)
      return txt;
    var pname = CleanPlayerName(playerName).toUpperCase();
    var rating = Stat.s_player_ratings[pname].rating;
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

  private static var _s_isNew = true;
  public static function LoadData()
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
