/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.vo.*;
    import com.xvm.vehiclemarkers.ui.components.*;
    import com.xvm.vo.*;
    import flash.utils.*;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager; // * - name conflict
    import net.wg.gui.battle.views.vehicleMarkers.events.*;

    public dynamic class XvmVehicleMarker extends VehicleMarker
    {
        private static const INVALIDATE_DATA:uint = 1 << 29;

        public var vehicleID:Number = NaN;
        private var playerName:String = null;
        private var curHealth:Number = NaN;
        private var maxHealth:int = 0;

        private var actionMarkerComponent:ActionMarkerComponent = null;
        private var stunMarkerComponent:StunMarkerComponent = null;
        private var contourIconComponent:ContourIconComponent = null;
        private var damageTextComponent:DamageTextComponent = null;
        private var healthBarComponent:HealthBarComponent = null;
        private var levelIconComponent:LevelIconComponent = null;
        private var textFieldsComponent:TextFieldsComponent = null;
        private var vehicleTypeIconComponent:VehicleTypeIconComponent = null;

        public function XvmVehicleMarker()
        {
            Xvm.swfProfilerBegin("XvmVehicleMarker.ctor()");
            //Logger.add(getQualifiedClassName(this));
            super();
            super.markerSettings = XvmVehicleMarkerConstants.DISABLED_MARKER_SETTINGS;
            Xvm.addEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
            createComponents();
            Xvm.swfProfilerEnd("XvmVehicleMarker.ctor()");
        }

        override protected function configUI():void
        {
            Xvm.swfProfilerBegin("XvmVehicleMarker.configUI()");
            super.configUI();
            var vmManager:VehicleMarkersManager = VehicleMarkersManager.getInstance();
            vmManager.addEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO, onShowExInfoHandler, false, 0, true);
            // TODO: removeStandardFields();
            Xvm.swfProfilerEnd("XvmVehicleMarker.configUI()");
        }

        override protected function onDispose():void
        {
            Xvm.swfProfilerBegin("XvmVehicleMarker.onDispose()");
            super.onDispose();
            Xvm.removeEventListener(PlayerStateEvent.CHANGED, onPlayerStateChanged);
            var vmManager:VehicleMarkersManager = VehicleMarkersManager.getInstance();
            vmManager.removeEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO, onShowExInfoHandler);
            deleteComponents();
            Xvm.swfProfilerEnd("XvmVehicleMarker.onDispose()");
        }

        override public function setVehicleInfo(vClass:String, vIconSource:String, vType:String, vLevel:int,
            pFullName:String, pName:String, pClan:String, pRegion:String,
            maxHealth:int, entityName:String, hunt:Boolean, squadIndex:int, locSecString:String):void
        {
            // WORKAROUND: possible bug - marker instance not deletes on MarkersManager.destroyMarker() call.
            if (!parent) { dispose(); return; }
            ///

            Xvm.swfProfilerBegin("XvmVehicleMarker.setVehicleInfo()");
            super.setVehicleInfo.apply(this, arguments);
            try
            {
                this.playerName = pName;
                this.maxHealth = maxHealth;
                vehicleID = BattleState.getVehicleIDByPlayerName(playerName);
                if (!isNaN(vehicleID))
                {
                    init(vehicleID);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            Xvm.swfProfilerEnd("XvmVehicleMarker.setVehicleInfo()");
        }

        override protected function draw():void
        {
            // WORKAROUND: possible bug - marker instance not deletes on MarkersManager.destroyMarker() call.
            if (!parent) { dispose(); return; }
            ///

            Xvm.swfProfilerBegin("XvmVehicleMarker.super.draw()");
            super.draw();
            Xvm.swfProfilerEnd("XvmVehicleMarker.super.draw()");
            Xvm.swfProfilerBegin("XvmVehicleMarker.draw()");
            try
            {
                if (isInvalid(INVALIDATE_DATA))
                {
                    var playerState:VOPlayerState = BattleState.get(vehicleID);
                    if (playerState)
                    {
                        dispatchEvent(new XvmVehicleMarkerEvent(XvmVehicleMarkerEvent.UPDATE, playerState, exInfo));
                        if (playerState.damageInfo != null)
                        {
                            dispatchEvent(new XvmVehicleMarkerEvent(XvmVehicleMarkerEvent.UPDATE_HEALTH, playerState, exInfo));
                            playerState.damageInfo = null;
                        }
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            Xvm.swfProfilerEnd("XvmVehicleMarker.draw()");
        }

        override public function updateHealth(newHealth:int, damageFlag:int, damageType:String):void
        {
            // WORKAROUND: possible bug - marker instance not deletes on MarkersManager.destroyMarker() call.
            if (!parent) { dispose(); return; }
            ///

            Xvm.swfProfilerBegin("XvmVehicleMarker.updateHealth()");
            try
            {
                this.curHealth = newHealth;
                var playerState:VOPlayerState = BattleState.get(vehicleID);
                if (playerState)
                {
                    //Logger.add("updateHealth: " + playerState.playerName + " " + newHealth);
                    playerState.update({
                        damageInfo: new VODamageInfo({
                            damageDelta: playerState.getCurHealthValue() - Math.max(newHealth, 0),
                            damageType: damageType,
                            damageFlag: damageFlag
                        }),
                        curHealth: newHealth
                    });
                    if (newHealth <= 0 && damageFlag == Defines.FROM_PLAYER)
                        BattleState.playerFrags += 1;
                    playerState.dispatchEvents();
                    invalidate(INVALIDATE_DATA);
                    validateNow(); // required to handle simultaneous shots
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            Xvm.swfProfilerEnd("XvmVehicleMarker.updateHealth()");
        }

        override public function setHealth(curHealth:int):void
        {
            // WORKAROUND: possible bug - marker instance not deletes on MarkersManager.destroyMarker() call.
            if (!parent) { dispose(); return; }
            ///

            Xvm.swfProfilerBegin("XvmVehicleMarker.setHealth()");
            try
            {
                //Logger.add("curHealth=" + curHealth);
                this.curHealth = curHealth;
                var playerState:VOPlayerState = BattleState.get(vehicleID);
                if (playerState)
                {
                    playerState.update( { damageInfo:null, curHealth: curHealth } );
                    playerState.dispatchEvents();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            Xvm.swfProfilerEnd("XvmVehicleMarker.setHealth()");
        }

        override public function updateState(state:String, param2:Boolean):void
        {
            super.updateState(state, param2);
            invalidate(INVALIDATE_DATA);
        }

        override public function setSpeaking(value:Boolean):void
        {
            // WORKAROUND: possible bug - marker instance not deletes on MarkersManager.destroyMarker() call.
            if (!parent) { dispose(); return; }
            ///

            Xvm.swfProfilerBegin("XvmVehicleMarker.setSpeaking()");
            super.setSpeaking(value);
            try
            {
                var playerState:VOPlayerState = BattleState.get(vehicleID);
                if (playerState)
                {
                    dispatchEvent(new XvmVehicleMarkerEvent(XvmVehicleMarkerEvent.SET_SPEAKING, playerState, exInfo));
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            Xvm.swfProfilerEnd("XvmVehicleMarker.setSpeaking()");
        }

        override public function set markerSettings(value:Object):void
        {
            // stub
        }

        override protected function layoutParts(param1:Vector.<Boolean>):void
        {
            // stub
        }

        private function onShowExInfoHandler(e:VehicleMarkersManagerEvent):void
        {
            // WORKAROUND: possible bug - marker instance not deletes on MarkersManager.destroyMarker() call.
            if (!parent) { dispose(); return; }
            ///

            //Xvm.swfProfilerBegin("XvmVehicleMarker.onShowExInfoHandler()");
            try
            {
                var playerState:VOPlayerState = BattleState.get(vehicleID);
                if (playerState)
                {
                    dispatchEvent(new XvmVehicleMarkerEvent(XvmVehicleMarkerEvent.EX_INFO, playerState, exInfo));
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            //Xvm.swfProfilerEnd("XvmVehicleMarker.onShowExInfoHandler()");
        }

        // PRIVATE

        private function createComponents():void
        {
            try
            {
                vehicleTypeIconComponent = new VehicleTypeIconComponent(this);
                contourIconComponent = new ContourIconComponent(this);
                levelIconComponent = new LevelIconComponent(this);
                actionMarkerComponent = new ActionMarkerComponent(this);
                stunMarkerComponent = new StunMarkerComponent(this);
                healthBarComponent = new HealthBarComponent(this);
                textFieldsComponent = new TextFieldsComponent(this);
                damageTextComponent = new DamageTextComponent(this);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function deleteComponents():void
        {
            try
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
                if (stunMarkerComponent)
                {
                    stunMarkerComponent.dispose();
                    stunMarkerComponent = null;
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
                if (damageTextComponent)
                {
                    damageTextComponent.dispose();
                    damageTextComponent = null;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
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
            RegisterVehicleMarkerData();
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

        private function RegisterVehicleMarkerData():void
        {
            var dict:Object = Macros.Players;
            if (!dict.hasOwnProperty(playerName))
                dict[playerName] = {};
            var pdata:Object = dict[playerName];

            // {{turret}}
            pdata["turret"] = getTurretData();
        }

        private function getTurretData():String
        {
            var playerState:VOPlayerState = BattleState.get(vehicleID);
            if (playerState)
            {
                var vdata:VOVehicleData = VehicleInfo.get(playerState.vehCD);
                if (vdata)
                {
                    if (vdata.hpTop != playerState.maxHealth)
                    {
                        switch (vdata.turret)
                        {
                            case XvmVehicleMarkerConstants.TURRET_HIGH_VULN_DATABASE_VAL:
                                return Macros.Format(Config.config.markers.turretMarkers.highVulnerability, playerState);
                            case XvmVehicleMarkerConstants.TURRET_LOW_VULN_DATABASE_VAL:
                                return Macros.Format(Config.config.markers.turretMarkers.lowVulnerability, playerState);
                        }
                    }
                }
            }
            return null;
        }
    }
}

