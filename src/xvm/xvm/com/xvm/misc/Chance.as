/**
 * XVM Config utils
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.misc
{
    import flash.text.*;
    import org.idmedia.as3commons.util.StringUtils;
    import com.xvm.*;
    import com.xvm.l10n.*;
    import com.xvm.utils.*;
    import com.xvm.vehinfo.*;
    import com.xvm.types.stat.StatData;

    public class Chance
    {
        private static var battleTier: Number = 0;

        //public static var lastChances: Object = null;

        public static function ChanceError(text:String) : String
        {
            return "<font color='#FFBBBB'>" + Locale.get("Chance error") + ": " + text + "</font>";
        }

        public static function GetChanceText(showExp:Boolean) : String
        {
            var teamsCount:Object = CalculateTeamPlayersCount();
            //Logger.addObject(teamsCount);
            // only equal and non empty team supported
            if (teamsCount.ally == 0 || teamsCount.enemy == 0)
                return "";
            if (Math.abs(teamsCount.ally - teamsCount.enemy) > 2)
                return "";

            Chance.battleTier = Chance.GuessBattleTier();

            var chG:Object = GetChance(ChanceFuncG);
            var chT:Object = GetChance(ChanceFuncT);

            var text:String = "";

            if (chG.error)
                return ChanceError("[G] " + chG.error);

            if (chT.error)
                return ChanceError("[T] " + chT.error);

            //lastChances = { g: chG.percentF, t: chT.percentF };
            text += Locale.get("Chance to win") + ": " +
                FormatChangeText(Locale.get("global"), chG) + ", " +
                FormatChangeText(Locale.get("per-vehicle"), chT);
            if (showExp)
            {
                var chX1:Object = GetChance(ChanceFuncX1);
                var chX2:Object = GetChance(ChanceFuncX2);
                text += " | " + Locale.get("chanceExperimental") + ": " + FormatChangeText("", chX1) + ", " + FormatChangeText("", chX2) + ". " + Locale.get("chanceBattleTier") + "=" + battleTier;
                //lastChances.X1 = chX1.percentF;
                //lastChances.X2 = chX2.percentF;
            }
            return text;
        }

        // PRIVATE
        private static var _x1Logged:Boolean = false;
        private static var _x2Logged:Boolean = false;
        private static function GetChance(chanceFunc:Function):Object
        {
            var Ka:Number = 0;
            var Ke:Number = 0;
            for (var name:String in Stat.stat)
            {
                var stat:StatData = Stat.getData(name);
                var vi1:Object = VehicleInfo.getInfo1(stat.icon);
                if (!vi1) {
                    if (stat.icon == "ussr-Observer" || stat.icon == "noImage")
                        continue;
                    return { error: "[1] No data for: " + stat.icon };
                }

                var vi2:Object = VehicleInfo.getInfo2ByIcon(stat.icon);
                if (!vi2)
                    return { error: "[2] No data for: " + stat.icon };

                var K:Number = chanceFunc(vi1, vi2, stat);

                Ka += (stat.team == Defines.TEAM_ALLY) ? K : 0;
                Ke += (stat.team == Defines.TEAM_ENEMY) ? K : 0;
            }

            //Logger.add("Ka=" + Ka + " Ke=" + Ke);

            return PrepareChanceResults(Ka, Ke, chanceFunc);
        }

        // http://www.koreanrandom.com/forum/topic/2598-/#entry31429
        private static function ChanceFuncG(vi1:Object, vi2:Object, stat:StatData):Number
        {
            var Td:Number = (vi1.tiers[0] + vi1.tiers[1]) / 2.0 - battleTier;

            var Tmin:Number = vi1.tiers[0];
            var Tmax:Number = vi1.tiers[1];
            var T:Number = battleTier;
            //Logger.addObject(stat);
            var Ea:Number = isNaN(stat.xwn) ? Config.config.consts.AVG_XVMSCALE : stat.xwn;
            var Ean:Number = Ea + (Ea * (((stat.lvl || T) - T) * 0.05));
            var Ra:Number = stat.r || Config.config.consts.AVG_GWR;
            var Ba:Number = stat.b || Config.config.consts.AVG_BATTLES;

            // 1
            var Klvl:Number = (Tmax + Tmin) / 2 - T;

            // 2
            var Kab:Number = (Ba <= 500) ? 0                   //   0..0.5k  => 0
                : (Ba <= 5000) ? (Ba - 500) / 10000            //  1k..5k => 0..0.45
                : (Ba <= 10000) ? 0.45 + (Ba - 5000) / 20000   //  5k..10k => 0.45..0.7
                : (Ba <= 20000) ? 0.7 + (Ba - 10000) / 40000   // 10k..20k => 0.7..0.95
                : 0.95 + (Ba - 20000) / 80000                  // 20k..    => 0.95..

            // 3
            var Kra:Number = (100 + Ra - 48.5) / 100;

            // 4
            var Eb:Number = ((Ean * Kra) * (Kra + Kab)) * (Kra + 0.25 * Klvl);

            // 5
            return Math.max(0, Math.min(Config.config.consts.MAX_EBN, Eb));
        }

        private static function ChanceFuncT(vi1:Object, vi2:Object, stat:StatData):Number
        {
            var Td:Number = (vi1.tiers[0] + vi1.tiers[1]) / 2.0 - battleTier;

            var Tmin:Number = vi1.tiers[0];
            var Tmax:Number = vi1.tiers[1];
            var T:Number = battleTier;
            var Bt:Number = stat.v.b || 0;
            var Et:Number = stat.v.eff || 0;
            var Rt:Number = stat.v.r || 0;
            var AvgW:Number = vi2.avg.R ? vi2.avg.R * 100 : 49.5;
            var Ea:Number = isNaN(stat.xwn) ? Config.config.consts.AVG_XVMSCALE : stat.xwn;
            var Ean:Number = Ea + (Ea * (((stat.lvl || T) - T) * 0.05));
            var Ra:Number = stat.r || Config.config.consts.AVG_GWR;
            var Ba:Number = stat.b || Config.config.consts.AVG_BATTLES;

            // 1
            var Klvl:Number = (Tmax + Tmin) / 2 - T;

            // 2
            var Ktb:Number = (Bt <= 50) ? 0                    //    0..50  => 0
                : (Bt <= 500) ? (Bt - 50) / 1000               //  51..500  => 0..0.45
                : (Bt <= 1000) ? 0.45 + (Bt - 500) / 2000      //  501..1000 => 0.45..0.7
                : (Bt <= 2000) ? 0.7 + (Bt - 1000) / 4000      // 1001..2000 => 0.7..0.95
                : 0.95 + (Bt - 2000) / 8000;                   // 2000..     => 0.95..
            var Kab:Number = (Ba <= 500) ? 0                   //   0..0.5k  => 0
                : (Ba <= 5000) ? (Ba - 500) / 10000            //  1k..5k => 0..0.45
                : (Ba <= 10000) ? 0.45 + (Ba - 5000) / 20000   //  5k..10k => 0.45..0.7
                : (Ba <= 20000) ? 0.7 + (Ba - 10000) / 40000   // 10k..20k => 0.7..0.95
                : 0.95 + (Ba - 20000) / 80000                  // 20k..    => 0.95..

            // 3
            var Krt:Number = (100 + Rt - AvgW) / 100;
            var Kra:Number = (100 + Ra - 48.5) / 100;

            // 4
            var Eb:Number = (Et > 0)
                ? (((3 / 5 * (Et / 20) * Krt) * (Krt + Ktb)) +
                    ((2 / 5 * Ean * Kra) * (Kra + Kab))) * (Kra + 0.25 * Klvl)
                : ((Ean * Kra) * (Kra + Kab)) * (Kra + 0.25 * Klvl);

            // 5
            return Math.max(0, Math.min(Config.config.consts.MAX_EBN, Eb));
        }

        private static function ChanceFuncX1(vi1:Object, vi2:Object, stat:StatData):Number
        {
            if (!stat.alive)
                return 0;

            var Td:Number = (vi1.tiers[0] + vi1.tiers[1]) / 2.0 - battleTier;

            var Tmin:Number = vi1.tiers[0];
            var Tmax:Number = vi1.tiers[1];
            var T:Number = battleTier;
            var Ea:Number = isNaN(stat.xwn) ? Config.config.consts.AVG_XVMSCALE : stat.xwn;
            var Ean:Number = Ea + (Ea * (((stat.lvl || T) - T) * 0.05));
            var Ra:Number = stat.r || Config.config.consts.AVG_GWR;
            var Ba:Number = stat.b || Config.config.consts.AVG_BATTLES;

            // 1
            var Klvl:Number = (Tmax + Tmin) / 2 - T;

            // 2
            var Kab:Number = (Ba <= 500) ? 0                   //   0..0.5k  => 0
                : (Ba <= 5000) ? (Ba - 500) / 10000            //  1k..5k => 0..0.45
                : (Ba <= 10000) ? 0.45 + (Ba - 5000) / 20000   //  5k..10k => 0.45..0.7
                : (Ba <= 20000) ? 0.7 + (Ba - 10000) / 40000   // 10k..20k => 0.7..0.95
                : 0.95 + (Ba - 20000) / 80000                  // 20k..    => 0.95..

            // 3
            var Kra:Number = (100 + Ra - 48.5) / 100;

            // 4
            var Eb:Number = ((Ean * Kra) * (Kra + Kab)) * (Kra + 0.25 * Klvl);

            // 5
            return Math.max(0, Math.min(Config.config.consts.MAX_EBN, Eb));
        }

        private static function ChanceFuncX2(vi1:Object, vi2:Object, stat:StatData):Number
        {
            if (!stat.alive)
                return 0;

            var Td:Number = (vi1.tiers[0] + vi1.tiers[1]) / 2.0 - battleTier;

            var Tmin:Number = vi1.tiers[0];
            var Tmax:Number = vi1.tiers[1];
            var T:Number = battleTier;
            var Bt:Number = stat.v.b || 0;
            var Et:Number = stat.v.eff || 0;
            var Rt:Number = stat.v.r || 0;
            var AvgW:Number = vi2.avg.R ? vi2.avg.R * 100 : 49.5;
            var Ea:Number = isNaN(stat.xwn) ? Config.config.consts.AVG_XVMSCALE : stat.xwn;
            var Ean:Number = Ea + (Ea * (((stat.lvl || T) - T) * 0.05));
            var Ra:Number = stat.r || Config.config.consts.AVG_GWR;
            var Ba:Number = stat.b || Config.config.consts.AVG_BATTLES;

            // 1
            var Klvl:Number = (Tmax + Tmin) / 2 - T;

            // 2
            var Ktb:Number = (Bt <= 50) ? 0                    //    0..50  => 0
                : (Bt <= 500) ? (Bt - 50) / 1000               //  51..500  => 0..0.45
                : (Bt <= 1000) ? 0.45 + (Bt - 500) / 2000      //  501..1000 => 0.45..0.7
                : (Bt <= 2000) ? 0.7 + (Bt - 1000) / 4000      // 1001..2000 => 0.7..0.95
                : 0.95 + (Bt - 2000) / 8000;                   // 2000..     => 0.95..
            var Kab:Number = (Ba <= 500) ? 0                   //   0..0.5k  => 0
                : (Ba <= 5000) ? (Ba - 500) / 10000            //  1k..5k => 0..0.45
                : (Ba <= 10000) ? 0.45 + (Ba - 5000) / 20000   //  5k..10k => 0.45..0.7
                : (Ba <= 20000) ? 0.7 + (Ba - 10000) / 40000   // 10k..20k => 0.7..0.95
                : 0.95 + (Ba - 20000) / 80000                  // 20k..    => 0.95..

            // 3
            var Krt:Number = (100 + Rt - AvgW) / 100;
            var Kra:Number = (100 + Ra - 48.5) / 100;

            // 4
            var Eb:Number = (Et > 0)
                ? (((3 / 5 * (Et / 20) * Krt) * (Krt + Ktb)) +
                    ((2 / 5 * Ean * Kra) * (Kra + Kab))) * (Kra + 0.25 * Klvl)
                : ((Ean * Kra) * (Kra + Kab)) * (Kra + 0.25 * Klvl);

            // 5
            return Math.max(0, Math.min(Config.config.consts.MAX_EBN, Eb));
        }

        // return: { ally: Number, enemy: Number }
        private static function CalculateTeamPlayersCount(): Object
        {
            var nally:Number = 0;
            var nenemy:Number = 0;
            for (var pname:String in Stat.stat)
            {
                var stat:StatData = Stat.getData(pname);
                if (stat.icon == "Unknown" || stat.icon == "ussr-Observer") // skip unknown tanks in Fog of War mode and observer
                    continue;
                if (stat.team == Defines.TEAM_ALLY) ++nally else ++nenemy;
            }
            return { ally: nally, enemy: nenemy };
        }

        private static function PrepareChanceResults(Ea:Number, Ee:Number, chanceFunc:Function):Object
        {
            if (Ea == 0 && Ee == 0) Ea = Ee = 1;
            //Logger.add("Ea=" + Math.round(Ea) + " Ee=" + Math.round(Ee));

            var p:Number = Math.max(0.05, Math.min(0.95, (0.5 + (Ea / (Ea + Ee) - 0.5) * 1.5))) * 100;

            // Normalize (5..95)
            return {
                ally_value: Math.round(Ea),
                enemy_value: Math.round(Ee),
                percent: Math.round(p),
                raw: Ea / (Ea + Ee) * 100,
                percentF: Math.round(1000 * p) / 1000
            };
        }

        private static function GuessBattleTier(): Number
        {
            // 1. Collect all vehicles info
            var vis:Array = [];
            for (var pname:String in Stat.stat)
            {
                var stat:StatData = Stat.getData(pname);
                var vi1:Object = VehicleInfo.getInfo1(stat.icon);
                if (!vi1) {
                    if (stat.icon == "ussr-Observer")
                        continue;
                    return 0;
                }
                var vi2:Object = VehicleInfo.getInfo2ByIcon(stat.icon);
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
            var Tmin:Number = vis[0].Tmin;
            var Tmax:Number = vis[0].Tmax;
            //Logger.add("T before=" + Tmin + ".." + Tmax);
            var vis_length:int = vis.length;
            for (var i:int = 1; i < vis_length; ++i)
            {
                var vi:Object = vis[i];
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

        private static function FormatChangeText(txt:String, chance:Object):String
        {
            var htmlText:String = (txt && txt != "") ? txt + ": " : "";
            if (!chance)
                htmlText += "xx%";
            else
            {
                var color:Number = GraphicsUtil.brightenColor(MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_RATING, chance.raw), 50);
                htmlText += "<font color='#" + StringUtils.leftPad(color.toString(16), 6, '0') + "'>" + chance.percent + "%</font>";
            }

            return htmlText;
        }
    }
}
