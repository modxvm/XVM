/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.Utils;

class wot.BattleMain
{
  static var instance:BattleMain;
  static var minimap;

  static function main()
  {
    Utils.TraceXvmModule("Battle:main");

    Config.LoadConfig("BattleMain.as", undefined, true, BattleMainConfigLoadComplete);

    instance = new BattleMain();
    gfx.io.GameDelegate.addCallBack("battle.showPostmortemTips", instance, "showPostmortemTips");
    gfx.io.GameDelegate.addCallBack("Stage.Update", instance, "onUpdateStage");
  }

  private static function BattleMainConfigLoadComplete()
  {
    if (Config.s_config.battle.removePanelsModeSwitcher)
      _root.switcher_mc._visible = false;
  }


  function showPostmortemTips(movingUpTime, showTime, movingDownTime)
  {
    if (Config.s_config.battle.showPostmortemTips)
      _root.showPostmortemTips(movingUpTime, showTime, movingDownTime);
  }

  function onUpdateStage(width, height)
  {
    //wot.utils.Logger.add("onUpdateStage");
    _root.onUpdateStage(width, height);
    //_root.minimap.foreground._alpha = 30;
    //_root.minimap.foregroundHR._alpha = 30;
    //wot.utils.Logger.addObject(_root);
  }
}
