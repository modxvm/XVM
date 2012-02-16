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

  public static function GetColorHtmlText(percent: Number, txt: String)
  {
    if (!percent)
      return txt;

    var color = (percent < 49) ? 0xFF0000 : ((percent < 51) ? 0xFFFF00 : 0x00FF00);
    return ("<font color=\'#" + color.toString(16) + "\'>" + txt + "</font>");
  }

  public static function FormatText(playerName, format)
  {
    // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
    var wins = "";
    var battles = "";
    var kb = "";
    var strRating = "";
    var eff = "";
    if (Stat.s_player_ratings)
    {
      var pname = Stat.CleanPlayerName(playerName).toUpperCase();
      var bn = Stat.s_player_ratings[pname].battles;
      kb = Math.round(bn / 1000) + "k";
      battles = String(bn);
      wins = Stat.s_player_ratings[pname].wins;
      var rating = Stat.s_player_ratings[pname].rating;
      strRating = rating ? String(rating) + "%" : "";
      eff = Stat.s_player_ratings[pname].eff;
    }
    format = format.split("{{kb}}").join(kb);
    format = format.split("{{battles}}").join(battles);
    format = format.split("{{wins}}").join(wins);
    format = format.split("{{rating}}").join(strRating);
    format = format.split("{{eff}}").join(eff);

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
      ? GetColorHtmlText(rating, ratingText) + " " + txt
      : txt + " " + GetColorHtmlText(rating, ratingText);
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
