/**
 * @author sirmax2
 */
import com.greensock.OverwriteManager;
import com.greensock.plugins.TintPlugin;
import com.greensock.plugins.TweenPlugin;
import com.xvm.Config;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Logger;
import com.xvm.StatLoader;
import com.xvm.Strings;
import com.xvm.Utils;
import wot.battle.BattleInputHandler;
import wot.battle.Elements;
import wot.battle.ExpertPanel;
import wot.battle.FragCorrelation;
import wot.battle.SixthSenseIndicator;

class wot.battle.BattleMain
{
    static var instance: BattleMain;
    var sixthSenseIndicator:SixthSenseIndicator;

    private static var soundManager = new net.wargaming.managers.SoundManager();

    static function main()
    {
        Utils.TraceXvmModule("Battle");

        GlobalEventDispatcher.addEventListener(Config.E_CONFIG_LOADED, BattleMainConfigLoaded);
        GlobalEventDispatcher.addEventListener(Config.E_CONFIG_LOADED, StatLoader.instance, StatLoader.instance.LoadLastStat);
        Config.LoadConfig();

        // initialize TweenLite
        OverwriteManager.init(OverwriteManager.AUTO);
        TweenPlugin.activate([TintPlugin]);

        instance = new BattleMain();
        gfx.io.GameDelegate.addCallBack("battle.showPostmortemTips", instance, "showPostmortemTips");
        gfx.io.GameDelegate.addCallBack("Stage.Update", instance, "onUpdateStage");

        BattleInputHandler.upgrade();
    }

    private static function BattleMainConfigLoaded()
    {
        //Logger.add("BattleMainConfigLoaded()");

        GlobalEventDispatcher.removeEventListener(Config.E_CONFIG_LOADED, BattleMainConfigLoaded);

        // Initialize Sixth Sense Indicator
        instance.sixthSenseIndicator = new SixthSenseIndicator();

        // TODO: remove (replace by setup elements)
        // Panels Mode Switcher
        if (Config.s_config.battle.removePanelsModeSwitcher)
            _root.switcher_mc._visible = false;

        // Show Clocks
        ShowClock(Config.s_config.battle.clockFormat);

        // Setup Visual Elements
        Elements.SetupElements();

        FragCorrelation.modify();
        
        ExpertPanel.modify();
    }

    private static function ShowClock(format)
    {
        if (!format || format == "")
            return;
        var debugPanel = _root.debugPanel;
        var lag = debugPanel.lag;
        var fps = debugPanel.fps;
        var clock: TextField = debugPanel.createTextField("clock", debugPanel.getNextHighestDepth(),
            lag._x + lag._width, fps._y, 300, fps._height);
        clock.antiAliasType = "advanced";
        clock.html = true;
        var tf: TextFormat = fps.getNewTextFormat();
        clock.styleSheet = Utils.createStyleSheet(Utils.createCSS("xvm_clock",
            tf.color, tf.font, tf.size, "left", tf.bold, tf.italic));
        clock.filters = [new flash.filters.DropShadowFilter(1, 90, 0, 100, 5, 5, 1.5, 3)];

        _global.setInterval(function() {
            clock.htmlText = Utils.fixImgTag("<span class='xvm_clock'>" + Strings.FormatDate(format, new Date()) + "</span>");
        }, 1000);
    }

    function showPostmortemTips(movingUpTime, showTime, movingDownTime)
    {
        GlobalEventDispatcher.dispatchEvent( { type: "self_dead" } );

        //Logger.add("Battle::showPostmortemTips");
        if (Config.s_config.battle.showPostmortemTips)
            _root.showPostmortemTips(movingUpTime, showTime, movingDownTime);
    }

    function onUpdateStage(width, height)
    {
        _root.onUpdateStage(width, height);
        Elements.width = width;
        Elements.height = height;
        Elements.SetupElements();

        fixMinimapSize();
    }

    private function fixMinimapSize():Void
    {
        /**
         * Fix minimap size glitch when program window is resized.
         * Fix is detached from minimap to allow other minimap mods
         * to be compatible with XVMs hacked battle.swf
         */
        var isMinimalSize:Boolean = _root.minimap.m_sizeIndex == 0;
        _root.minimap.sizeDown();
        if (!isMinimalSize)
        {
            _root.minimap.sizeUp();
        }
    }

}
