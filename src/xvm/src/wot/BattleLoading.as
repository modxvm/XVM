/**
 * ...
 * @author sirmax2
 */
import flash.filters.DropShadowFilter;
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.Stat;
import wot.utils.Utils;

class wot.BattleLoading extends net.wargaming.BattleLoading
{
  public static var infoField: TextField = null;

  public function BattleLoading()
  {
    super();

    _global.xvm_battleloading = this;

    Config.LoadConfig();

    if (!infoField)
    {
      infoField = createTextField("info", getNextHighestDepth(), _width / 2, 0, 400, 100);
      infoField.wordWrap = true;
      infoField.antiAliasType = "advanced";
      infoField.setNewTextFormat(new TextFormat("$FieldFont", 12, 0x000000, true, false, false, null, null, "left"));
      infoField.filters = [ new DropShadowFilter(0, 0, 0, 100, 3, 3, 1, 3) ];
      infoField.textColor = 0xFFFFFF;
      infoField._alpha = 100;
      infoField._visible = true;
    }

    setInfoFieldData({ });

    BattleLoadingInit();
  }

  function BattleLoadingInit(obj: Object)
  {
    if (!obj)
      obj = this;

    if (!Config.s_loaded)
    {
      // Wait for config loaded
      var timer: TimelineLite = new TimelineLite({onComplete:BattleLoadingInit, onCompleteParams:[obj]});
      timer.insert(new TweenLite(obj, 0.1));
      return;
    }

    if (Config.s_config.battleLoading.showClock)
      obj.ShowClock();

    // Force stats loading after 1 sec (for 12x12 battles, FogOfWar, ...)
    var timer: TimelineLite = new TimelineLite({onComplete:obj.StartLoadData, onCompleteParams:[]});
    timer.insert(new TweenLite(null, 1));
  }

  public function ShowClock()
  {
    var clock = createTextField("clock", getNextHighestDepth(), 280, 25, 100, 40);
    clock.antiAliasType = "advanced";
    clock.setNewTextFormat(new TextFormat("$TitleFont", 32, 0xFFFFFF, false, false, false, null, null, "center"));
    clock.filters = [ new DropShadowFilter(0, 0, 0, 100, 5, 5, 5, 3) ];
    clock._visible = true;

    clock.text = Utils.padLeft(String((new Date()).getHours()), 2, '0') + ":" + Utils.padLeft(String((new Date()).getMinutes()), 2, '0');
  }

  public function StartLoadData()
  {
    if (Config.s_config.rating.showPlayersStatistics)
      Stat.StartLoadData();
  }

  public function setInfoFieldData(data)
  {
    if (!infoField)
      return;

    var txt: String = "XVM v" + Defines.XVM_VERSION + " ";

    if (data.ver && Utils.compareVersions(String(data.ver), Defines.XVM_VERSION) == 1)
    {
      txt = "XVM: New version available: v" + String(data.ver) + " (current is v" + Defines.XVM_VERSION + ")\n";
      if (data.message)
        txt += data.message + "\n";
      infoField.textColor = 0xAAFFAA;
    }

    if (data.error)
    {
      txt += data.error + "\n";
      infoField.textColor = 0xFF8080;
    }

    if (data.warning)
    {
      txt += data.warning + "\n";
      infoField.textColor = 0xFFFFCC;
    }

    if (Stat.s_loaded && Config.s_config.battleLoading.showChances)
    {
      var chances = Stat.GetChances();
      txt += "\nChances:";
      txt += "\n  m = " + chances.m + " (" + chances.m1 + " / " + chances.m2 + ")";
      txt += "\n  k = " + chances.k + " (" + chances.k1 + " / " + chances.k2 + ")";
    }

    infoField.text = txt;
  }
}
