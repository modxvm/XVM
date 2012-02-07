/**
 * ...
 * @author sirmax2
 */
import net.produxion.util.XML2Object;
import wot.utils.Defines;
import wot.utils.Logger;
import wot.utils.Utils;

class wot.utils.Stat
{
  // Config
  public static var s_player_names = [];
  public static var s_player_data = {};
  public static var s_player_ratings = null;
  public static var s_loaded = false;

  // Misc functions
  
  public static function log(str)
  {
    Logger.add(str);
  }

  public static function CleanPlayerName(str)
  {
    str = str.toLowerCase();
    var pos = str.indexOf("[");
    return pos === -1 ? str : str.slice(0, pos);
  }

  public static function GetPercentHtmlText(percent)
  {
    if (!percent)
      return "--%";

    var color = (percent < 49) ? 0xFF0000 : ((percent < 51) ? 0xFFFF00 : 0x00FF00);
    return ("<font color=\'#" + color.toString(16) + "\'>" + percent + "%</font>");
  }

  // Logic functions

  public static function DecorateField(playerName, txt)
  {
    if (!s_player_ratings)
      return txt;
    var pname = CleanPlayerName(playerName);
    var rating = s_player_ratings[pname.toUpperCase()].rating;
    return (Utils.indexOf(s_player_names, pname) < 15) // FIXIT: не будет работать с "туманом войны";
      ? txt + " " + GetPercentHtmlText(rating)
      : GetPercentHtmlText(rating) + " " + txt;
  }

  public static function AddPlayerData(reference, original_name, original_fieldtext)
  {
    if (!original_name)
      return;

    var pname = CleanPlayerName(original_name);

    if (!s_player_data[pname])
    {
      s_player_names.push(pname);
      s_player_data[pname] = {
        reference: reference,
        original_name: original_name,
        original_fieldtext: original_fieldtext,
        loaded: false
      };
    }

    if (s_player_names.length === 30 && !s_loaded) // FIXIT: Не будет работать с "туманом войны".
      LoadData();
  }

  public static function LoadData()
  {
    //log("Stat.LoadData()");

    var is_new = !s_loaded;
    s_loaded = true;

    var players_to_load = [];
    var len = 0;
    for (var pname in s_player_data)
    {
      var pdata = s_player_data[pname];
      if (!pdata.loaded)
      {
        if (len + pname.length > Defines.MAX_PATH)
          break;
        pdata.loaded = true;
        players_to_load.push(pname);
        len += pname.length + 1;
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
      lv.load(fn + " " + players_to_load.join(",").toUpperCase());
    }
    else
    {
      LoadData2();
    }
  }

  private static function LoadData2()
  {
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
    xml.load("stat/@RUN");
  }

  public static function UpdateAll()
  {
    //log("Stat.UpdateAll()");

    if (s_player_names.length !== 30) // FIXIT: Не будет работать с "туманом войны".
      return;

    for (var pname in s_player_data)
    {
      var pdata = s_player_data[pname];
      pdata.reference.updateCallback(pdata);
    }
  }
  
}
