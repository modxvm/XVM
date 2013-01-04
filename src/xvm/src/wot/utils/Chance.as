/**
 * ...
 * @author Maxim Schedriviy
 */
import wot.utils.Defines;
import wot.utils.Config;
import wot.utils.GraphicsUtil;
import wot.utils.Locale;
import wot.utils.Logger;
import wot.utils.StatData;
import wot.utils.Utils;
import wot.utils.VehicleInfo;

class wot.utils.Chance
{
    private static var DEBUG_EXP = false;

    private static var dummy = Logger.dummy; // avoid import warning

    private static var battleTier: Number = 0;

    public static var lastChances: Object = null;

    public static function ShowChance(tf: TextField, showExp: Boolean): String
    {
        var text = GetChanceText(showExp);
        if (text == null)
            return tf.text;
        tf.htmlText = tf.text == "" ? "" : tf.text + " | " + text;
        return tf.htmlText;
    }

    public static function GetChanceText(showExp: Boolean):String
    {
        var teamsCount: Object = CalculateTeamPlayersCount();
        // only equal and non empty team supported
        if (teamsCount.ally != teamsCount.enemy || teamsCount.ally == 0)
            return null;

        Chance.battleTier = Chance.GuessBattleTier();

        var chG = GetChance(ChanceFuncG);
        var chT = GetChance(ChanceFuncT);

        var text = "";
        if (chG.error)
            text += "<font color='#FF8080'>" + Locale.get("Chance error") + "[G]: " + chG.error + "</font>";
        else if (chT.error)
            text += "<font color='#FF8080'>" + Locale.get("Chance error") + "[T]: " + chG.error + "</font>";
        else
        {
            lastChances = { g: chG.percentF, t: chT.percentF };
            text += Locale.get("Chance to win") + ": " +
                FormatChangeText(Locale.get("Global"), chG) + ", " +
                FormatChangeText(Locale.get("Per-vehicle"), chT);
            if (showExp)
            {
                var chX1 = GetChance(ChanceFuncX1);
                var chX2 = GetChance(ChanceFuncX2);
                text += " | Exp: " + FormatChangeText("", chX1) + ", " + FormatChangeText("", chX2) + " T=" + battleTier;
                lastChances.X1 = chX1.percentF;
                lastChances.X2 = chX2.percentF;
            }
        }

        return text;
    }

    // PRIVATE
    private static var _x1Logged = false;
    private static var _x2Logged = false;
    private static function GetChance(chanceFunc: Function): Object
    {
        var Ka = 0;
        var Ke = 0;
        for (var pname in StatData.s_data)
        {
            var pdata = StatData.s_data[pname];

            var vi1 = VehicleInfo.getInfo1(pdata.icon);
            if (!vi1)
              return { error: "No data for: " + VehicleInfo.getVehicleName(pdata.icon) };

            var vi2 = VehicleInfo.getInfo2(pdata.icon);
            if (!vi2)
              return { error: "No data for: " + VehicleInfo.getVehicleName(pdata.icon) };

            var K = chanceFunc(vi1, vi2, pdata.team, pdata.stat);

            Ka += (pdata.team == Defines.TEAM_ALLY) ? K : 0;
            Ke += (pdata.team == Defines.TEAM_ENEMY) ? K : 0;
        }

        if (DEBUG_EXP)
        {
            if (!_x1Logged && chanceFunc == ChanceFuncX1)
            {
                _x1Logged = true;
                Logger.add("X1: K = " + Ka + " / " + Ke + " => " + String(Math.round((Ka / (Ka + Ke) * 1000)) / 10) + "%");
            }
            else if (!_x2Logged && chanceFunc == ChanceFuncX2)
            {
                _x2Logged = true;
                Logger.add("X2: K = " + Ka + " / " + Ke + " => " + String(Math.round((Ka / (Ka + Ke) * 1000)) / 10) + "%");
            }
        }

        return PrepareChanceResults(Ka, Ke);
    }

    private static function ChanceFuncG(vi1, vi2, team, stat): Number
    {
        var Td = (vi1.tiers[0] + vi1.tiers[1]) / 2.0 - battleTier;

        var E: Number = stat.e || Config.s_config.consts.AVG_EFF;
        var R: Number = stat.b ? stat.w / stat.b : Config.s_config.consts.AVG_GWR / 100.0;

        var B: Number = stat.b || Config.s_config.consts.AVG_BATTLES;
        var Bn = (B < 2000) ? B / 5000               // 0k .. 2k  => 0.0 .. 0.4
            : (B < 5000) ? 0.4 + (B - 2000) / 15000  // 2k .. 5k  => 0.4 .. 0.6
            : (B < 10000) ? 0.6 + (B - 5000) / 25000 // 5k .. 10k => 0.6 .. 0.8
            : 0.8 + (B - 10000) / 100000;            // 10k..    => 0.8 .. ...

        return E * (1 + R - (Config.s_config.consts.AVG_GWR / 100.0)) * (1 + 0.25 * Td) * (1 + Bn);
    }

    private static function ChanceFuncT(vi1, vi2, team, stat): Number
    {
        var Td = (vi1.tiers[0] + vi1.tiers[1]) / 2.0 - battleTier;

        var E: Number = stat.e || Config.s_config.consts.AVG_EFF;

        var r = stat.tb ? stat.tw / stat.tb * 100 : Config.s_config.consts.AVG_GWR;
        var Rt_pre: Number = Math.max(-10, Math.min(10, (r - Config.s_config.consts.AVG_GWR)));
        var Rt = Rt_pre / 100.0 * 4;

        return E * (1 + Rt) * (1 + 0.25 * Td);
    }

    private static function ChanceFuncX1(vi1, vi2, team, stat): Number
    {
        var Td = (vi1.tiers[0] + vi1.tiers[1]) / 2.0 - battleTier;

        var r = stat.b ? stat.w / stat.b * 100 : Config.s_config.consts.AVG_GWR;
        var R = Math.max(-10, Math.min(10, r - Config.s_config.consts.AVG_GWR)) + 10;

        var K = (R - 5) * (1 + 0.25 * Td);

        if (DEBUG_EXP)
        {
            Logger.add("team=" + team +
                " l=" + Utils.padLeft(String(vi2.level), 2) + " " + Utils.padLeft(vi2.type, 3) +
                " r=" + Utils.padLeft(String(Math.round(r * 10) / 10), 4) +
                " R=" + Utils.padLeft(String(Math.round(R * 10) / 10), 4) +
                " Td=" + Utils.padLeft(String(Td), 4) +
                " K=" + String(Math.round(K * 10) / 10));
        }

        return K;
    }

    private static function ChanceFuncX2(vi1, vi2, team, stat): Number
    {
        var Td = (vi1.tiers[0] + vi1.tiers[1]) / 2.0 - battleTier;

        var r = stat.b ? stat.w / stat.b * 100 : Config.s_config.consts.AVG_GWR;
        var R = Math.max(-10, Math.min(10, r - Config.s_config.consts.AVG_GWR)) + 10;

        var B: Number = stat.b || Config.s_config.consts.AVG_BATTLES;
        var Bn = (B < 2000) ? B / 5000               // 0k .. 2k  => 0.0 .. 0.4
            : (B < 5000) ? 0.4 + (B - 2000) / 15000  // 2k .. 5k  => 0.4 .. 0.6
            : (B < 10000) ? 0.6 + (B - 5000) / 25000 // 5k .. 10k => 0.6 .. 0.8
            : 0.8 + (B - 10000) / 100000;            // 10k..    => 0.8 .. ...

        var K = (R - 5) * (1 + 0.25 * Td) * (1 + Bn);

        if (DEBUG_EXP)
        {
            Logger.add("team=" + team +
                " l=" + Utils.padLeft(String(vi2.level), 2) + " " + Utils.padLeft(vi2.type, 3) +
                " r=" + Utils.padLeft(String(Math.round(r * 10) / 10), 4) +
                " R=" + Utils.padLeft(String(Math.round(R * 10) / 10), 4) +
                " b=" + Utils.padLeft(String(Math.round(stat.b / 100) / 10), 4) +
                " B=" + Utils.padLeft(String(Math.round(Bn * 100) / 100), 5) +
                " Td=" + Utils.padLeft(String(Td), 4) +
                " K=" + String(Math.round(K * 10) / 10));
        }

        return K;
    }

    // return: { ally: Number, enemy: Number }
    private static function CalculateTeamPlayersCount(): Object
    {
        var nally = 0;
        var nenemy = 0;
        for (var pname in StatData.s_data)
        {
            var pdata = StatData.s_data[pname];
            if (VehicleInfo.getVehicleName(pdata.icon).toUpperCase() == "UNKNOWN") // skip unknown tanks in Fog of War mode
                continue;
            if (pdata.team == Defines.TEAM_ALLY) ++nally else ++nenemy;
        }
        return { ally: nally, enemy: nenemy };
    }

    private static function PrepareChanceResults(ally, enemy)
    {
        if (ally == 0 && enemy == 0) ally = enemy = 1;
        if (ally == 0) ally = enemy;
        if (enemy == 0) enemy = ally;
        //Logger.add("ally=" + Math.round(ally) + " enemy=" + Math.round(enemy));

        return
        {
            ally_value: Math.round(ally),
            enemy_value: Math.round(enemy),
            percent: Chance.NormalizeResult(ally, enemy),
            raw: ally / (ally + enemy) * 100,
            percentF: Chance.NormalizeResultF(ally, enemy)
        };
    }

    // return: 5..95
    private static function NormalizeResult(a, b)
    {
        return Math.round(Math.max(0.05, Math.min(0.95, (0.5 + (a / (a + b) - 0.5) * 5.0))) * 100);
    }

	private static function NormalizeResultF(a, b)
    {
        return Math.round(1000*Math.max(0.05, Math.min(0.95, (0.5 + (a / (a + b) - 0.5) * 5.0))) * 100)/1000;
    }

    private static function GuessBattleTier(): Number
    {
        // 1. Collect all vehicles info
        var vis: Array = [];
        for (var pname in StatData.s_data)
        {
            var pdata = StatData.s_data[pname];
            var vi1 = VehicleInfo.getInfo1(pdata.icon);
            if (!vi1)
                return 0;
            var vi2 = VehicleInfo.getInfo2(pdata.icon);
            if (!vi2)
                return 0;
            vis.push( {
                level: vi2.level,
                Tmin: vi1.tiers[0],
                Tmax: vi1.tiers[1]
            });
        }

        // 2. Sort vehicles info by top tiers descending
        vis.sortOn("Tmax", Array.NUMERIC | Array.DESCENDING);

        // 3. Find minimum Tmax and maximum Tmin
        var Tmin = vis[0].Tmin;
        var Tmax = vis[0].Tmax;
        //Logger.add("T before=" + Tmin + ".." + Tmax);
        var vis_length = vis.length;
        for (var i = 1; i < vis_length; ++i)
        {
            var vi = vis[i];
            //Logger.add("l=" + vi.level + " Tmin=" + vi.Tmin + " Tmax=" + vi.Tmax);
            if (vi.Tmax < Tmin) // Skip "trinkets"
                continue;
            if (vi.Tmin > Tmin)
                Tmin = vi.Tmin;
            if (vi.Tmax < Tmax)
                Tmax = vi.Tmax;
        }
        //Logger.add("T after=" + Tmin + ".." + Tmax);

        //// 4. Calculate average tier
        //return (Tmax + Tmin) / 2.0;
        // 4. Return max tier
        return Tmax;
    }

    private static function FormatChangeText(txt, chance)
    {
      var htmlText = (txt && txt != "") ? txt + ": " : "";
      if (!chance)
        htmlText += "xx%";
      else
      {
        var color = GraphicsUtil.brightenColor(GraphicsUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_RATING, chance.raw), 50);
        htmlText += "<font color='#" + color.toString(16) + "'>" + chance.percent + "%</font>";
      }

      return htmlText;
    }
}
