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
        htmlText += " | Exp: " + FormatChangeText("", chX1);
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

    var Xa = 0;
    var Xe = 0;

    //Logger.add("eff=" + Config.s_config.const.AVG_EFF + " gwr=" + Config.s_config.const.AVG_GWR + " bat=" + Config.s_config.const.AVG_BATTLES);

    for (var pname in StatData.s_data)
    {
      var pdata = StatData.s_data[pname];

      var vi = VehicleInfo.getInfo(pdata.icon);
      if (!vi || vi.level == 0)
        return { error: "No data for: " + VehicleInfo.getName(pdata.icon) };

      var tx = (vi.tiers[0] + vi.tiers[1]) / 2.0 - battleTier;

      var eff: Number = pdata.stat.e || Config.s_config.const.AVG_EFF;
      var gwr: Number = (pdata.stat.r || Config.s_config.const.AVG_GWR) / 100.0;
      var bat: Number = (pdata.stat.b || Config.s_config.const.AVG_BATTLES) / 100000.0;

      var m = eff * (1 + gwr - (Config.s_config.const.AVG_GWR / 100.0)) * (1 + 0.25 * tx) * (1 + bat);

      //Logger.add("eff=" + eff + " gwr=" + gwr + " bat=" + bat + " m=" + m);

      Xa += (pdata.team == Defines.TEAM_ALLY) ? m : 0;
      Xe += (pdata.team == Defines.TEAM_ENEMY) ? m : 0;
    }

    return PrepareChanceResults(Xa, Xe);
  }

  private static function GetChanceT(teamsCount, battleTier): Object
  {
    // only equal and non empty team supported
    if (teamsCount.ally != teamsCount.enemy || teamsCount.ally == 0)
      return null;

    var Xa = 0;
    var Xe = 0;

    //Logger.add("eff=" + Config.s_config.const.AVG_EFF + " gwr=" + Config.s_config.const.AVG_GWR + " bat=" + Config.s_config.const.AVG_BATTLES);

    var AVG_GWR = Config.s_config.const.AVG_GWR;
    for (var pname in StatData.s_data)
    {
      var pdata = StatData.s_data[pname];

      var vi = VehicleInfo.getInfo(pdata.icon);
      if (!vi || vi.level == 0)
        return { error: "No data for: " + VehicleInfo.getName(pdata.icon) };

      var tx = (vi.tiers[0] + vi.tiers[1]) / 2.0 - battleTier;

      var eff: Number = pdata.stat.e || Config.s_config.const.AVG_EFF;

      var twr_pre: Number = Math.max(-10, Math.min(10, (pdata.stat.tr || AVG_GWR) - AVG_GWR));
      var twr = twr_pre / 100.0 * 4;

      var m = eff * (1 + twr) * (1 + 0.25 * tx);

      //Logger.add("eff=" + eff + " twr=" + twr + " m=" + m);

      Xa += (pdata.team == Defines.TEAM_ALLY) ? m : 0;
      Xe += (pdata.team == Defines.TEAM_ENEMY) ? m : 0;
    }

    return PrepareChanceResults(Xa, Xe);
  }

  private static function GetChanceX1(teamsCount, battleTier): Object
  {
    // only equal and non empty team supported
    if (teamsCount.ally != teamsCount.enemy || teamsCount.ally == 0)
      return null;

    var Xa = 0;
    var Xe = 0;

    //Logger.add("eff=" + Config.s_config.const.AVG_EFF + " gwr=" + Config.s_config.const.AVG_GWR + " bat=" + Config.s_config.const.AVG_BATTLES);

    for (var pname in StatData.s_data)
    {
      var pdata = StatData.s_data[pname];

      var vi = VehicleInfo.getInfo(pdata.icon);
      if (!vi || vi.level == 0)
        return { error: "No data for: " + VehicleInfo.getName(pdata.icon) };

      var tx = (vi.tiers[0] + vi.tiers[1]) / 2.0 - battleTier;

      var eff: Number = pdata.stat.e || Config.s_config.const.AVG_EFF;
      var gwr: Number = (pdata.stat.r || Config.s_config.const.AVG_GWR) / 100.0;

      var bat: Number = pdata.stat.b || Config.s_config.const.AVG_BATTLES;
      bat = (bat < 10000) ? (bat - 2000) / 10000.0 : 0.8 + (bat - 10000) / 100000.0;

      var m = eff * (1 + gwr - (Config.s_config.const.AVG_GWR / 100.0)) * (1 + 0.25 * tx) * (1 + bat);

      //Logger.add("eff=" + eff + " gwr=" + gwr + " bat=" + bat + " m=" + m);

      Xa += (pdata.team == Defines.TEAM_ALLY) ? m : 0;
      Xe += (pdata.team == Defines.TEAM_ENEMY) ? m : 0;
    }

    return PrepareChanceResults(Xa, Xe);
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
    var vis = [];
    for (var pname in StatData.s_data)
    {
      var pdata = StatData.s_data[pname];
      var vi = VehicleInfo.getInfo(pdata.icon);
      if (!vi || vi == 0)
        return 0;
      vis.push(vi);
    }

    // 1. Find top tank tiers
    var tierMin = 1;
    var tierMax = 1;
    var vis_length = vis.length;
    for (var i = 0; i < vis_length; ++i)
    {
      var vi = vis[i];
      if (vi.tiers[1] < tierMax)
        continue;
      if (vi.tiers[1] > tierMax)
      {
        tierMax = vi.tiers[1];
        tierMin = vi.tiers[0];
        continue;
      }
      if (vi.tiers[0] > tierMin)
        tierMin = vi.tiers[0];
    }
    //Logger.add("tiers=" + tierMin + ".." + tierMax);

    for (var i = 0; i < vis_length; ++i)
    {
      var vi = vis[i];
      if (vi.tiers[1] < tierMin)
        continue;
      if (vi.tiers[1] == tierMin)
        return tierMin;
      tierMax = Math.min(vi.tiers[1], tierMax);
      //Logger.add("tiers=" + tierMin + ".." + tierMax);
    }

    //Logger.add("avg tier: " + (tierMax + tierMin) / 2.0);
    return (tierMax + tierMin) / 2.0;
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