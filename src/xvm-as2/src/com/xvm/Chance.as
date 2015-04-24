/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.*;
import com.xvm.DataTypes.*;

class com.xvm.Chance
{
    private static var battleTier: Number = 0;
    private static var maxTeamsCount:Number = 0;
    private static var chanceG:Object;
    private static var chanceT:Object;

    //public static var lastChances: Object = null;

    public static function ShowChance(tf:TextField, showLive:Boolean):String
    {
        var text = GetChanceText(showLive);
        if (text == null)
            return tf.text;
        tf.htmlText = (tf.text == "" ? "" : tf.text + " | ") + text;
        return tf.htmlText;
    }

    public static function ChanceError(text:String):String
    {
        return "<font color='#FFBBBB'>" + Locale.get("Chance error") + ": " + text + "</font>";
    }

    public static function GetChanceText(showChances:Boolean, showBattleTier:Boolean, showLive:Boolean):String
    {
        var teamsCount:Object = CalculateTeamPlayersCount();
        //Logger.addObject(teamsCount);
        // non empty teams required
        if (teamsCount.ally == 0 || teamsCount.enemy == 0)
            return "";

        maxTeamsCount = Math.max(teamsCount.ally, teamsCount.enemy);

        Chance.battleTier = Macros.getGlobalValue("battletier");

        chanceG = GetChance(ChanceFuncG, false);
        chanceT = GetChance(ChanceFuncT, false);

        var text = "";

        if (chanceG.error)
            return ChanceError("[G] " + chanceG.error);
        if (chanceT.error)
            return ChanceError("[T] " + chanceT.error);

        if (showChances)
        {
            text += Locale.get("Chance to win") + ": " + FormatChangeText("", chanceT);
            //text += Locale.get("Team strength") + ": " + FormatChangeText("", chanceT);
            if (showLive)
            {
                var chanceLiveT:Object = GetChance(ChanceFuncLiveT, true);
                text += " | " + Locale.get("chanceLive") + ": " + FormatChangeText("", chanceLiveT);
            }
        }

        if (showBattleTier && Chance.battleTier != 0)
        {
            if (text !== "")
                text += ". ";
            text += Locale.get("chanceBattleTier") + ": " + Chance.battleTier;
        }

        //Logger.add(text);
        return text;
    }

    // PRIVATE

    private static function GetChance(chanceFunc: Function, live:Boolean): Object
    {
        var Ka:Number = 0;
        var Ke:Number = 0;
        var len:Number = 0;
        for (var pname in Stat.s_data)
        {
            var stat:StatData = Stat.s_data[pname].stat;
            var battleStateData:BattleStateData = BattleState.getUserData(pname);
            len += live && battleStateData.dead ? 0 : 1;
            var vdata:VehicleData = stat.v.data;
            if (!vdata)
                return { error: "[1] No data for: " + stat.nm };

            //Logger.add(pdata.vehicleState);
            var K:Number = chanceFunc(vdata, stat, battleStateData);

            Ka += (stat.team == Defines.TEAM_ALLY) ? K : 0;
            Ke += (stat.team == Defines.TEAM_ENEMY) ? K : 0;
        }

        Ka /= maxTeamsCount;
        Ke /= maxTeamsCount;

        var result:Object = PrepareChanceResults(Ka, Ke, len);
        //Logger.add("Ka=" + Ka + " Ke=" + Ke + " raw=" + result.raw + " percent=" + result.percent);
        return result;
    }

    // http://www.koreanrandom.com/forum/topic/2598-/#entry31429
    private static function ChanceFuncG(vdata:VehicleData, stat:StatData, battleStateData:BattleStateData):Number
    {
        var T:Number = Chance.battleTier == 0 ? 8 : Chance.battleTier; // command battle tier = 8
        var Tmin:Number = vdata.tierLo;
        var Tmax:Number = vdata.tierHi;
        var Ea:Number = isNaN(stat.xwn8) ? Config.config.consts.AVG_XVMSCALE : stat.xwn8;
        var Ean:Number = Ea + (Ea * (((stat.lvl || T) - T) * 0.05));
        var Ra:Number = stat.winrate || Config.config.consts.AVG_GWR;
        var Ba:Number = stat.b || Config.config.consts.AVG_BATTLES;

        // 1
        var Klvl:Number = (Tmax + Tmin) / 2.0 - T;

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

    private static function ChanceFuncLiveG(vdata:VehicleData, stat:StatData, battleStateData:BattleStateData):Number
    {
        if (battleStateData.dead == true)
            return 0;
        return ChanceFuncG(vdata, stat, battleStateData);
    }

    private static function ChanceFuncT(vdata:VehicleData, stat, battleStateData:BattleStateData):Number
    {
        var T:Number = Chance.battleTier == 0 ? 8 : Chance.battleTier; // command battle tier = 8
        var Tmin:Number = vdata.tierLo;
        var Tmax:Number = vdata.tierHi;
        var Bt:Number = stat.v.b || 0;
        var Et:Number = stat.v.xte || 0;
        var Rt:Number = stat.v.winrate || 0;
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

    private static function ChanceFuncLiveT(vdata:VehicleData, stat:StatData, battleStateData:BattleStateData):Number
    {
        if (battleStateData.dead == true)
            return 0;
        return ChanceFuncT(vdata, stat, battleStateData);
    }

    // return: { ally: Number, enemy: Number }
    private static function CalculateTeamPlayersCount(): Object
    {
        var nally = 0;
        var nenemy = 0;
        for (var pname in Stat.s_data)
        {
            var stat:StatData = Stat.s_data[pname].stat;
            var vdata:VehicleData = stat.v.data;
            if (vdata == null || vdata.key == "ussr:Observer")
                continue;
            if (stat.team == Defines.TEAM_ALLY) ++nally else ++nenemy;
        }
        return { ally: nally, enemy: nenemy };
    }

    private static function PrepareChanceResults(Ka:Number, Ke:Number, playersCount:Number):Object
    {
        if (Ka == 0 && Ke == 0) Ka = Ke = 1;
        //Logger.add("Ka=" + Math.round(Ka) + " Ke=" + Math.round(Ke));

        //var p:Number = Math.max(0.05, Math.min(0.95, (0.5 + (Ka / (Ka + Ke) - 0.5) * 1.5))) * 100;

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
            percentF: Math.round(1000 * p) / 1000
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

    private static function FormatChangeText(txt, chance)
    {
        var htmlText = (txt && txt != "") ? txt + ": " : "";
        if (!chance)
            htmlText += "-";
        else
        {
            var color:Number = GraphicsUtil.brightenColor(GraphicsUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_WINCHANCE, chance.raw), 50);
            var s:String = "<font color='#" + color.toString(16) + "'>" + chance.percent + "%</font>";

            /*var n:Number = 5;
            var maxValue:Number = Math.max(chanceG.ally, chanceG.enemy);
            var a:Number = Math.round(chance.ally / maxValue * n);
            var e:Number = Math.round(chance.enemy / maxValue * n);
            var s:String = "<font face='Arial' color='#444444' alpha='#CC'>" +
                Strings.padLeft("", n - a, "\u2588") +
                "<font color='" + Utils.toHtmlColor(GraphicsUtil.brightenColor(Config.config.colors.system["ally_alive"], 50)) + "'>" +
                Strings.padLeft("", a, "\u2588") +
                "</font>" +
                "<font color='" + Utils.toHtmlColor(GraphicsUtil.brightenColor(Config.config.colors.system["enemy_alive"], 50)) + "'>" +
                Strings.padLeft("", e, "\u2588") +
                "</font>" +
                Strings.padLeft("", n - e, "\u2588") +
                "</font>";*/

            /*var s:String =
                "<font color='" + Utils.toHtmlColor(GraphicsUtil.brightenColor(Config.config.colors.system["ally_alive"], 50)) + "'>" +
                Math.round(chance.ally) +
                "</font>" +
                " : " +
                "<font color='" + Utils.toHtmlColor(GraphicsUtil.brightenColor(Config.config.colors.system["enemy_alive"], 50)) + "'>" +
                Math.round(chance.enemy) +
                "</font>";*/

            htmlText += s;
        }

        return htmlText;
    }
}
