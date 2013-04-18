/**
 * ...
 * @author sirmax2
 */
import wot.battle.FragCorrelation;
import com.greensock.OverwriteManager;
import com.greensock.plugins.TweenPlugin;
import com.greensock.plugins.TintPlugin;
import wot.battle.BattleInputHandler;
import wot.utils.Config;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.StatLoader;
import wot.utils.Utils;
import wot.battle.SixthSenseIndicator;

class wot.battle.BattleMain
{
    static var instance: BattleMain;
    var sixthSenseIndicator:SixthSenseIndicator;

    private static var dummy = Logger.dummy;

    private static var soundManager = new net.wargaming.managers.SoundManager();
    private static var width, height;

    static function main()
    {
        Utils.TraceXvmModule("Battle:main");

        GlobalEventDispatcher.addEventListener("config_loaded", BattleMainConfigLoaded);
        GlobalEventDispatcher.addEventListener("config_loaded", StatLoader.LoadLastStat);
        Config.LoadConfig("BattleMain.as");

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

        GlobalEventDispatcher.removeEventListener("config_loaded", BattleMainConfigLoaded);

        // Initialize Sixth Sense Indicator
        instance.sixthSenseIndicator = new SixthSenseIndicator();

        // TODO: remove (replace by setup elements)
        // Panels Mode Switcher
        if (Config.s_config.battle.removePanelsModeSwitcher)
            _root.switcher_mc._visible = false;

        // Show Clocks
        ShowClock(Config.s_config.battle.clockFormat);

        // Setup Visual Elements
        SetupElements();
        
        FragCorrelation.modify();
    }

    private static function SetupElements()
    {
        if (!Config.s_loaded || !width || !height)
            return;
        var cfg = Config.s_config.battle.elements;
        //Logger.addObject(_root);
        for (var i in cfg)
        {
            if (_root[i] != null)
                SetupElement(_root[i], Config.s_config.battle.elements[i]);
            else
                Logger.add("Warning: Visual Element not found: " + i);
        }
    }

    private static var colors:Array = [ 0xFFFFFF, 0xFF0000, 0xFFFF00, 0x00FF00, 0x00FFFF, 0xFF00FF ];
    private static function SetupElement(mc:MovieClip, cfg)
    {
        //Logger.addObject(cfg, name + " " + width + "x" + height, 2);

        var ha = getValue(cfg.ha, 0);
        var va = getValue(cfg.va, 0);
        var x = getValue(cfg.x, mc._x, width);
        var y = getValue(cfg.y, mc._y, height);
        var w = getValue(cfg.w, mc._width, width);
        var h = getValue(cfg.h, mc._height, height);
        var a = getValue(cfg.a, mc._alpha, 100);

        if (ha == 2)
            x = width - x - w;
        if (va == 2)
            y = width - y - h;
        
        mc._x = x;
        mc._y = y;
        mc.height = h;
        mc.width = w;
        mc._alpha = a;

        if (cfg.debug == true)
        {
            with (mc)
            {
                var c = colors[colors.length * Math.random()];
                beginFill(0, 0);
                lineStyle(1, c, 100);
                moveTo(0, 0);
                lineTo(w, 0);
                lineTo(w, h);
                lineTo(0, h);
                lineTo(0, 0);
                endFill();
                var t: TextField = createTextField("t", getNextHighestDepth(), w / 2 - 50,  h / 2 - 10, 100, 40);
                t.setNewTextFormat(new TextFormat("Small Fonts", 8, c, false, false, false, null, null, "center"));
                t.filters = [new flash.filters.DropShadowFilter(0, 0, 0, 100, 4, 4, 2, 3)];
                t.multiline = true;
                t.text = mc._name + "\n" + mc._x + "x" + mc._y + "+" + mc._width + "," + mc._height;
                Logger.add("Element: " + mc._name + ":" + mc._x + "x" + mc._y + "+" + mc._width + "," + mc._height + " a=" + a);
            }
        }
    }

    private static function getValue(v:String, defaultValue:Number, range:Number):Number
    {
        if (v == null || v == "")
            return defaultValue;
        if (Utils.endsWith("%", v))
        {
            v = v.substring(0, v.length - 1);
            return parseFloat(v) * range / 100;
        }
        return parseInt(v);
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
            clock.htmlText = "<span class='xvm_clock'>" + Utils.FormatDate(format, new Date()) + "</span>";
        }, 1000);
    }

    function showPostmortemTips(movingUpTime, showTime, movingDownTime)
    {
        //Logger.add("Battle::showPostmortemTips");
        if (Config.s_config.battle.showPostmortemTips)
            _root.showPostmortemTips(movingUpTime, showTime, movingDownTime);
    }

    function onUpdateStage(width, height)
    {
        _root.onUpdateStage(width, height);
        BattleMain.width = width;
        BattleMain.height = height;
        SetupElements();
        
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
