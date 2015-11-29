/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.greensock.*;
import com.greensock.plugins.*;
import com.xvm.*;
import com.xvm.DataTypes.*;
import com.xvm.events.*;
import flash.external.*;
import gfx.io.*;
import net.wargaming.managers.*;
import wot.battle.*;

class wot.battle.BattleMain
{
    static var instance: BattleMain;
    var sixthSenseIndicator:SixthSenseIndicator;
    var clock:Clock;
    var zoomIndicator:ZoomIndicator;

    static function main()
    {
        Utils.TraceXvmModule("Battle");

        // ScaleForm optimization
        _global.gfxExtensions = true;
        _global.noInvisibleAdvance = true;

        // initialize TweenLite
        OverwriteManager.init(OverwriteManager.AUTO);
        TweenPlugin.activate([TintPlugin]);

        ExternalInterface.addCallback(Cmd.RESPOND_CONFIG, Config.instance, Config.instance.GetConfigCallback);
        ExternalInterface.addCallback(Cmd.RESPOND_BATTLE_STATE, instance, BattleMain.onBattleStateChanged);
        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, BattleMainConfigLoaded);
        GlobalEventDispatcher.addEventListener(Defines.E_CONFIG_LOADED, StatLoader.LoadData);

        instance = new BattleMain();
        GameDelegate.addCallBack("Stage.Update", instance, "onUpdateStage");
        GameDelegate.addCallBack("battle.showPostmortemTips", instance, "showPostmortemTips");

        ExternalInterface.addCallback(Cmd.RESPOND_KEY_EVENT, instance, instance.onKeyEvent);
        ExternalInterface.addCallback(Cmd.RESPOND_SNIPER_CAMERA, instance, instance.onSniperCamera);

        // TODO: dirty hack
        _root.consumablesPanel.addOptionalDeviceSlot_xvm = _root.consumablesPanel.addOptionalDeviceSlot;
        _root.consumablesPanel.addOptionalDeviceSlot = instance.addOptionalDeviceSlot;
        _root.consumablesPanel.setCoolDownTime_xvm = _root.consumablesPanel.setCoolDownTime;
        _root.consumablesPanel.setCoolDownTime = instance.setCoolDownTime;
        _root.damagePanel.as_updateSpeed_xvm = _root.damagePanel.as_updateSpeed;
        _root.damagePanel.as_updateSpeed = instance.damagePanel_updateSpeed;
        _root.damagePanel.as_updateDeviceState_xvm = _root.damagePanel.as_updateDeviceState;
        _root.damagePanel.as_updateDeviceState = instance.damagePanel_updateDeviceState;
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

        // Clock
        var clockFormat:String = Config.config.battle.clockFormat;
        if (clockFormat && clockFormat != "")
            instance.clock = new Clock();

        // Zoom Indicator
        if (Macros.FormatGlobalBooleanValue(Config.config.battle.camera.sniper.zoomIndicator.enabled))
            instance.zoomIndicator = new ZoomIndicator();

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

    function onUpdateStage(width, height, scale)
    {
        _root.onUpdateStage(width, height, scale);
        Elements.width = width;
        Elements.height = height;
        Elements.scale = scale;
        Elements.SetupElements();

        fixMinimapSize();

        BattleState.setScreenSize(width, height, scale);
        //Logger.add("update stage: " + width + "," + height + "," + scale);
        GlobalEventDispatcher.dispatchEvent( { type: Defines.E_UPDATE_STAGE, width: width, height: height, scale: scale });
    }

    function addOptionalDeviceSlot(idx, timeRemaining, deviceIconPath, tooltipText)
    {
        //Logger.add("addOptionalDeviceSlot: " + deviceIconPath);
        _root.consumablesPanel.addOptionalDeviceSlot_xvm.apply(_root.consumablesPanel, arguments);
        if (deviceIconPath.indexOf("/stereoscope.") > 0)
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_STEREOSCOPE_TOGGLED, value: timeRemaining != 0 } );
    }

    function setCoolDownTime(idx, timeRemaining)
    {
        //Logger.add("setCoolDownTime: " + idx);
        _root.consumablesPanel.setCoolDownTime_xvm.apply(_root.consumablesPanel, arguments);
        var renderer = _root.consumablesPanel.getRendererBySlotIdx(idx);
        if (renderer.iconPath.indexOf("/stereoscope.") > 0)
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_STEREOSCOPE_TOGGLED, value: timeRemaining != 0 } );
    }

    private var isMoving:Boolean = true;
    function damagePanel_updateSpeed(speed)
    {
        //Logger.add("updateSpeed: " + speed);
    	_root.damagePanel.as_updateSpeed_xvm.apply(_root.damagePanel, arguments);

        var sp:Number = isMoving ? 1 : 0;
        if ((speed == 0 && !isMoving) || (speed != 0 && isMoving))
            return;
        isMoving = speed != 0;
        GlobalEventDispatcher.dispatchEvent( { type: Defines.E_MOVING_STATE_CHANGED, value: isMoving } );
    }

    function damagePanel_updateDeviceState(moduleName:String, state:String)
    {
        //Logger.add("updateDeviceState: " + moduleName + ", " + state);
    	_root.damagePanel.as_updateDeviceState_xvm.apply(_root.damagePanel, arguments);

        if (state == "destroyed")
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_MODULE_DESTROYED, value: moduleName } );
        else if (state == "repaired" || state == "normal")
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_MODULE_REPAIRED, value: moduleName } );
    }

    // PRIVATE

    private static function onBattleStateChanged(targets:Number, playerName:String, clanAbbrev:String, playerId:Number, vehId:Number,
        team:Number, squad:Number, dead:Boolean, curHealth:Number, maxHealth:Number, marksOnGun:Number, spotted:String):Void
    {
        try
        {
            //Logger.addObject(arguments);
            var data:Object = { };
            if (playerName != null)
                data["playerName"] = playerName;
            if (clanAbbrev != null)
                data["clanAbbrev"] = clanAbbrev;
            if (!isNaN(playerId))
                data["playerId"] = playerId;
            if (!isNaN(vehId))
                data["vehId"] = vehId;
            if (!isNaN(team))
                data["team"] = team;
            if (!isNaN(squad))
                data["squad"] = squad;
            data["dead"] = dead;
            if (Config.config.battle.allowHpInPanelsAndMinimap && !isNaN(curHealth))
            {
                data["curHealth"] = curHealth;
            }
            if (Config.config.battle.allowHpInPanelsAndMinimap && !isNaN(maxHealth))
                data["maxHealth"] = maxHealth;
            if ((Config.config.battle.allowHpInPanelsAndMinimap || Config.config.battle.allowMarksOnGunInPanelsAndMinimap) && !isNaN(marksOnGun))
                data["marksOnGun"] = marksOnGun;
            if (Config.config.battle.allowSpottedStatus && spotted != null)
                data["spotted"] = spotted;

            //Logger.addObject(data);
            var updated:Boolean = BattleState.update(playerId, data);
            if (updated)
            {
                //Logger.add("updated: " + playerName);
                GlobalEventDispatcher.dispatchEvent(new EBattleStateChanged(playerId));
                if (dead && Config.eventType != "normal")
                {
                    GlobalEventDispatcher.dispatchEvent( { type: Defines.E_PLAYER_DEAD, value: playerId } );
                }
            }
        }
        catch (ex:Error)
        {
            Logger.add("onBattleStateChanged: [" + ex.name + "] " + ex.message);
        }
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

    private function onKeyEvent(key:Number, isDown:Boolean):Void
    {
        //Logger.add("onKeyEvent: " + key + " " + isDown);
        var cfg = Config.config.hotkeys;
        if (cfg.minimapZoom.enabled && cfg.minimapZoom.keyCode == key)
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_MM_ZOOM, isDown: isDown } );
        if (cfg.minimapAltMode.enabled && cfg.minimapAltMode.keyCode == key)
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_MM_ALT_MODE, isDown: isDown } );
        if (cfg.playersPanelAltMode.enabled && cfg.playersPanelAltMode.keyCode == key)
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_PP_ALT_MODE, isDown: isDown } );
    }

    private function onSniperCamera(enable:Boolean, zoom:Number):Void
    {
        if (zoomIndicator)
            zoomIndicator.update(enable, zoom);
    }
}
