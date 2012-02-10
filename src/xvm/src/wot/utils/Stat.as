/**
 * ...
 * @author sirmax2
 */
import net.produxion.util.XML2Object;
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

  public static function GetPercentHtmlText(percent: Number)
  {
    if (!percent)
      return "--%";
    return GetColorHtmlText(percent, String(percent) + "%");
  }

  public static function Decorate(playerName: String, txt: String, ratingPosition: Number)
  {
    if (!s_player_ratings)
      return txt;
    var pname = CleanPlayerName(playerName);
    var rating = s_player_ratings[pname.toUpperCase()].rating;
    return (ratingPosition == Defines.POSITION_LEFT)
      ? GetPercentHtmlText(rating) + " " + txt
      : txt + " " + GetPercentHtmlText(rating);
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
        playerName: pname,
        originalText: originalText,
        team: team,
        loaded: false
      };
    }
  }

  private static var _s_isNew = true;
  public static function LoadData(useNames: Boolean)
  {
    //Logger.add("Stat.LoadData(" + useNames + ")");

    var is_new = _s_isNew;
    _s_isNew = false;

    var players_to_load = [];
    var len = 0;
    for (var pname in s_player_data)
    {
      var pdata = s_player_data[pname];
      if (!pdata.loaded)
      {
        var str: String = useNames ? pname : String(pdata.playerId);
        if (len + str.length > Defines.MAX_PATH)
          break;
        pdata.loaded = true;
        players_to_load.push(str);
        len += str.length + 1;
      }
    }

    if (players_to_load.length > 0)
    {
      var lv = new LoadVars();
      lv.onLoad = function(success)
      {
        Stat.LoadData(useNames);
      }
      var fn = useNames
        ? (is_new ? Defines.COMMAND_SET_NAMES: Defines.COMMAND_ADD_NAMES)
        : (is_new ? Defines.COMMAND_SET_IDS: Defines.COMMAND_ADD_IDS);
      lv.load(fn + " " + players_to_load.join(","));
    }
    else
    {
      LoadStatData(useNames ? Defines.COMMAND_RUN_NAMES : Defines.COMMAND_RUN_IDS);
    }
  }

  public static function LoadStatData(command)
  {
    if (s_loaded)
      return;
    s_loaded = true;
          
    var xml = new XML();
    xml.ignoreWhite = true;
    xml.onLoad = function(success)
    {
      if (!success)
        return;

      var stats = XML2Object.deserialize(this);

      for (var i = 0; i < stats.users.user.length; i++) {
        var stat = stats.users.user[i];

        var rating = stat.attributes.battles > 0
          ? Math.round(stat.attributes.wins / stat.attributes.battles * 100) : 0;

        if (!Stat.s_player_ratings)
          Stat.s_player_ratings = {};

        Stat.s_player_ratings[stat.attributes.nick.toUpperCase()] = {
          rating: rating,
          battles: stat.attributes.battles,
          wins: stat.attributes.wins
        };
      };

      Stat.UpdateAll();
    };
    xml.load(command);
  }

  public static function LoadIds()
  {
    var lv= new LoadVars();
    lv.onLoad = function(success)
    {
      if (!success)
        return;
      Stat.s_player_ids = this.split(",");
    };
    lv.load(Defines.COMMAND_GET_IDS);
  }

  public static function LoadNames()
  {
    var lv= new LoadVars();
    lv.onLoad = function(success)
    {
      if (!success)
        return;
      Stat.s_player_names = this.split(",");
    };
    lv.load(Defines.COMMAND_GET_NAMES);
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
