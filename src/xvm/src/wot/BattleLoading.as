/**
 * ...
 * @author sirmax2
 */
import flash.filters.DropShadowFilter;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.StatLoader;
import wot.utils.Chance;
import wot.utils.Utils;

class wot.BattleLoading extends net.wargaming.BattleLoading
{
  private static var s_infoField: TextField;
  private static var s_chanceField: TextField = null;
  private static var s_chanceText: String;

  public function BattleLoading()
  {
    super();

    Utils.TraceXvmModule("BattleLoading");

    GlobalEventDispatcher.addEventListener("config_loaded", this, BattleLoadingConfigLoaded);
    Config.LoadConfig("BattleLoading.as");

    GlobalEventDispatcher.addEventListener("set_info", this, SetInfoFieldData);
    SetInfoFieldData({ });
  }

  public function BattleLoadingConfigLoaded()
  {
    if (Config.s_config.rating.showPlayersStatistics)
    {
      // Just to check config is loaded correctly
      Logger.add("[BattleLoading]\n" +
        "  XVM_VERSION=" + Defines.XVM_VERSION + "\n" +
        "  MAX_PATH=" + Defines.MAX_PATH + "\n" +
        "  GameRegion=" + Config.s_game_region + "\n" +
        "  configVersion=" + Config.s_config.configVersion + "\n" +
        "  showPlayersStatistics=true\n" +
        "  loadEnemyStatsInFogOfWar=" + Config.s_config.rating.loadEnemyStatsInFogOfWar + "\n" +
        "  useStandardMarkers=" + Config.s_config.battle.useStandardMarkers);
    }

    if (Config.s_config.battleLoading.showClock)
      ShowClock();

    if (Config.s_config.rating.showPlayersStatistics)
    {
      // Force stats loading after 0.5 sec (for 12x12 battles, FogOfWar, ...)
      setInterval(StatLoader.StartLoadData, 500);
    }
  }

  public function ShowClock()
  {
    var clock = createTextField("clock", getNextHighestDepth(), 280, 25, 100, 40);
    clock.antiAliasType = "advanced";
    clock.setNewTextFormat(new TextFormat("$TitleFont", 32, 0xFFFFFF, false, false, false, null, null, "center"));
    clock.filters = [ new DropShadowFilter(0, 0, 0, 100, 5, 5, 5, 3) ];
    clock.text = Utils.padLeft(String((new Date()).getHours()), 2, '0') + ":" + Utils.padLeft(String((new Date()).getMinutes()), 2, '0');
  }

  public function CreateInfoField()
  {
    s_infoField = createTextField("info", getNextHighestDepth(), _width / 2, 0, 400, 100);
    s_infoField.wordWrap = true;
    s_infoField.antiAliasType = "advanced";
    s_infoField.setNewTextFormat(new TextFormat("$FieldFont", 12, 0xFFFFFF, true, false, false, null, null, "left"));
    s_infoField.filters = [ new DropShadowFilter(0, 0, 0, 100, 3, 3, 1, 3) ];
  }
  
  public function SetInfoFieldData(event)
  {
    //Logger.addObject(event, "SetInfoFieldData(event)");

    if (!s_infoField)
      CreateInfoField();

    var txt: String = "XVM v" + Defines.XVM_VERSION + " ";

    if (event.ver && Utils.compareVersions(String(event.ver), Defines.XVM_VERSION) == 1)
    {
      txt = "XVM: New version available: v" + String(event.ver) + " (current is v" + Defines.XVM_VERSION + ")\n";
      if (event.message)
        txt += event.message + "\n";
      s_infoField.textColor = 0xAAFFAA;
    }

    if (event.error)
    {
      txt += event.error + "\n";
      s_infoField.textColor = 0xFF8080;
    }

    if (event.warning)
    {
      txt += event.warning + "\n";
      s_infoField.textColor = 0xFFFFCC;
    }

    s_infoField.text = txt;

    // Chance
    if (StatLoader.s_loaded && Config.s_config.battleLoading.showChances)
    {
      if (!s_chanceField)
      {
        s_chanceField = form_mc.battleText;
        s_chanceText = Chance.ShowChance(s_chanceField, Config.s_config.battleLoading.showChancesExp);
      }
      if (s_chanceField.htmlText != s_chanceText)
      {
        //wot.utils.Logger.add(s_chanceField.htmlText);
        s_chanceField.html = true;
        s_chanceField.htmlText = s_chanceText;
      }
    }
  }
}
