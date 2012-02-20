/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;

class wot.Main
{
  // override
  static var instance:Main;

  static function main()
  {
    Config.LoadConfigAndStat("XVM.xvmconf");

    instance = new Main();

    gfx.io.GameDelegate.addCallBack("battle.showPostmortemTips", instance, "showPostmortemTips");
  }

  function showPostmortemTips(movingUpTime, showTime, movingDownTime)
  {
    if (Config.bool("battle/showPostmortemTips", true))
      _root.showPostmortemTips(movingUpTime, showTime, movingDownTime);
  }
}
