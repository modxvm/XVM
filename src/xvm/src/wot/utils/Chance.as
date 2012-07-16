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

  public static function ShowChance(tf: TextField, showExp: Boolean): String
  {
    var teamsCount: Object = CalculateTeamPlayersCount();
    var battleTier: Number = Chance.GuessBattleTier();
    //Logger.add("teamsCount: [" + teamsCount[0] + "," + teamsCount[1] + "], tier: " + tier);

    var chG = GetChanceG(teamsCount, battleTier);
    var chT = GetChanceT(teamsCount, battleTier);
    var chX1 = GetChanceX1(teamsCount, battleTier);
    //var chX2 = GetChanceX2(teamsCount, battleTier);

    if (chG == null && chT == null)
      return tf.htmlText;

    tf.html = true;
    tf._width += 300;
    tf._x -= 150;

    var htmlText;
    if (chG.error)
      htmlText = tf.text + " | <font color='#FF8080'>" + Locale.get("Chance error") + "[G]: " + chG.error + "</font>";
    else if (chT.error)
      htmlText = tf.text + " | <font color='#FF8080'>" + Locale.get("Chance error") + "[T]: " + chG.error + "</font>";
    else
    {
      htmlText = tf.text + " | " + Locale.get("Chance to win") + ": " +
        FormatChangeText(Locale.get("Global"), chG) + ", " +
        FormatChangeText(Locale.get("Per-vehicle"), chT);
      if (showExp)
        htmlText += " | Exp: " + FormatChangeText("", chX1) + " T=" + battleTier;
    }

    tf.htmlText = htmlText;
    return tf.htmlText;
  }

  // PRIVATE

  private static function GetChanceG(teamsCount, battleTier): Object
  {
    // only equal and non empty team supported
    if (teamsCount.ally != teamsCount.enemy || teamsCount.ally == 0)
      return null;

    //Logger.add("eff=" + Config.s_config.const.AVG_EFF + " gwr=" + Config.s_config.const.AVG_GWR + " bat=" + Config.s_config.const.AVG_BATTLES);

    var Ka = 0;
    var Ke = 0;
    var AVG_GWR = Config.s_config.const.AVG_GWR;
    for (var pname in StatData.s_data)
    {
      var pdata = StatData.s_data[pname];

      var vi = VehicleInfo.getInfo(pdata.icon);
      if (!vi || vi.level == 0)
        return { error: "No data for: " + VehicleInfo.getName(pdata.icon) };

      var Td = (vi.tiers[0] + vi.tiers[1]) / 2.0 - battleTier;

      var E: Number = pdata.stat.e || Config.s_config.const.AVG_EFF;
      var Rg: Number = (pdata.stat.r || AVG_GWR) / 100.0;

      var B: Number = pdata.stat.b || Config.s_config.const.AVG_BATTLES;
      var Bn = (B < 10000) ? (B - 2000) / 10000.0 : 0.8 + (B - 10000) / 100000.0;

      var K = E * (1 + Rg - (AVG_GWR / 100.0)) * (1 + 0.25 * Td) * (1 + Bn);

      Ka += (pdata.team == Defines.TEAM_ALLY) ? K : 0;
      Ke += (pdata.team == Defines.TEAM_ENEMY) ? K : 0;
    }

    return PrepareChanceResults(Ka, Ke);
  }

  private static function GetChanceT(teamsCount, battleTier): Object
  {
    // only equal and non empty team supported
    if (teamsCount.ally != teamsCount.enemy || teamsCount.ally == 0)
      return null;

    //Logger.add("eff=" + Config.s_config.const.AVG_EFF + " gwr=" + Config.s_config.const.AVG_GWR + " bat=" + Config.s_config.const.AVG_BATTLES);

    var Ka = 0;
    var Ke = 0;
    var AVG_GWR = Config.s_config.const.AVG_GWR;
    for (var pname in StatData.s_data)
    {
      var pdata = StatData.s_data[pname];

      var vi = VehicleInfo.getInfo(pdata.icon);
      if (!vi || vi.level == 0)
        return { error: "No data for: " + VehicleInfo.getName(pdata.icon) };

      var Td = (vi.tiers[0] + vi.tiers[1]) / 2.0 - battleTier;

      var E: Number = pdata.stat.e || Config.s_config.const.AVG_EFF;

      var Rt_pre: Number = Math.max(-10, Math.min(10, (pdata.stat.tr || AVG_GWR) - AVG_GWR));
      var Rt = Rt_pre / 100.0 * 4;

      var K = E * (1 + Rt) * (1 + 0.25 * Td);

      Ka += (pdata.team == Defines.TEAM_ALLY) ? K : 0;
      Ke += (pdata.team == Defines.TEAM_ENEMY) ? K : 0;
    }

    return PrepareChanceResults(Ka, Ke);
  }

  private static function GetChanceX1(teamsCount, battleTier): Object
  {
    // only equal and non empty team supported
    if (teamsCount.ally != teamsCount.enemy || teamsCount.ally == 0)
      return null;

    var Ka = 0;
    var Ke = 0;
    //var Ta = 0;
    //var Te = 0;
    var AVG_GWR = Config.s_config.const.AVG_GWR;
    for (var pname in StatData.s_data)
    {
      var pdata = StatData.s_data[pname];
      var vi = VehicleInfo.getInfo(pdata.icon);
      if (!vi || vi.level == 0)
        return { error: "No data for: " + VehicleInfo.getName(pdata.icon) };

      var T = vi.tiers[1] - battleTier;
      var R: Number = (pdata.stat.tr || AVG_GWR) / 100;

      var K = T * R;

      Ka += (pdata.team == Defines.TEAM_ALLY) ? K : 0;
      Ke += (pdata.team == Defines.TEAM_ENEMY) ? K : 0;
      //Ta += (pdata.team == Defines.TEAM_ALLY) ? T : 0;
      //Te += (pdata.team == Defines.TEAM_ENEMY) ? T : 0;

      //Logger.add("T=" + T + " R=" + R);
    }

    //var Wa = Ka / Ta;
    //var We = Ke / Te;

    //var M = (Wa - We) * 100;
    //var P = 48 + M * teamsCount.ally;

    //Logger.add("Ka=" + Ka + " Ta=" + Ta + " Wa=" + Wa);
    //Logger.add("Ke=" + Ke + " Te=" + Te + " We=" + We);
    //Logger.add("M=" + M + " P=" + P);

/*    return
    {
      ally_value: Wa,
      enemy_value: We,
      percent: Math.round(P),
      raw: Math.round(P)
    };*/
    return PrepareChanceResults(Ka, Ke);
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

    // 4. Calculate average tier
    return (Tmax + Tmin) / 2.0;
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