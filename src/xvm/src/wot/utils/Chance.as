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
import wot.utils.VehicleInfo;

class wot.utils.Chance
{
  private static var dummy = Logger.dummy; // avoid import warning

  private static var battleTier: Number = 0;

  public static function ShowChance(tf: TextField, showExp: Boolean): String
  {
    var teamsCount: Object = CalculateTeamPlayersCount();
    // only equal and non empty team supported
    if (teamsCount.ally != teamsCount.enemy || teamsCount.ally == 0)
      return tf.text;

    Chance.battleTier = Chance.GuessBattleTier();

    var chG = GetChance(ChanceFuncG);
    var chT = GetChance(ChanceFuncT);

    var htmlText = tf.text == "" ? "" : tf.text + " | ";
    if (chG.error)
      htmlText += "<font color='#FF8080'>" + Locale.get("Chance error") + "[G]: " + chG.error + "</font>";
    else if (chT.error)
      htmlText += "<font color='#FF8080'>" + Locale.get("Chance error") + "[T]: " + chG.error + "</font>";
    else
    {
      htmlText += Locale.get("Chance to win") + ": " +
        FormatChangeText(Locale.get("Global"), chG) + ", " +
        FormatChangeText(Locale.get("Per-vehicle"), chT);
      if (showExp)
      {
        var chX1 = GetChance(ChanceFuncX1);
        var chX2 = GetChance(ChanceFuncX2);
        htmlText += " | Exp: " + FormatChangeText("", chX1) + ", " + FormatChangeText("", chX2) + " T=" + battleTier;
      }
    }

    tf.htmlText = htmlText;
    return tf.htmlText;
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

      var vi = VehicleInfo.getInfo(pdata.icon);
      if (!vi || vi.level == 0)
        return { error: "No data for: " + VehicleInfo.getName(pdata.icon) };

      var K = chanceFunc(vi, pdata.team, pdata.stat);

      Ka += (pdata.team == Defines.TEAM_ALLY) ? K : 0;
      Ke += (pdata.team == Defines.TEAM_ENEMY) ? K : 0;
    }

    if (!_x1Logged && chanceFunc == ChanceFuncX1)
    {
      _x1Logged = true;
      Logger.add("X1: K = " + Ka + " / " + Ke);
    }
    if (!_x2Logged && chanceFunc == ChanceFuncX2)
    {
      _x2Logged = true;
      Logger.add("X2: K = " + Ka + " / " + Ke);
    }

    return PrepareChanceResults(Ka, Ke);
  }

  private static function ChanceFuncG(vi, team, stat): Number
  {
    var Td = (vi.tiers[0] + vi.tiers[1]) / 2.0 - battleTier;

    var E: Number = stat.e || Config.s_config.consts.AVG_EFF;
    var Rg: Number = (stat.r || Config.s_config.consts.AVG_GWR) / 100.0;

    var B: Number = stat.b || Config.s_config.consts.AVG_BATTLES;
    var Bn = (B < 10000) ? (B - 2000) / 10000.0 : 0.8 + (B - 10000) / 100000.0;

    return E * (1 + Rg - (Config.s_config.consts.AVG_GWR / 100.0)) * (1 + 0.25 * Td) * (1 + Bn);
  }

  private static function ChanceFuncT(vi, team, stat): Number
  {
    var Td = (vi.tiers[0] + vi.tiers[1]) / 2.0 - battleTier;

    var E: Number = stat.e || Config.s_config.consts.AVG_EFF;

    var Rt_pre: Number = Math.max(-10, Math.min(10, (stat.tr || Config.s_config.consts.AVG_GWR) - Config.s_config.consts.AVG_GWR));
    var Rt = Rt_pre / 100.0 * 4;

    return E * (1 + Rt) * (1 + 0.25 * Td);
  }

  private static function ChanceFuncX1(vi, team, stat): Number
  {
    //var R = stat.tr || Config.s_config.consts.AVG_GWR;
    //var T = (vi.tiers[0] + vi.tiers[1]) / 2.0 - battleTier;
    //var T = vi.tiers[1] - battleTier;
    var T = vi.tiers[0];

    //Logger.add(stat.tr + " R=" + R + " T=" + T);
    //return R;// * Math.max(0, 1 + 0.25 * T);
    return T;
  }

  private static function ChanceFuncX2(vi, team, stat): Number
  {
/*    var B = 0;
    for (var pname in StatData.s_data)
    {
      var pdata = StatData.s_data[pname];
      if (pdata.team == team)
      {
        var v = VehicleInfo.getInfo(pdata.icon);
        if (v && v.level > 0)
          B += v.tiers[1] - battleTier;
      }
    }*/

    //var R = stat.tr || Config.s_config.consts.AVG_GWR;
    var R = Math.max(-10, Math.min(10, stat.tr ? stat.tr - Config.s_config.consts.AVG_GWR : 0)) + 10;

    //var T = vi.tiers[1] - battleTier;
    var T = vi.tiers[0];
    return R * T;
  }

  // return: { ally: Number, enemy: Number }
  private static function CalculateTeamPlayersCount(): Object
  {
    var nally = 0;
    var nenemy = 0;
    for (var pname in StatData.s_data)
    {
      var pdata = StatData.s_data[pname];
      if (VehicleInfo.getName(pdata.icon).toUpperCase() == "UNKNOWN") // skip unknown tanks in Fog of War mode
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
      raw: ally / (ally + enemy) * 100
    };
  }

  // return: 5..95
  private static function NormalizeResult(a, b)
  {
    return Math.round(Math.max(0.05, Math.min(0.95, (0.5 + (a / (a + b) - 0.5) * 5.0))) * 100);
  }

  private static function GuessBattleTier(): Number
  {
    // 1. Collect all vehicles info
    var vis: Array = [];
    for (var pname in StatData.s_data)
    {
      var pdata = StatData.s_data[pname];
      var vi = VehicleInfo.getInfo(pdata.icon);
      if (!vi || vi == 0)
        return 0;
      vis.push( {
        level: vi.level,
        Tmin: vi.tiers[0],
        Tmax: vi.tiers[1]
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