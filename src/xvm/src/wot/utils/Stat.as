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

  // Logic functions

  public static function Decorate(playerId: Number, txt: String, ratingPosition: Number)
  {
    if (!s_player_ratings)
      return txt;
    var rating = s_player_ratings[String(playerId)].rating;
    return (ratingPosition == Defines.POSITION_LEFT)
      ? GetPercentHtmlText(rating) + " " + txt
      : txt + " " + GetPercentHtmlText(rating);
  }

  public static function AddPlayerData(reference: Object, playerId: Number, originalText: String, team: Number)
  {
    if (playerId <= 0)
      return;

    var id: String = String(playerId);

    if (!s_player_data[id])
    {
      s_player_ids.push(playerId);
      s_player_data[id] = {
        reference: reference,
        playerId: playerId,
        originalText: originalText,
        team: team,
        loaded: false
      };
    }

    if (s_player_ids.length === 30 && !s_loaded) // FIXIT: Не будет работать с "туманом войны".
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
    for (var id in s_player_data)
    {
      var pdata = s_player_data[id];
      if (!pdata.loaded)
      {
        if (len + id.length > Defines.MAX_PATH)
          break;
        pdata.loaded = true;
        players_to_load.push(id);
        len += id.length + 1;
      }
    }

    if (players_to_load.length > 0)
    {
      var lv = new LoadVars();
      lv.onLoad = function(success)
      {
        Stat.LoadData();
      }
      var fn = is_new ? Defines.COMMAND_SET_USERS: Defines.COMMAND_ADD_USERS;
      lv.load(fn + " #" + players_to_load.join(","));
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

  /* TODO
  public static function LoadUserIds()
  {
    var lv= new LoadVars();
    lv.onLoad = function(success)
    {
      if (!success)
        return;
      Stat.s_player_ids = this.split(",");
    };
    lv.load(Defines.COMMAND_GET_USERS);
  }*/

  private static function UpdateAll()
  {
    //Logger.add("Stat.UpdateAll()");

    for (var id in s_player_data)
    {
      var pdata = s_player_data[id];
      pdata.reference.updateCallback(pdata);
    }
  }
  
}
