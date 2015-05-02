/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.utils
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.stat.*;
    import com.xvm.types.veh.*;

    public class Chance
    {
        private static var battleTier:Number = 0;
        private static var maxTeamsCount:Number = 0;
        private static var chanceG:Object;
        private static var chanceT:Object;

        //public static var lastChances:Object = null;

        public static function ChanceError(text:String):String
        {
            return "<font color='#FFBBBB'>" + Locale.get("Chance error") + ": " + text + "</font>";
        }

        public static function GetChanceText(playerNames:Vector.<String>, showChance:Boolean, showBattleTier:Boolean, showLive:Boolean = false):String
        {
            var teamsCount:Object = null;
            Logger.add("========== begin chance calculation ===========");
            try
            {
                Logger.add("playerNames: " + playerNames.join(", "));
                teamsCount = CalculateTeamPlayersCount(playerNames);
                Logger.add("teamsCount=" + teamsCount.ally + "/" + teamsCount.enemy);
                // non empty teams required
                if (teamsCount.ally == 0 || teamsCount.enemy == 0)
                    return "";

                maxTeamsCount = Math.max(teamsCount.ally, teamsCount.enemy);

                Chance.battleTier = Macros.getGlobalValue("battletier");
                if (isNaN(Chance.battleTier))
                    Chance.battleTier = GuessBattleTier(playerNames);
                Logger.add("battleTier=" + Chance.battleTier);

                chanceG = GetChance(playerNames, ChanceFuncG);
                chanceT = GetChance(playerNames, ChanceFuncT);

                var text:String = "";

                if (chanceG.error)
                    return ChanceError("[G] " + chanceG.error);
                if (chanceT.error)
                    return ChanceError("[T] " + chanceT.error);

                if (showChance)
                {
                    text = Locale.get("Chance to win") + ": " + FormatChangeText("", chanceT);
                    //text = Locale.get("Team strength") + ": " + FormatChangeText("", chanceT);
                    /*if (showLive)
                    {
                        var chanceLiveT:Object = GetChance(playerNames, ChanceFuncLiveT, true);
                        text += " | " + Locale.get("chanceLive") + ": " + FormatChangeText("", chanceLiveT);
                    }*/
                }

                if (showBattleTier && Chance.battleTier != 0)
                {
                    if (text != "")
                        text += ". ";
                    text += Locale.get("chanceBattleTier") + ": " + battleTier;
                }

                Logger.add("RESULT=" + text);
                return text;
            }
            finally
            {
                Logger.add("========== end chance calculation ===========");
            }
            return null;
        }

        // PRIVATE

        private static function GetChance(playerNames:Vector.<String>, chanceFunc:Function):Object
        {
            var Ka:Number = 0;
            var Ke:Number = 0;
            var len:int = playerNames.length;
            for (var i:int = 0; i < len; ++i)
            {
                var pname:String = playerNames[i];
                var stat:StatData = Stat.getData(pname);
                if (stat.v.data == null) {
                    //if (stat.icon == "ussr-Observer" || stat.icon == "noImage")
                    //    continue;
                    return { error: "[1] No data for: " + stat.v.id };
                }

                var K:Number = chanceFunc(stat.v.data, stat);

                Ka += (stat.team == XfwConst.TEAM_ALLY) ? K : 0;
                Ke += (stat.team == XfwConst.TEAM_ENEMY) ? K : 0;
            }

            Ka /= maxTeamsCount;
            Ke /= maxTeamsCount;

            var result:Object = PrepareChanceResults(Ka, Ke, len);
            Logger.add("Ka=" + Ka.toFixed(2) + " Ke=" + Ke.toFixed(2) + " raw=" + result.raw + " percent=" + result.percent);
            return result;
        }

        // http://www.koreanrandom.com/forum/topic/2598-/#entry31429
        private static function ChanceFuncG(vdata:VehicleData, stat:StatData):Number
        {
            var T:Number = Chance.battleTier == 0 ? 8 : Chance.battleTier; // command battle tier = 8
            var Tmin:Number = vdata.tierLo;
            var Tmax:Number = vdata.tierHi;
            var Ea:Number = isNaN(stat.xwn8) ? Config.config.consts.AVG_XVMSCALE : stat.xwn8;
            var Ean:Number = Ea + (Ea * (((stat.lvl || T) - T) * 0.05));
            var Ra:Number = stat.winrate || Config.config.consts.AVG_GWR;
            var Ba:Number = stat.b || Config.config.consts.AVG_BATTLES;

            // 1
            var Klvl:Number = (Tmax + Tmin) / 2 - T;

            // 2
            var Kab:Number = (Ba <= 500) ? 0                   //   0..0.5k => 0
                : (Ba <= 5000) ? (Ba - 500) / 10000            //  1k..5k   => 0..0.45
                : (Ba <= 10000) ? 0.45 + (Ba - 5000) / 20000   //  5k..10k  => 0.45..0.7
                : (Ba <= 20000) ? 0.7 + (Ba - 10000) / 40000   // 10k..20k  => 0.7..0.95
                : 0.95 + (Ba - 20000) / 80000                  // 20k..     => 0.95..

            // 3
            var Kra:Number = (100 + Ra - 48.5) / 100;

            // 4
            var Eb:Number = ((Ean * Kra) * (Kra + Kab)) * (Kra + 0.25 * Klvl);

            // 5
            return Math.max(0, Math.min(Config.config.consts.MAX_EBN, Eb));
        }

        private static function ChanceFuncT(vdata:VehicleData, stat:StatData):Number
        {
            var T:Number = Chance.battleTier == 0 ? 8 : Chance.battleTier; // command battle tier = 8
            var Tmin:Number = vdata.tierLo;
            var Tmax:Number = vdata.tierHi;
            var Bt:Number = stat.v.b || 0;
            var Rt:Number = stat.v.winrate || Config.config.consts.AVG_GWR;
            var Et:Number = Bt >= 50 && stat.v.xte ? stat.v.xte : 0;
            var AvgW:Number = stat.v.data.avgR || Config.config.consts.AVG_GWR;
            var Ea:Number = isNaN(stat.xwn8) ? Config.config.consts.AVG_XVMSCALE : stat.xwn8;
            var Ean:Number = Ea + (Ea * (((stat.lvl || T) - T) * 0.05));
            var Ra:Number = stat.winrate || Config.config.consts.AVG_GWR;
            var Ba:Number = stat.b || Config.config.consts.AVG_BATTLES;

            // 1
            var Klvl:Number = (Tmax + Tmin) / 2 - T;

            // 2
            var Ktb:Number = (Bt <= 50) ? 0                    //    0..50   => 0
                : (Bt <= 500) ? (Bt - 50) / 1000               //   51..500  => 0..0.45
                : (Bt <= 1000) ? 0.45 + (Bt - 500) / 2000      //  501..1000 => 0.45..0.7
                : (Bt <= 2000) ? 0.7 + (Bt - 1000) / 4000      // 1001..2000 => 0.7..0.95
                : 0.95 + (Bt - 2000) / 8000;                   // 2000..     => 0.95..
            var Kab:Number = (Ba <= 500) ? 0                   //    0..0.5k => 0
                : (Ba <= 5000) ? (Ba - 500) / 10000            //   1k..5k   => 0..0.45
                : (Ba <= 10000) ? 0.45 + (Ba - 5000) / 20000   //   5k..10k  => 0.45..0.7
                : (Ba <= 20000) ? 0.7 + (Ba - 10000) / 40000   //  10k..20k  => 0.7..0.95
                : 0.95 + (Ba - 20000) / 80000                  //  20k..     => 0.95..

            // 3
            var Krt:Number = (100 + Rt - AvgW) / 100;
            var Kra:Number = (100 + Ra - 48.5) / 100;

            // 4
            var Eb:Number = (Et > 0)
                ? (((3 / 5 * Et * Krt) * (Krt + Ktb)) +
                    ((2 / 5 * Ean * Kra) * (Kra + Kab))) * (Kra + 0.25 * Klvl)
                : ((Ean * Kra) * (Kra + Kab)) * (Kra + 0.25 * Klvl);

            // 5
            return Math.max(0, Math.min(Config.config.consts.MAX_EBN, Eb));
        }

        // return: { ally: Number, enemy: Number }
        private static function CalculateTeamPlayersCount(playerNames:Vector.<String>):Object
        {
            var nally:Number = 0;
            var nenemy:Number = 0;
            for (var i:int = 0; i < playerNames.length; ++i )
            {
                var pname:String = playerNames[i];
                var stat:StatData = Stat.getData(pname);
                if (stat == null)
                    continue;
                var vdata:VehicleData = stat.v.data;
                // skip unknown tanks (Fog of War mode) and observer
                if (vdata == null || vdata.key == "ussr:Observer")
                    continue;
                if (stat.team == XfwConst.TEAM_ALLY) ++nally else ++nenemy;
            }
            return { ally: nally, enemy: nenemy };
        }

        private static function PrepareChanceResults(Ka:Number, Ke:Number, playersCount:int):Object
        {
            if (Ka == 0 && Ke == 0) Ka = Ke = 1;
            //Logger.add("Ka=" + Math.round(Ka) + " Ke=" + Math.round(Ke));

            // Spitfeuer117: http://forum.worldoftanks.eu/index.php?/topic/468409-a-1000-battle-study-on-xvm-win-chance-accuracy/
            // http://www.koreanrandom.com/forum/topic/2598-/page-34#entry223858
            var p:Number = Phi((Ka - Ke) / playersCount / 1.5) * 100;
            // old code:
            //var p:Number = (0.5 + (Ka / (Ka + Ke) - 0.5) * 1.5) * 100;

            // Normalize (5..95)
            return {
                ally: Ka,
                enemy: Ke,
                percent: Math.round(Math.max(5, Math.min(95, p))),
                raw: p,
                percentF: p.toFixed(2)
            };
        }

        /**
         * The function Φ(x) is the cumulative density function (CDF) of a standard normal (Gaussian) random variable.
         */
        private static function Phi(x:Number):Number
        {
            var a1:Number = 0.254829592;
            var a2:Number = -0.284496736;
            var a3:Number = 1.421413741;
            var a4:Number = -1.453152027;
            var a5:Number = 1.061405429;
            var p:Number = 0.3275911;

            var sign:Number = (x < 0) ? -1 : 1;
            x = Math.abs(x) / Math.sqrt(2.0);

            var t:Number = 1.0 / (1.0 + p*x);
            var y:Number = 1.0 - (((((a5*t + a4)*t) + a3)*t + a2)*t + a1)*t * Math.exp(-x*x);

            return 0.5 * (1.0 + sign*y);
        }

        private static function FormatChangeText(txt:String, chance:Object):String
        {
            var htmlText:String = (txt && txt != "") ? txt + ": " : "";
            if (!chance)
                htmlText += "-";
            else
            {
                var color:Number = GraphicsUtil.brightenColor(MacrosUtils.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_WINCHANCE, chance.raw), 50);
                var s:String = "<font color='" + XfwUtils.toHtmlColor(color) + "'>" + chance.percent + "%</font>";

                /*var n:int = 5;
                var maxValue:Number = Math.max(chanceG.ally, chanceG.enemy);
                var a:Number = Math.round(chance.ally / maxValue * n);
                var e:Number = Math.round(chance.enemy / maxValue * n);
                var s:String = "<font face='Arial' color='#444444' alpha='#CC'>" +
                    StringUtils.leftPad("", n - a, "\u2588") +
                    "<font color='" + Utils.toHtmlColor(GraphicsUtil.brightenColor(Config.config.colors.system["ally_alive"], 50)) + "'>" +
                    StringUtils.leftPad("", a, "\u2588") +
                    "</font>" +
                    "<font color='" + Utils.toHtmlColor(GraphicsUtil.brightenColor(Config.config.colors.system["enemy_alive"], 50)) + "'>" +
                    StringUtils.leftPad("", e, "\u2588") +
                    "</font>" +
                    StringUtils.leftPad("", n - e, "\u2588") +
                    "</font>";*/

                /*var s:String =
                    "<font color='" + Utils.toHtmlColor(GraphicsUtil.brightenColor(Config.config.colors.system["ally_alive"], 50)) + "'>" +
                    chanceG.ally.toFixed() +
                    "</font>" +
                    " : " +
                    "<font color='" + Utils.toHtmlColor(GraphicsUtil.brightenColor(Config.config.colors.system["enemy_alive"], 50)) + "'>" +
                    chanceG.enemy.toFixed() +
                    "</font>";*/

                htmlText += s;
            }

            return htmlText;
        }

        private static function GuessBattleTier(playerNames:Vector.<String>):Number
        {
            // 1. Collect all vehicles info
            var vis:Array = [];
            for (var i:int = 0; i < playerNames.length; ++i )
            {
                var pname:String = playerNames[i];
                var stat:StatData = Stat.getData(pname);
                var vdata:VehicleData = stat.v.data;
                if (vdata == null || vdata.key == "ussr:Observer")
                    continue;
                vis.push( {
                    level: vdata.level,
                    Tmin: vdata.tierLo,
                    Tmax: vdata.tierHi
                });
            }

            // 2. Sort vehicles info by top tiers descending
            vis.sortOn("Tmax", Array.NUMERIC | Array.DESCENDING);

            // 3. Find minimum Tmax and maximum Tmin
            var Tmin:Number = vis[0].Tmin;
            var Tmax:Number = vis[0].Tmax;
            //Logger.add("T before=" + Tmin + ".." + Tmax);
            var vis_length:int = vis.length;
            for (i = 1; i < vis_length; ++i)
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
    }
}
