/**
 * ...
 * @author sirmax2
 */
import wot.utils.Chance;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.StatData;
import wot.utils.StatLoader;
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
    GlobalEventDispatcher.addEventListener("config_loaded", StatLoader.LoadLastStat);
    Config.LoadConfig("BattleMain.as");

    instance = new BattleMain();
    gfx.io.GameDelegate.addCallBack("battle.showPostmortemTips", instance, "showPostmortemTips");
    gfx.io.GameDelegate.addCallBack("Stage.Update", instance, "onUpdateStage");
    gfx.io.GameDelegate.addCallBack("battle.arenaData", instance, "setArenaData");
    gfx.io.GameDelegate.addCallBack("battle.showStatus", instance, "showFinalStatus");
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
    //Logger.add("Battle::showPostmortemTips");
    if (Config.s_config.battle.showPostmortemTips)
      _root.showPostmortemTips(movingUpTime, showTime, movingDownTime);
  }

  function setArenaData(mapText, battleType, battleName, team1name, team2name, winText)
  {
    //Logger.add("Battle::setArenaData(" + mapText + ", " + battleType + ", " + battleName + ", " + team1name + ", " + team2name + ", " + winText + ")");
    _root.setArenaData(mapText, battleType, battleName, team1name, team2name, winText);
  }

  function onUpdateStage(width, height)
  {
    //Logger.add("Battle::onUpdateStage()");
    _root.onUpdateStage(width, height);
    //_root.minimap.foreground._alpha = 30;
    //_root.minimap.foregroundHR._alpha = 30;
    //wot.utils.Logger.addObject(_root);
  }

  var finalStatusShown = false;
  function showFinalStatus(statusText)
  {
    if (finalStatusShown)
      return;

    //Logger.add("Battle::showFinalStatus(): " + statusText);

    _root.showFinalStatus(statusText);

    if (!_root.finalDialog || !_root.finalDialog.form)
      return;

    finalStatusShown = true;

    if (!StatData.s_loaded || !Config.s_config.rating.showPlayersStatistics || !Config.s_config.statisticForm.showChances)
      return;

    Logger.addObject(_root.statsData, "_root.statsData", 2);
      
    for (var i = 0; i < _root.statsData.team1.length; ++i)
    {
      var data = _root.statsData.team1[i];
      var pname = data.label.toUpperCase();
      if (!StatData.s_data[pname] || !StatData.s_data[pname].playerId)
      {
        StatLoader.AddPlayerData(data.uid, data.label, data.vehicle, data.icon,
            _root.statsData.playerTeam == "team1" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);
      }
    }

    for (var i = 0; i < _root.statsData.team2.length; ++i)
    {
      var data = _root.statsData.team2[i];
      var pname = data.label.toUpperCase();
      if (!StatData.s_data[pname] || !StatData.s_data[pname].playerId)
      {
        StatLoader.AddPlayerData(data.uid, data.label, data.vehicle, data.icon,
            _root.statsData.playerTeam == "team1" ? Defines.TEAM_ENEMY : Defines.TEAM_ALLY);
      }
    }

    //Logger.addObject(_root.finalDialog.form.form, "form", 2);

    var t: TextField = null;
    for (var i in _root.finalDialog.form.form)
    {
      if (!Utils.startsWith("instance", i))
        continue;
      var v = _root.finalDialog.form.form[i];
      if (v instanceof TextField)
      {
        t = v;
        break;
      }
    }

    if (t)
    {
      t.html = true;
      t.text = "";
      Chance.ShowChance(t, Config.s_config.statisticForm.showChancesExp);
    }
  }
}
