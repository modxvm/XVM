/**
 * ...
 * @author Maxim Schedriviy
 */
import com.natecook.Sprintf;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.GraphicsUtil;
import wot.utils.Logger;
import wot.utils.StatData;
import wot.utils.Utils;

class wot.utils.StatFormat
{
    private static var dummy = Logger.dummy; // avoid import warning

    public static function FormatText(data, format: String, isDead: Boolean)
    {
        var sWins: String = "";
        var sBattles: String = "";
        var sKb: String = "";
        var sRating: String = "";
        var sEff: String = "";
        var sE: String = "";
        var sTWins: String = "";
        var sTBattles: String = "";
        var sTKb: String = "";
        var sTKbWithout0: String = "";
        var sTHb: String = "";
        var sTRating: String = "";
        var sTDB: String = "";
        var sTDV: String = "";
        var sTFB: String = "";
        var sTSB: String = "";
        var sD: String = "";
        var sF: String = "";
        var sS: String = "";

        var eff: Number = 0;
        var e: Number = 0;
        var rating: Number = 0;
        var kb: Number = -1;
        var t_rating: Number = 0;
        var t_kb: Number = -1;
        var t_battles: Number = -1;
        var tdb: Number = 0;
        var tdv: Number = 0;
        var tfb: Number = 0;
        var tsb: Number = 0;

        //Logger.addObject(StatData.s_data);
        if (StatData.s_loaded)
        {
            var pname: String = Utils.GetNormalizedPlayerName(data.label);
            if (!data.uid)
                data.uid = StatData.s_data[pname].playerId;
            var stat = StatData.s_data[pname].stat;
            //Logger.addObject(StatData.s_data[pname]);
            //Logger.add("pname=" + pname + " uid=" + data.uid + " r=" + stat.r + " e=" + stat.e);
            if (!stat)
            {
                if (Config.s_config.rating.loadEnemyStatsInFogOfWar)
                    GlobalEventDispatcher.dispatchEvent( { type: "process_fow", data: data } );
            }
            else
            {
                if (Config.s_config.rating.loadEnemyStatsInFogOfWar && !StatData.s_data[pname].loaded && data.vehicleId != "UNKNOWN")
                    GlobalEventDispatcher.dispatchEvent( { type: "process_fow", data: data } );

                if (!stat.notInDb)
                {
                    rating = Utils.toInt(stat.r);
                    sRating = rating ? String(rating) + "%" : "--%";

                    eff = Utils.toInt(stat.e);
                    sEff = eff ? String(eff) : "--";

                    e = stat.te;
                    sE = e ? String(e) : "-";

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
                        tdb = stat.tdb;
                        sTDB = stat.tdb > 0 ? String(tdb) : "";
                        tdv = stat.tdv;
                        sTDV = stat.tdv > 0 ? Sprintf.format("%.1f", tdv) : "";
                        sD = Utils.padLeft(stat.tdv > 0 ? String(Math.round(tdv * 10)) : "", 2);
                        tfb = stat.tfb;
                        sTFB = stat.tfb > 0 ? Sprintf.format("%.1f", tfb) : "";
                        sF = Utils.padLeft(stat.tfb > 0 ? String(Math.round(tfb * 10)) : "", 2);
                        tsb = stat.tsb;
                        sTSB = stat.tsb > 0 ? Sprintf.format("%.1f", tsb) : "";
                        sS = Utils.padLeft(stat.tsb > 0 ? String(Math.round(tsb * 10)) : "", 2);
                    }
                }
            }
        }

        // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
        format = format.split("{{kb}}").join(sKb);
        format = format.split("{{battles}}").join(sBattles);
        format = format.split("{{wins}}").join(sWins);
        format = format.split("{{rating}}").join(sRating);
        format = format.split("{{eff}}").join(sEff);
        format = format.split("{{e}}").join(sE);

        format = format.split("{{t-kb}}").join(sTKbWithout0);
        format = format.split("{{t-kb-0}}").join(Utils.padLeft(sTKb, 4));
        format = format.split("{{t-hb}}").join(sTHb);
        format = format.split("{{t-battles}}").join(sTBattles);
        format = format.split("{{t-wins}}").join(sTWins);
        format = format.split("{{t-rating}}").join(sTRating);
        format = format.split("{{tdb}}").join(sTDB);
        format = format.split("{{tdv}}").join(sTDV);
        format = format.split("{{tfb}}").join(sTFB);
        format = format.split("{{tsb}}").join(sTSB);
        format = format.split("{{d}}").join(sD);
        format = format.split("{{f}}").join(sF);
        format = format.split("{{s}}").join(sS);

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
        format = format.split("{{tdb:4}}").join(Utils.padLeft(sTDB, 4));
        format = format.split("{{tdv:3}}").join(Utils.padLeft(sTDV, 3));
        format = format.split("{{tfb:3}}").join(Utils.padLeft(sTFB, 3));
        format = format.split("{{tsb:3}}").join(Utils.padLeft(sTSB, 3));

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
        format = format.split("{{c:tdb}}").join(
            GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, tdb, "#", isDead));
        format = format.split("{{c:tdv}}").join(
            GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, tdv, "#", isDead));
        format = format.split("{{c:tfb}}").join(
            GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, tfb, "#", isDead));
        format = format.split("{{c:tsb}}").join(
            GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, tsb, "#", isDead));
        format = format.split("{{c:e}}").join(
            GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_E, e, "#", isDead));

        //format = Utils.trim(format);

        return format;
    }
}