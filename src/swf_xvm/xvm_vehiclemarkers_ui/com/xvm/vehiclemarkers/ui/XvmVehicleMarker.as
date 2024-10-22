/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui
{
    import com.xfw.*;
    import com.xfw.XfwAccess;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.vo.*;
    import com.xvm.vehiclemarkers.ui.components.*;
    import com.xvm.vo.*;
    import flash.events.*;
    import net.wg.data.constants.Values;
    import net.wg.gui.battle.battleRoyale.views.components.fullStats.nationsVehiclesCounter.BattleRoyaleNationsVehiclesCounter;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
    import net.wg.gui.battle.views.vehicleMarkers.events.*;
    import net.wg.gui.utils.*;

    public class XvmVehicleMarker extends VehicleMarker
    {
        public var isStickyAndOutOfScreen:Boolean = false;

        private static const INVALIDATE_DATA:uint = 1 << 29;

        private var vehicleID:Number = NaN;
        private var vehicleIconName:String = null;
        private var playerName:String = null;
        private var curHealth:Number = NaN;
        private var maxHealth:int = 0;

        private var actionMarkerComponent:ActionMarkerComponent = null;
        private var hoverMarkerComponent:HoverMarkerComponent = null;
        private var vehicleStatusMarkerComponent:VehicleStatusMarkerComponent = null;
        private var contourIconComponent:ContourIconComponent = null;
        private var damageIndicatorComponent:DamageIndicatorComponent = null;
        private var damageTextComponent:DamageTextComponent = null;
        private var vehicleDistComponent:VehicleDistComponent = null;
        private var healthBarComponent:HealthBarComponent = null;
        private var levelIconComponent:LevelIconComponent = null;
        private var textFieldsComponent:TextFieldsComponent = null;
        private var vehicleTypeIconComponent:VehicleTypeIconComponent = null;

        public function XvmVehicleMarker()
        {
            super();
            Xvm.addEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
            Xvm.addEventListener(Defines.XVM_EVENT_ATLAS_LOADED, onAtlasLoaded);
            createComponents();
        }

        override protected function configUI():void
        {
            super.configUI();
            var vmManager:VehicleMarkersManager = VehicleMarkersManager.getInstance();
            vmManager.addEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO, onShowExInfoHandler, false, 0, true);
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
            Xvm.removeEventListener(Defines.XVM_EVENT_ATLAS_LOADED, onAtlasLoaded);
            var vmManager:VehicleMarkersManager = VehicleMarkersManager.getInstance();
            vmManager.removeEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO, onShowExInfoHandler);
            deleteComponents();
            super.onDispose();
        }

        override public function setVehicleInfo(vClass:String, vIconSource:String, vType:String, vLevel:int,  pFullName:String, pName:String, pClan:String, pRegion:String, maxHealth:int, entityName:String, hunt:Boolean, squadIndex:int, locSecString:String, param13:String="", param14:int=0):void
        {
            super.setVehicleInfo.apply(this, arguments);
            vehicleIconName = vIconSource.substr(vIconSource.lastIndexOf("/") + 1).replace(".png", "");
            this.playerName = pName;
            this.maxHealth = maxHealth;
            vehicleID = BattleState.getVehicleIDByPlayerName(playerName);
            if (!isNaN(vehicleID))
            {
                init(vehicleID);
            }
        }

        CLIENT::LESTA {
            override public function settingsUpdate(param0:int):void
            {
                super.settingsUpdate(param0);
                setupVehicleIcon();
            }
        }

        override protected function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATE_DATA))
            {
                var playerState:VOPlayerState = BattleState.get(vehicleID);
                if (playerState)
                {
                    setupVehicleIcon();
                    dispatchEvent(new XvmVehicleMarkerEvent(XvmVehicleMarkerEvent.UPDATE, playerState, exInfo));
                    if (playerState.damageInfo != null)
                    {
                        dispatchEvent(new XvmVehicleMarkerEvent(XvmVehicleMarkerEvent.UPDATE_HEALTH, playerState, exInfo));
                        playerState.damageInfo = null;
                    }
                    if (playerState.markerState != null)
                    {
                        dispatchEvent(new XvmVehicleMarkerEvent(XvmVehicleMarkerEvent.UPDATE_STATE, playerState, exInfo));
                        playerState.markerState = null;
                    }
                }
            }
        }

        // HACK: transfer attackerID in the damageType argument
        CLIENT::WG {
            override public function updateHealth(newHealth:int, damageFlag:uint, damageType:String):void
            {
                xvm_updateHealth(newHealth, damageFlag, damageType);
            }
        }

        CLIENT::LESTA {
            override public function updateHealth(newHealth:int, damageFlag:int, damageType:String):void
            {
                xvm_updateHealth(newHealth, damageFlag, damageType);
            }
        }

        private function xvm_updateHealth(newHealth:int, damageFlag:int, damageType:String):void
        {
            this.curHealth = newHealth;
            var playerState:VOPlayerState = BattleState.get(vehicleID);
            if (playerState)
            {
                var damageTypeSplitted:Array = damageType.split(",");
                damageType = damageTypeSplitted[0];
                var attackerID:Number = Number(damageTypeSplitted[1]);
                if (!playerState.isAlive && damageFlag == Defines.FROM_UNKNOWN && attackerID == 0)
                {
                    playerState.damageInfo = null;
                    playerState.update({curHealth: newHealth});
                }
                else
                {
                    playerState.update({
                        damageInfo: new VODamageInfo({
                            damageDelta: playerState.getCurHealthValue() - Math.max(newHealth, 0),
                            damageType: damageType,
                            damageFlag: damageFlag,
                            attackerID: attackerID
                        }),
                        curHealth: newHealth
                    });
                }
                // BattleState may not be updated yet, but {{my-frags}} macro should display correct value in the damage message
                if (newHealth <= 0)
                {
                    if (damageFlag == Defines.FROM_PLAYER)
                    {
                        updatePlayerFrags();
                    }
                }
                playerState.dispatchEvents();
                invalidate(INVALIDATE_DATA);
                validateNow(); // required to handle simultaneous shots
            }
        }

        override public function setHealth(curHealth:int):void
        {
            this.curHealth = curHealth;
            var playerState:VOPlayerState = BattleState.get(vehicleID);
            if (playerState)
            {
                playerState.update( { damageInfo:null, curHealth: curHealth } );
                playerState.dispatchEvents();
            }
        }

        CLIENT::WG {
            override public function updateState(newState:String, immediate:Boolean, text:String = "", iconAnimation:String = "", isFrequent:Boolean = false):void
            {
                super.updateState(newState, immediate, text, iconAnimation, isFrequent);
                if (iconAnimation != Values.EMPTY_STR)
                {
                    var playerState:VOPlayerState = BattleState.get(vehicleID);
                    if (playerState)
                    {
                        playerState.update({
                            markerState: new VOMarkerState({
                                criticalHitLabelText: text,
                                hitExplosionAnimationType: iconAnimation
                            })
                        });
                    }
                }
                invalidate(INVALIDATE_DATA);
            }
        }

        CLIENT::LESTA {
            override public function updateState(newState:String, immediate:Boolean, text:String = "", iconAnimation:String = ""):void
            {
                super.updateState(newState, immediate, text, iconAnimation);
                if (iconAnimation != Values.EMPTY_STR)
                {
                    var playerState:VOPlayerState = BattleState.get(vehicleID);
                    if (playerState)
                    {
                        playerState.update({
                            markerState: new VOMarkerState({
                                criticalHitLabelText: text,
                                hitExplosionAnimationType: iconAnimation
                            })
                        });
                    }
                }
                invalidate(INVALIDATE_DATA);
            }
        }

        override public function setSpeaking(value:Boolean):void
        {
            var playerState:VOPlayerState = BattleState.get(vehicleID);
            if (playerState)
            {
                dispatchEvent(new XvmVehicleMarkerEvent(XvmVehicleMarkerEvent.SET_SPEAKING, playerState, exInfo));
            }
        }

        override public function activateHover(value:Boolean):void
        {
            super.activateHover(false);

            if (hoverMarkerComponent)
            {
                hoverMarkerComponent.activateHover(value);
            }
        }

        public function xvm_setDistance(dist:String):void
        {
            vehicleDistComponent.setDistance(dist);
        }

        CLIENT::LESTA
        {
            override public function setDistance(dist:String):void
            {
                super.setDistance("");
                xvm_setDistance(dist);
            }
        }

        override public function setIsStickyAndOutOfScreen(isStickyAndOutOfScreen:Boolean):void
        {
            super.setIsStickyAndOutOfScreen(isStickyAndOutOfScreen);
            this.isStickyAndOutOfScreen = isStickyAndOutOfScreen;
            var playerState:VOPlayerState = BattleState.get(vehicleID);
            if (playerState)
            {
                dispatchEvent(new XvmVehicleMarkerEvent(XvmVehicleMarkerEvent.UPDATE, playerState, exInfo));
            }
        }

        private final function setupVehicleIcon():void
        {
            var isAlly:Boolean = this.entityType == VehicleMarkersConstants.ENTITY_TYPE_ALLY;

            var atlasManager:RootSWFAtlasManager = RootSWFAtlasManager.instance;
            var atlasName:String = isAlly ? XvmVehicleMarkersMod.allyAtlas : XvmVehicleMarkersMod.enemyAtlas;
            if (atlasManager.isAtlasInitialized(atlasName))
            {
                RootSWFAtlasManager.instance.drawWithCenterAlign(atlasName, vehicleIconName, vehicleIcon.graphics, true, false);
                XfwAccess.getPrivateField(this, 'updateIconColor')();
            }
        }

        private var _xvm_active_called:Boolean = false;

        /**
         * Allow only one updateMarkerSettings() call from the original code (to hide controls)
         */
        public final function xvm_active():Boolean
        {
            if (!_xvm_active_called)
            {
                _xvm_active_called = true;
                return false;
            }
            return true;
        }

        override public function get markerSettings():Object
        {
            return XvmVehicleMarkerConstants.DISABLED_MARKER_SETTINGS;
        }

        // PRIVATE

        private function onShowExInfoHandler(e:VehicleMarkersManagerEvent):void
        {
            var playerState:VOPlayerState = BattleState.get(vehicleID);
            if (playerState)
            {
                dispatchEvent(new XvmVehicleMarkerEvent(XvmVehicleMarkerEvent.EX_INFO, playerState, exInfo));
            }
        }

        private function createComponents():void
        {
            vehicleTypeIconComponent = new VehicleTypeIconComponent(this);
            contourIconComponent = new ContourIconComponent(this);
            levelIconComponent = new LevelIconComponent(this);
            actionMarkerComponent = new ActionMarkerComponent(this);
            hoverMarkerComponent = new HoverMarkerComponent(this);
            vehicleStatusMarkerComponent = new VehicleStatusMarkerComponent(this);
            healthBarComponent = new HealthBarComponent(this);
            vehicleDistComponent = new VehicleDistComponent(this);
            textFieldsComponent = new TextFieldsComponent(this);
            damageIndicatorComponent = new DamageIndicatorComponent(this);
            damageTextComponent = new DamageTextComponent(this);
        }

        private function deleteComponents():void
        {
            if (vehicleTypeIconComponent)
            {
                vehicleTypeIconComponent.dispose();
                vehicleTypeIconComponent = null;
            }
            if (contourIconComponent)
            {
                contourIconComponent.dispose();
                contourIconComponent = null;
            }
            if (levelIconComponent)
            {
                levelIconComponent.dispose();
                levelIconComponent = null;
            }
            if (actionMarkerComponent)
            {
                actionMarkerComponent.dispose();
                actionMarkerComponent = null;
            }
            if (hoverMarkerComponent)
            {
                hoverMarkerComponent.dispose();
                hoverMarkerComponent = null;
            }
            if (vehicleStatusMarkerComponent)
            {
                vehicleStatusMarkerComponent.dispose();
                vehicleStatusMarkerComponent = null;
            }
            if (healthBarComponent)
            {
                healthBarComponent.dispose();
                healthBarComponent = null;
            }
            if (textFieldsComponent)
            {
                textFieldsComponent.dispose();
                textFieldsComponent = null;
            }
            if (damageIndicatorComponent)
            {
                damageIndicatorComponent.dispose();
                damageIndicatorComponent = null;
            }
            if (damageTextComponent)
            {
                damageTextComponent.dispose();
                damageTextComponent = null;
            }
            if (vehicleDistComponent)
            {
                vehicleDistComponent.dispose();
                vehicleDistComponent = null;
            }
        }

        private function init(vehicleID:Number):void
        {
            this.vehicleID = vehicleID;
            var playerState:VOPlayerState = BattleState.get(vehicleID);
            if (!isNaN(this.curHealth))
            {
                playerState.update({
                    curHealth: this.curHealth
                });
            }
            playerState.update({
                maxHealth: this.maxHealth
            });
            dispatchEvent(new XvmVehicleMarkerEvent(XvmVehicleMarkerEvent.INIT, playerState, exInfo));
            playerState.dispatchEvents();
        }

        private function onPlayerStateChanged(e:PlayerStateEvent):void
        {
            if (isNaN(vehicleID))
            {
                if (e.playerName == playerName)
                {
                    init(e.vehicleID);
                }
            }
            if (e.vehicleID == vehicleID)
            {
                invalidate(INVALIDATE_DATA);
            }
        }

        private function onAtlasLoaded(e:Event):void
        {
            if (!isNaN(vehicleID))
            {
                invalidate(INVALIDATE_DATA);
            }
        }

        private static var _vmPlayerFrags:Number = 0;

        private static function updatePlayerFrags():void
        {
            if (_vmPlayerFrags == BattleState.playerFrags)
            {
                BattleState.playerFrags += 1;
            }
            _vmPlayerFrags = BattleState.playerFrags;
        }
    }
}
