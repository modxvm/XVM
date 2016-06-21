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
    private static var HOLDER_DEPTH:Number = -16368; // behind the minimap

    private static var _instance: BattleMain;
    private var _sixthSenseIndicator:SixthSenseIndicator;
    private var _clock:Clock;
    private var _holder:MovieClip;
    private var _zoomIndicator:ZoomIndicator;

    static function main()
    {
        Utils.TraceXvmModule("Battle");

        // ScaleForm optimization
        _global.gfxExtensions = true;
        _global.noInvisibleAdvance = true;

        // initialize TweenLite
        OverwriteManager.init(OverwriteManager.AUTO);
        TweenPlugin.activate([TintPlugin]);

        _instance = new BattleMain();
    }

    public function BattleMain()
    {
        GameDelegate.addCallBack("Stage.Update", this, "onUpdateStage");
        GameDelegate.addCallBack("battle.showPostmortemTips", this, "showPostmortemTips");

        DAAPI.initialize();

        _root.as_xvm_onKeyEvent = this.as_xvm_onKeyEvent;
        _root.as_xvm_onSniperCamera = this.as_xvm_onSniperCamera;
        _root.as_xvm_onAimOffsetUpdate = this.as_xvm_onAimOffsetUpdate;
        _root.as_xvm_onBattleStateChanged = this.as_xvm_onBattleStateChanged;
        _root.as_xvm_onPlayersHpChanged = this.as_xvm_onPlayersHpChanged;
        _root.as_xvm_onXmqpEvent = this.as_xvm_onXmqpEvent;

        GlobalEventDispatcher.addEventListener(Events.E_CONFIG_LOADED, this, BattleMainConfigLoaded);
        GlobalEventDispatcher.addEventListener(Events.E_CONFIG_LOADED, StatLoader.LoadData);

        _root.consumablesPanel.addOptionalDeviceSlot_xvm = _root.consumablesPanel.addOptionalDeviceSlot;
        _root.consumablesPanel.addOptionalDeviceSlot = this.addOptionalDeviceSlot;
        _root.consumablesPanel.setCoolDownTime_xvm = _root.consumablesPanel.setCoolDownTime;
        _root.consumablesPanel.setCoolDownTime = this.setCoolDownTime;
        _root.damagePanel.as_updateSpeed_xvm = _root.damagePanel.as_updateSpeed;
        _root.damagePanel.as_updateSpeed = this.damagePanel_updateSpeed;
        _root.damagePanel.as_updateDeviceState_xvm = _root.damagePanel.as_updateDeviceState;
        _root.damagePanel.as_updateDeviceState = this.damagePanel_updateDeviceState;
    }

    private function BattleMainConfigLoaded()
    {
        //Logger.add("BattleMainConfigLoaded()");

        // Initialize Sixth Sense Indicator
        this._sixthSenseIndicator = new SixthSenseIndicator();

// AS3:DONE         // TODO: remove (replace by setup elements)
// AS3:DONE         // Panels Mode Switcher
// AS3:DONE         if (Config.config.playersPanel.removePanelsModeSwitcher)
// AS3:DONE             _root.switcher_mc._visible = false;

        // Clock
        var clockFormat:String = Config.config.battle.clockFormat;
        if (clockFormat && clockFormat != "")
            this._clock = new Clock();

        // Holder
        this._holder = _root.createEmptyMovieClip("xvm_holder", HOLDER_DEPTH);

        // Zoom Indicator
        if (Macros.FormatGlobalBooleanValue(Config.config.battle.camera.sniper.zoomIndicator.enabled))
            this._zoomIndicator = new ZoomIndicator(_holder);

        // Setup Visual Elements
        Elements.SetupElements();

        FragCorrelation.modify();

        ExpertPanel.modify();

        GlobalEventDispatcher.addEventListener(Events.E_STAT_LOADED, this, battleLabelsInit);

    }

    private function battleLabelsInit(){
        // Battle labels on battle interface window and delayed macros registration
        Macros.RegisterGlobalMacrosDataDelayed("ON_STAT_LOADED");
        BattleLabels.init();
    }

    // Python calls (context: this => _root)

    public function as_xvm_onKeyEvent(key:Number, isDown:Boolean):Void
    {
        //Logger.add("onKeyEvent: " + key + " " + isDown);
        var cfg = Config.config.hotkeys;
        if (cfg.minimapZoom.enabled && cfg.minimapZoom.keyCode == key)
            GlobalEventDispatcher.dispatchEvent( { type: Events.E_MM_ZOOM, isDown: isDown } );
        if (cfg.minimapAltMode.enabled && cfg.minimapAltMode.keyCode == key)
            GlobalEventDispatcher.dispatchEvent( { type: Events.E_MM_ALT_MODE, isDown: isDown } );
        if (cfg.playersPanelAltMode.enabled && cfg.playersPanelAltMode.keyCode == key)
            GlobalEventDispatcher.dispatchEvent( { type: Events.E_PP_ALT_MODE, isDown: isDown } );
        if ((BattleLabels.BoX.IsHotKeyedTextFieldsFlag) && (cfg.battleLabelsHotKeys))
            GlobalEventDispatcher.dispatchEvent( { type: Events.E_BATTLE_LABEL_KEY_MODE, key: key, isDown: isDown } );
    }

    public function as_xvm_onSniperCamera(enable:Boolean, zoom:Number):Void
    {
        if (BattleMain._instance._zoomIndicator)
            BattleMain._instance._zoomIndicator.update(enable, zoom);
    }

    public function as_xvm_onAimOffsetUpdate(offsetX:Number, offsetY:Number):Void
    {
        if (BattleMain._instance._zoomIndicator)
            BattleMain._instance._zoomIndicator.onOffsetUpdate(offsetX, offsetY);
    }

    public function as_xvm_onBattleStateChanged(targets:Number, playerName:String, clanAbbrev:String, playerId:Number, vehId:Number,
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
            if (spotted != null)
                data["spotted"] = spotted;

            //Logger.addObject(data);
            var updated:Boolean = BattleState.update(playerId, data);
            if (updated)
            {
                //Logger.add("updated: " + playerName);
                GlobalEventDispatcher.dispatchEvent(new EBattleStateChanged(playerId));
                if (dead)
                {
                    GlobalEventDispatcher.dispatchEvent( { type: Events.E_PLAYER_DEAD, value: playerId } );
                }
            }
        }
        catch (ex:Error)
        {
            Logger.add("onBattleStateChanged: [" + ex.name + "] " + ex.message);
        }
    }

    // ctx = _root
    public function as_xvm_onPlayersHpChanged()
    {
        GlobalEventDispatcher.dispatchEvent( { type: Events.E_PLAYERS_HP_CHANGED } );
        //Logger.add("HP update event dispatched");
    }

    // callbacks

    private function onUpdateStage(width, height, scale)
    {
        _root.onUpdateStage(width, height, scale);
        Elements.width = width;
        Elements.height = height;
        Elements.scale = scale;
        Elements.SetupElements();

        fixMinimapSize();

        //Logger.add("update stage: " + width + "," + height + "," + scale);
        GlobalEventDispatcher.dispatchEvent( { type: Events.E_UPDATE_STAGE, width: width, height: height, scale: scale });
    }

    private function showPostmortemTips(movingUpTime, showTime, movingDownTime)
    {
        GlobalEventDispatcher.dispatchEvent( { type: Events.E_SELF_DEAD } );

        //Logger.add("Battle::showPostmortemTips");
        if (Config.config.battle.showPostmortemTips)
            _root.showPostmortemTips(movingUpTime, showTime, movingDownTime);
    }

    // overrides

    private function addOptionalDeviceSlot(idx, timeRemaining, deviceIconPath, tooltipText)
    {
        //Logger.add("addOptionalDeviceSlot: " + deviceIconPath);
        _root.consumablesPanel.addOptionalDeviceSlot_xvm.apply(_root.consumablesPanel, arguments);
        if (deviceIconPath.indexOf("/stereoscope.") > 0)
            GlobalEventDispatcher.dispatchEvent( { type: Events.E_STEREOSCOPE_TOGGLED, value: timeRemaining != 0 } );
    }

    private function setCoolDownTime(idx, timeRemaining)
    {
        //Logger.add("setCoolDownTime: " + idx);
        _root.consumablesPanel.setCoolDownTime_xvm.apply(_root.consumablesPanel, arguments);
        var renderer = _root.consumablesPanel.getRendererBySlotIdx(idx);
        if (renderer.iconPath.indexOf("/stereoscope.") > 0)
            GlobalEventDispatcher.dispatchEvent( { type: Events.E_STEREOSCOPE_TOGGLED, value: timeRemaining != 0 } );
    }

    private var isMoving:Boolean = true;
    private function damagePanel_updateSpeed(speed)
    {
        //Logger.add("updateSpeed: " + speed);
    	_root.damagePanel.as_updateSpeed_xvm.apply(_root.damagePanel, arguments);

        var sp:Number = isMoving ? 1 : 0;
        if ((speed == 0 && !isMoving) || (speed != 0 && isMoving))
            return;
        isMoving = speed != 0;
        GlobalEventDispatcher.dispatchEvent( { type: Events.E_MOVING_STATE_CHANGED, value: isMoving } );
    }

    private function damagePanel_updateDeviceState(moduleName:String, state:String)
    {
        //Logger.add("updateDeviceState: " + moduleName + ", " + state);
    	_root.damagePanel.as_updateDeviceState_xvm.apply(_root.damagePanel, arguments);

        if (state == "destroyed")
            GlobalEventDispatcher.dispatchEvent( { type: Events.E_MODULE_DESTROYED, value: moduleName } );
        else if (state == "repaired" || state == "normal")
            GlobalEventDispatcher.dispatchEvent( { type: Events.E_MODULE_REPAIRED, value: moduleName } );
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

    // xmqp events

    // ctx = _root
    public function as_xvm_onXmqpEvent(playerId:Number, event:String, data:Object)
    {
        //Logger.add(event + " " + playerId + " " + JSONx.stringify(data));
        switch (event)
        {
            case Events.XMQP_HOLA:
                _instance.onHolaEvent(playerId, data);
                break;
            case Events.XMQP_FIRE:
                _instance.onFireEvent(playerId, data);
                break;
            case Events.XMQP_VEHICLE_TIMER:
                _instance.onVehicleTimerEvent(playerId, data);
                break;
            case Events.XMQP_SPOTTED:
                _instance.onSpottedEvent(playerId);
                break;
            case Events.XMQP_MINIMAP_CLICK:
                GlobalEventDispatcher.dispatchEvent( { type: Events.XMQP_MINIMAP_CLICK, value: playerId, data: data } );
                break;
            case Events.XMQP_DEATH_ZONE_TIMER:
                // TODO
                break;
            default:
                Logger.add("WARNING: unknown xmqp event: " + event);
                break;
        }
    }

    // {{x-enabled}}
    // {{x-sense-on}}

    private function onHolaEvent(playerId:Number, data:Object)
    {
        var updated:Boolean = BattleState.update(playerId, {
            x_enabled: true,
            x_sense_on: Boolean(data.sixthSense)
        });
        if (updated)
        {
            GlobalEventDispatcher.dispatchEvent( { type: Events.XMQP_HOLA, value: playerId } );
        }
    }

    // {{x-fire}}

    private function onFireEvent(playerId:Number, data:Object)
    {
        var updated:Boolean = BattleState.update(playerId, { x_fire: data.enable } );
        if (updated)
        {
            GlobalEventDispatcher.dispatchEvent( { type: Events.XMQP_FIRE, value: playerId } );
        }
    }

    // {{x-overturned}}
    // {{x-drowning}}

    private function onVehicleTimerEvent(playerId:Number, data:Object)
    {
        var updated:Boolean = false;
        switch (data.code)
        {
            case Defines.VEHICLE_MISC_STATUS_VEHICLE_IS_OVERTURNED:
                updated = BattleState.update(playerId, { x_overturned: data.enable } );
                break;

            case Defines.VEHICLE_MISC_STATUS_VEHICLE_DROWN_WARNING:
                updated = BattleState.update(playerId, { x_drowning: data.enable } );
                break;

            case Defines.VEHICLE_MISC_STATUS_ALL:
                updated = BattleState.update(playerId, { x_overturned: data.enable } );
                updated = BattleState.update(playerId, { x_drowning: data.enable } ) || updated;
                break;

            default:
                Logger.add("WARNING: unknown vehicle timer code: " + data.code);
        }

        if (updated)
        {
            GlobalEventDispatcher.dispatchEvent( { type: Events.XMQP_VEHICLE_TIMER, value: playerId } );
        }
    }

    // {{x-spotted}}

    private var _sixSenseIndicatorTimeoutIds = {};

    private function onSpottedEvent(playerId:Number)
    {
        var updated:Boolean = BattleState.update(playerId, { x_spotted: true } );
        if (updated)
        {
            GlobalEventDispatcher.dispatchEvent( { type: Events.XMQP_SPOTTED, value: playerId } );
        }
        if (_sixSenseIndicatorTimeoutIds[playerId])
        {
            _global.clearTimeout(_sixSenseIndicatorTimeoutIds[playerId]);
        }
        var $this = this;
        _sixSenseIndicatorTimeoutIds[playerId] =
            _global.setTimeout(function() { $this.onSpottedEventDone(playerId); }, Config.config.xmqp.spottedTime * 1000);
    }

    private function onSpottedEventDone(playerId:Number)
    {
        delete _sixSenseIndicatorTimeoutIds[playerId];
        var updated:Boolean = BattleState.update(playerId, { x_spotted: false } );
        if (updated)
        {
            GlobalEventDispatcher.dispatchEvent( { type: Events.XMQP_SPOTTED, value: playerId } );
        }
    }
}
