/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy(at)gmail.com>
 */
import com.greensock.*;
import com.greensock.plugins.*;
import com.xvm.*;
import com.xvm.DataTypes.*;
import flash.external.*;
import wot.battle.*;

class wot.battle.BattleMain
{
    static var instance: BattleMain;
    var sixthSenseIndicator:SixthSenseIndicator;

    private static var soundManager = new net.wargaming.managers.SoundManager();

    static function main()
    {
        Utils.TraceXvmModule("Battle");

        // ScaleForm optimization
        _global.gfxExtensions = true;
        _global.noInvisibleAdvance = true;

        ExternalInterface.addCallback(Cmd.RESPOND_CONFIG, Config.instance, Config.instance.GetConfigCallback);
        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, BattleMainConfigLoaded);
        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, StatLoader.LoadData);

        // initialize TweenLite
        OverwriteManager.init(OverwriteManager.AUTO);
        TweenPlugin.activate([TintPlugin]);

        instance = new BattleMain();
        gfx.io.GameDelegate.addCallBack("battle.showPostmortemTips", instance, "showPostmortemTips");
        gfx.io.GameDelegate.addCallBack("Stage.Update", instance, "onUpdateStage");
        gfx.io.GameDelegate.addCallBack("battle.consumablesPanel.setCoolDownTime", instance, "setCoolDownTime");

        gfx.io.GameDelegate.addCallBack("battle.damagePanel.setMaxHealth", instance, "setMaxHealth");
        gfx.io.GameDelegate.addCallBack("battle.damagePanel.updateHealth", instance, "updateHealth");
        gfx.io.GameDelegate.addCallBack("battle.damagePanel.updateState", instance, "updateState");
        gfx.io.GameDelegate.addCallBack("battle.damagePanel.updateSpeed", instance, "updateSpeed");

        BattleInputHandler.upgrade();

        ExternalInterface.addCallback(Cmd.RESPOND_BATTLESTATE, instance, instance.onBattleStateChanged);
        ExternalInterface.addCallback("xvm.debugtext", instance, instance.onDebugText);
    }

    private static function BattleMainConfigLoaded()
    {
        //Logger.add("BattleMainConfigLoaded()");

        // Initialize Sixth Sense Indicator
        instance.sixthSenseIndicator = new SixthSenseIndicator();

        // TODO: remove (replace by setup elements)
        // Panels Mode Switcher
        if (Config.config.playersPanel.removePanelsModeSwitcher)
            _root.switcher_mc._visible = false;

        // Show Clocks
        ShowClock(Config.config.battle.clockFormat);

        // Setup Visual Elements
        Elements.SetupElements();

        FragCorrelation.modify();

        ExpertPanel.modify();
    }

    function showPostmortemTips(movingUpTime, showTime, movingDownTime)
    {
        GlobalEventDispatcher.dispatchEvent( { type: Defines.E_SELF_DEAD } );

        //Logger.add("Battle::showPostmortemTips");
        if (Config.config.battle.showPostmortemTips)
            _root.showPostmortemTips(movingUpTime, showTime, movingDownTime);
    }

    function onUpdateStage(width, height)
    {
        _root.onUpdateStage(width, height);
        Elements.width = width;
        Elements.height = height;
        Elements.SetupElements();

        fixMinimapSize();

        BattleState.setScreenSize(width, height);
        //Logger.add("update stage: " + width + "," + height);
        GlobalEventDispatcher.dispatchEvent( { type: Defines.E_UPDATE_STAGE, width: width, height: height });
    }

    function setCoolDownTime(idx, timeRemaining)
    {
        _root.consumablesPanel.setCoolDownTime(idx, timeRemaining);
        var renderer = _root.consumablesPanel.getRendererBySlotIdx(idx);
        if (renderer.iconPath.indexOf("/stereoscope.") > 0)
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_BINOCULAR_TOGGLED, value: timeRemaining != 0 } );
    }

    private var maxHealth:Number = NaN;
    function setMaxHealth(health)
    {
    	_root.damagePanel.setMaxHealth.apply(_root.damagePanel, arguments);
        maxHealth = health;
    }

    function updateHealth(health)
    {
    	_root.damagePanel.updateHealth.apply(_root.damagePanel, arguments);
        GlobalEventDispatcher.dispatchEvent( { type: Defines.E_UPDATE_SELF_HEALTH, value: health, maxHealth: maxHealth } );
    }

    private var isMoving:Boolean = true;
    function updateSpeed(speed)
    {
    	_root.damagePanel.updateSpeed.apply(_root.damagePanel, arguments);

        var sp:Number = isMoving ? 1 : 0;
        if ((speed == 0 && !isMoving) || (speed != 0 && isMoving))
            return;
        isMoving = speed != 0;
        GlobalEventDispatcher.dispatchEvent( { type: Defines.E_MOVING_STATE_CHANGED, value: isMoving } );
    }

    function updateState(moduleName:String, state:String)
    {
        //Logger.add("updateState: " + moduleName + ", " + state);
    	_root.damagePanel.updateState.apply(_root.damagePanel, arguments);

        if (state == "destroyed")
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_MODULE_DESTROYED, value: moduleName } );
        else if (state == "repaired" || state == "normal")
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_MODULE_REPAIRED, value: moduleName } );
    }

    // PRIVATE

    private static function ShowClock(format)
    {
        if (!format || format == "")
            return;
        var debugPanel = _root.debugPanel;
        var lag = debugPanel.lag;
        var fps = debugPanel.fps;
        var clock: TextField = debugPanel.createTextField("clock", debugPanel.getNextHighestDepth(),
            lag._x + lag._width, fps._y, 300, fps._height);
        clock.selectable = false;
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

    private function onBattleStateChanged(str:String):Void
    {
        var obj = JSONx.parse(str);
        var data:BattleStateData = obj; // as2 type casting is strange
        //Logger.addObject(data);
        BattleState.setUserData(data.playerName, data);
        GlobalEventDispatcher.dispatchEvent( { type: Defines.E_BATTLE_STATE_CHANGED, playerName: data.playerName } );
    }

    private var debugTextField:TextField = null;
    function onDebugText(text)
    {
        if (debugTextField == null)
        {
            debugTextField = _root.createTextField("debugTextField", _root.getNextHighestDepth(), 0, 0, 1024, 768);
            debugTextField.html = true;
            debugTextField.selectable = false;
            debugTextField.multiline = true;
            debugTextField.antiAliasType = "advanced";
            debugTextField.styleSheet = Utils.createStyleSheet(Utils.createCSS("debugText",
                0xDDDDDD, "$FieldFont", 12, "left", false, false));
            var sh:flash.filters.DropShadowFilter = new flash.filters.DropShadowFilter(0, 0, 0, 100, 5, 5, 5);
            debugTextField.filters = [ sh ];
        }
        debugTextField.htmlText = "<span class='debugText'>" + text + "</span>";
    }
}
