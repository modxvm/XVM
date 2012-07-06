/**
 * ...
 * @author Maxim Schedriviy
 */
import com.natecook.Sprintf;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GraphicsUtil;
import wot.utils.Logger;
import wot.utils.StatData;
import wot.utils.StatLoader;
import wot.utils.Utils;

class wot.utils.StatFormat
{
  private static var dummy = Logger.dummy; // avoid import warning

  public static function DecorateField(data: Object, txt: String, format: String, ratingPosition: Number)
  {
    //Logger.add("DecorateField: " + data.label + " / " + data.name);
    var ratingText = StatFormat.FormatText(data, format, false);
    if (!ratingText || ratingText == "")
      return txt;
    return (ratingPosition == Defines.POSITION_LEFT)
      ? ratingText + " " + txt
      : txt + " " + ratingText;
  }

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
    var sTKbWithout0: String = "";
    var sTHb: String = "";
    var sTRating: String = "";

    var eff: Number = 0;
    var rating: Number = 0;
    var kb: Number = -1;
    var t_rating: Number = 0;
    var t_kb: Number = -1;
    var t_battles: Number = -1;

    //Logger.addObject(StatData.s_data);
    if (StatLoader.s_loaded)
    {
      var pname: String = Utils.GetNormalizedPlayerName(data.label || data.name);
      if (!data.uid || data.uid == undefined)
        data.uid = StatData.s_data[pname].playerId;
      var stat = StatData.s_data[pname].stat;
      //Logger.addObject(StatData.s_data[pname]);
      //Logger.add("pname=" + pname + " uid=" + data.uid + " r=" + stat.r + " e=" + stat.e);
      if (stat)
      {
        if (!stat.notInDb)
        {
          rating = Utils.toInt(stat.r);
          sRating = rating ? String(rating) + "%" : "--%";

          eff = Utils.toInt(stat.e);
          sEff = eff ? String(eff) : "--";

          if (rating)
          {
            var bn: Number = Utils.toInt(stat.b);
            kb = bn > 0 ? Math.round(bn / 1000) : -1;
            sKb = kb >= 0 ? String(kb) + "k" : "";
            sBattles = bn > 0 ? Utils.toString(bn) : "";
            sWins = bn > 0 ? String(Utils.toInt(stat.w)) : "";
          }

          t_rating = Utils.toInt(stat.tr);
          sTRating = t_rating ? String(t_rating) + "%" : "--%";

          if (t_rating)
          {
            var bn: Number = Utils.toInt(stat.tb);
            t_kb = bn > 0 ? Math.round(bn / 100) / 10 : -1;
            t_battles = bn > 0 ? bn : -1;
            sTKb = t_kb >= 0 ? Sprintf.format("%.1fk", t_kb) : "";
            sTKbWithout0 = (sTKb.length > 0 && sTKb.charAt(0) == '0') ? sTKb.slice(1) : sTKb;
            sTHb = t_kb >= 0 ? String(Math.round(bn / 100)) + "h" : "";
            sTBattles = bn > 0 ? Utils.toString(bn) : "";
            sTWins = bn > 0 ? String(Utils.toInt(stat.tw)) : "";
          }
        }
      }
      else if (Config.s_config.rating.loadEnemyStatsInFogOfWar)
        StatLoader.ProcessForFogOfWar(data);
    }

    // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
    format = format.split("{{kb}}").join(sKb);
    format = format.split("{{battles}}").join(sBattles);
    format = format.split("{{wins}}").join(sWins);
    format = format.split("{{rating}}").join(sRating);
    format = format.split("{{eff}}").join(sEff);

    format = format.split("{{t-kb}}").join(sTKbWithout0);
    format = format.split("{{t-kb-0}}").join(Utils.padLeft(sTKb, 4));
    format = format.split("{{t-hb}}").join(sTHb);
    format = format.split("{{t-battles}}").join(sTBattles);
    format = format.split("{{t-wins}}").join(sTWins);
    format = format.split("{{t-rating}}").join(sTRating);

    // This code is stupid, and needs to be rewritten
    format = format.split("{{kb:3}}").join(Utils.padLeft(sKb, 3));
    format = format.split("{{rating:3}}").join(Utils.padLeft(sRating, 3));
    format = format.split("{{eff:4}}").join(Utils.padLeft(sEff, 4));

    format = format.split("{{t-kb:4}}").join(Utils.padLeft(sTKbWithout0, 4));
    format = format.split("{{t_kb:4}}").join(Utils.padLeft(sTKbWithout0, 4));
    format = format.split("{{t-hb:3}}").join(Utils.padLeft(sTHb, 3));
    format = format.split("{{t_hb:3}}").join(Utils.padLeft(sTHb, 3));
    format = format.split("{{t-battles:4}}").join(Utils.padLeft(sTBattles, 4));
    format = format.split("{{t_battles:4}}").join(Utils.padLeft(sTBattles, 4));
    format = format.split("{{t-rating:3}}").join(Utils.padLeft(sTRating, 3));
    format = format.split("{{t_rating:3}}").join(Utils.padLeft(sTRating, 3));

    // Dynamic colors
    format = format.split("{{c:eff}}").join(eff < 0 ? ""
      : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, eff, "#", isDead));
    format = format.split("{{c:rating}}").join(rating < 0 ? ""
      : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, rating, "#", isDead));
    format = format.split("{{c:kb}}").join(
      GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, kb, "#", isDead));

    format = format.split("{{c:t-rating}}").join(rating < 0 ? ""
      : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, t_rating, "#", isDead));
    format = format.split("{{c:t_rating}}").join(rating < 0 ? ""
      : GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, t_rating, "#", isDead));
    format = format.split("{{c:t-battles}}").join(
      GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, t_battles, "#", isDead));
    format = format.split("{{c:t_battles}}").join(
      GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, t_battles, "#", isDead));

    format = Utils.trim(format);
    
    return format;
  }
}