/**
 * ...
 * @author sirmax2
 */
import wot.utils.Config;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.Utils;

class wot.BattleMain
{
  static var instance: BattleMain;
  //static var minimap;
  //static var timerBig;
  //static var leftPanel;
  //static var rightPanel;
  //static var debugPanel;
  //static var playerMessangersPanel;
  //static var vehicleMessagesPanel;
  //static var damagePanel;
  //static var statHidden;

  private static var dummy = Logger.dummy;
  
  static function main()
  {
    Utils.TraceXvmModule("Battle:main");

    GlobalEventDispatcher.addEventListener("config_loaded", BattleMainConfigLoaded);
    Config.LoadConfig("BattleMain.as");

    instance = new BattleMain();
    gfx.io.GameDelegate.addCallBack("battle.showPostmortemTips", instance, "showPostmortemTips");
    gfx.io.GameDelegate.addCallBack("Stage.Update", instance, "onUpdateStage");
    gfx.io.GameDelegate.addCallBack("battle.arenaData", instance, "setArenaData");
  }

  private static function BattleMainConfigLoaded()
  {
    //Logger.add("BattleMainConfigLoaded()");

    GlobalEventDispatcher.removeEventListener("config_loaded", BattleMainConfigLoaded);
    
    //Logger.addObject(_root.debugPanel.fgMC.lag);
    //_root.timerBig.win.winText

    // Disable ugly battle task animation
    _root.timerBig.win.winText.duration = 1;
    
    if (Config.s_config.battle.removePanelsModeSwitcher)
      _root.switcher_mc._visible = false;
      
    // Show Clocks
    ShowClock(Config.s_config.battle.clockFormat);
  }

  private static function ShowClock(format)
  {
    if (!format || format == "")
      return;
    var fgMC = _root.debugPanel.fgMC;
    var lag = fgMC.lag;
    var fps = fgMC.fps;
    var clock: TextField = fgMC.createTextField("clock", fgMC.getNextHighestDepth(), lag._x + lag._width, fps._y, 300, fps._height);
    clock.antiAliasType = "advanced";
    var tf: TextFormat = fps.getNewTextFormat();
    tf.align = "left";
    clock.setNewTextFormat(tf);
    clock.filters = [new flash.filters.DropShadowFilter(0, 0, 0, 100, 3, 3, 2, 3)];
    setInterval(function() { clock.text = Utils.FormatDate(format, new Date()) }, 1000);
  }

  function showPostmortemTips(movingUpTime, showTime, movingDownTime)
  {
    if (Config.s_config.battle.showPostmortemTips)
      _root.showPostmortemTips(movingUpTime, showTime, movingDownTime);
  }

  function setArenaData(mapText, battleType, battleName, team1name, team2name, winText)
  {
    //Logger.add("setArenaData(" + mapText + ", " + battleType + ", " + battleName + ", " + team1name + ", " + team2name + ", " + winText + ")");
    _root.setArenaData(mapText, battleType, battleName, team1name, team2name, winText);
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
