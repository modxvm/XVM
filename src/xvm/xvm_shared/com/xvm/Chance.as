/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.battle.*;
    import com.xvm.types.stat.*;
    import com.xvm.vo.*;

    public class Chance
    {
        public static const CHANCE_TYPE_WIN_CHANCE:int = 1;
        public static const CHANCE_TYPE_TEAM_STRENGTH_ALLY:int = 2;
        public static const CHANCE_TYPE_TEAM_STRENGTH_ENEMY:int = 3;

        private static var battleLevel:Number = 0;
        private static var maxTeamsCount:Number = 0;
        private static var chanceG:Object = null;
        private static var chanceT:Object = null;
        private static var chanceLiveT:Object = null;

        public static function formatWinChancesText(stats:Object, type:int, isShowChance:Boolean, isShowLiveChance:Boolean):String
        {
            if (!Config.networkServicesSettings.statBattle)
            {
                return "";
            }
            if (!Config.networkServicesSettings.chance && isShowChance)
            {
                return "";
            }
            if (!Config.networkServicesSettings.chanceLive && isShowLiveChance)
            {
                return "";
            }
            var playerNames:Vector.<String> = new Vector.<String>();
            for (var name:String in stats)
            {
                playerNames.push(name);
            }

            if (isShowChance)
            {
                if (chanceT == null)
                {
                    GetChanceText(playerNames, stats, true, false, false);
                }
                return FormatChangeText(chanceT, type) || "";
            }
            else if (isShowLiveChance)
            {
                if (chanceLiveT == null)
                {
                    GetChanceText(playerNames, stats, false, false, true);
                }
                return FormatChangeText(chanceLiveT, type) || "";
            }
            else
            {
                return "";
            }
        }

        public static function ChanceError(text:String):String
        {
            return "<font color='#FFBBBB'>" + Locale.get("Chance error") + ": " + text + "</font>";
        }

        public static function GetChanceText(playerNames:Vector.<String>, stats:Object,
            showChance:Boolean, showBattleLevel:Boolean, showLive:Boolean = false, showLog:Boolean = false):String
        {
            var teamsCount:Object = null;
            if (showLog) Logger.add("========== begin chance calculation ===========");
            try
            {
                if (showLog) Logger.add("playerNames: " + playerNames.join(", "));
                teamsCount = CalculateTeamPlayersCount(playerNames, stats);
                if (showLog) Logger.add("teamsCount=" + teamsCount.ally + "/" + teamsCount.enemy);
                // non empty teams required
                if (teamsCount.ally == 0 || teamsCount.enemy == 0)
                    return "";

                maxTeamsCount = Math.max(teamsCount.ally, teamsCount.enemy);

                Chance.battleLevel = BattleGlobalData.battleLevel;
                if (isNaN(Chance.battleLevel))
                    Chance.battleLevel = GuessBattleLevel(playerNames, stats);
                if (showLog) Logger.add("battleLevel=" + Chance.battleLevel);

                chanceG = GetChance(playerNames, stats, ChanceFuncG, false, showLog);
                chanceT = GetChance(playerNames, stats, ChanceFuncT, false, showLog);

                var text:String = "";

                if (chanceG.error)
                    return ChanceError("[G] " + chanceG.error);
                if (chanceT.error)
                    return ChanceError("[T] " + chanceT.error);

                if (showChance)
                {
                    text = Locale.get("Chance to win") + ": " + FormatChangeText(chanceT, CHANCE_TYPE_WIN_CHANCE);
                    //text = Locale.get("Team strength") + ": " + FormatChangeText(chanceT);
                    if (showLive)
                    {
                        chanceLiveT = GetChance(playerNames, stats, ChanceFuncLiveT, true, showLog);
                        text += " | " + Locale.get("chanceLive") + ": " + FormatChangeText(chanceLiveT, CHANCE_TYPE_WIN_CHANCE);
                    }
                }

                if (showBattleLevel && Chance.battleLevel != 0)
                {
                    if (text)
                        text += ". ";
                    text += Locale.get("chanceBattleTier") + ": " + battleLevel;
                }

                if (showLog) Logger.add("RESULT=" + text);
                return text;
            }
            finally
            {
                if (showLog) Logger.add("========== end chance calculation ===========");
            }
            return null;
        }

        // PRIVATE

        private static function GetChance(playerNames:Vector.<String>, stats:Object, chanceFunc:Function, live:Boolean, showLog:Boolean):Object
        {
            var Ka:Number = 0;
            var Ke:Number = 0;
            var count:int = 0;
            var len:int = playerNames.length;
            for (var i:int = 0; i < len; ++i)
            {
                var pname:String = playerNames[i];
                var stat:StatData = stats[pname];
                count += live && !stat.alive ? 0 : 1;
                if (stat.v.data == null) {
                    //if (stat.icon == "ussr-Observer" || stat.icon == "noImage")
                    //    continue;
                    return { error: "[1] No data for: " + stat.v.id };
                }

                var K:Number = chanceFunc(stat);

                Ka += (stat.team == XfwConst.TEAM_ALLY) ? K : 0;
                Ke += (stat.team == XfwConst.TEAM_ENEMY) ? K : 0;
            }

            Ka /= maxTeamsCount;
            Ke /= maxTeamsCount;

            var result:Object = PrepareChanceResults(Ka, Ke, count);
            if (showLog) Logger.add("Ka=" + result.ally.toFixed(2) + " Ke=" + result.enemy.toFixed(2) + " raw=" + result.raw + " percent=" + result.percent);
            return result;
        }

        // http://www.koreanrandom.com/forum/topic/2598-/#entry31429
        private static function ChanceFuncG(stat:StatData):Number
        {
            var T:Number = Chance.battleLevel == 0 ? 8 : Chance.battleLevel; // command battle level = 8
            var Tmin:Number = stat.v.data.tierLo;
            var Tmax:Number = stat.v.data.tierHi;
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

        private static function ChanceFuncLiveG(stat:StatData):Number
        {
            if (!stat.alive)
                return 0;
            return ChanceFuncG(stat);
        }

        private static function ChanceFuncT(stat:StatData):Number
        {
            var T:Number = Chance.battleLevel == 0 ? 8 : Chance.battleLevel; // command battle level = 8
            var Tmin:Number = stat.v.data.tierLo;
            var Tmax:Number = stat.v.data.tierHi;
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

        private static function ChanceFuncLiveT(stat:StatData):Number
        {
            if (!stat.alive)
                return 0;
            return ChanceFuncT(stat);
        }

        // return: { ally: Number, enemy: Number }
        private static function CalculateTeamPlayersCount(playerNames:Vector.<String>, stats:Object):Object
        {
            var nally:Number = 0;
            var nenemy:Number = 0;
            var len:int = playerNames.length;
            for (var i:int = 0; i < len; ++i)
            {
                var pname:String = playerNames[i];
                var stat:StatData = stats[pname];
                if (stat == null)
                    continue;
                var vdata:VOVehicleData = stat.v.data;
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
            //Logger.add("Ka=" + Math.round(Ka) + " Ke=" + Math.round(Ke) + " count=" + playersCount);

            // Spitfeuer117: http://forum.worldoftanks.eu/index.php?/topic/468409-a-1000-battle-study-on-xvm-win-chance-accuracy/
            // http://www.koreanrandom.com/forum/topic/2598-/page-34#entry223858
            var p:Number = Phi((Ka - Ke) / playersCount / 1.5) * 100;
            // old code:
            //var p:Number = (0.5 + (Ka / (Ka + Ke) - 0.5) * 1.5) * 100;

            // Normalize (5..95)
            return {
                ally: Ka / 2.0,
                enemy: Ke / 2.0,
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

        private static function FormatChangeText(chance:Object, type:int):String
        {
            if (!chance)
                return "-";

            switch (type)
            {
                case CHANCE_TYPE_WIN_CHANCE:
                    var color:Number = GraphicsUtil.brightenColor(MacrosUtils.getDynamicColorValueInt(Defines.DYNAMIC_COLOR_WINCHANCE, chance.raw), 50);
                    return "<font color='" + XfwUtils.toHtmlColor(color) + "'>" + chance.percent + "%</font>";

                case CHANCE_TYPE_TEAM_STRENGTH_ALLY:
                    return chance.ally.toFixed();

                case CHANCE_TYPE_TEAM_STRENGTH_ENEMY:
                    return chance.enemy.toFixed();
            }

            /*
            var n:int = 10;
            var maxValue:Number = Math.max(chance.ally, chance.enemy);
            var a:Number = Math.round(chance.ally / maxValue * n);
            var e:Number = Math.round(chance.enemy / maxValue * n);
            htmlText += "  <font face='Arial' color='#444444' alpha='#CC'>" +
                XfwUtils.leftPad("", n - a, "\u2588") +
                "<font color='" + XfwUtils.toHtmlColor(GraphicsUtil.brightenColor(Config.config.colors.system["ally_alive"], 50)) + "'>" +
                XfwUtils.leftPad("", a, "\u2588") +
                "</font>" +
                "<font color='" + XfwUtils.toHtmlColor(GraphicsUtil.brightenColor(Config.config.colors.system["enemy_alive"], 50)) + "'>" +
                XfwUtils.leftPad("", e, "\u2588") +
                "</font>" +
                XfwUtils.leftPad("", n - e, "\u2588") +
                "</font>";
            */

            /*
            htmlText += "  " +
                "<font color='" + XfwUtils.toHtmlColor(GraphicsUtil.brightenColor(Config.config.colors.system["ally_alive"], 50)) + "'>" +
                chance.ally.toFixed() +
                "</font>" +
                " : " +
                "<font color='" + XfwUtils.toHtmlColor(GraphicsUtil.brightenColor(Config.config.colors.system["enemy_alive"], 50)) + "'>" +
                chance.enemy.toFixed() +
                "</font>";
             */

            return "-";
        }

        private static function GuessBattleLevel(playerNames:Vector.<String>, stats:Object):Number
        {
            // 1. Collect all vehicles info
            var vis:Array = [];
            var len:int = playerNames.length;
            for (var i:int = 0; i < len; ++i)
            {
                var pname:String = playerNames[i];
                var stat:StatData = stats[pname];
                var vdata:VOVehicleData = stat.v.data;
                if (vdata == null || vdata.key == "ussr:Observer")
                    continue;
                vis.push( {
                    level: vdata.level,
                    Tmin: vdata.tierLo,
                    Tmax: vdata.tierHi
                });
            }

            // 2. Sort vehicles info by top levels descending
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

            //// 4. Calculate average level
            //return (Tmax + Tmin) / 2.0;
            // 4. Return max level
            return Tmax;
        }
    }
}
