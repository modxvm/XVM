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
    import com.xvm.vo.VOVehicleData;
    import flash.utils.*;
    import flash.events.*;
    import net.wg.gui.battle.components.constants.*;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants; // * - name conflict
    import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager; // * - name conflict
    import net.wg.gui.battle.views.vehicleMarkers.VO.*;

    public dynamic class XvmVehicleMarker extends VehicleMarker
    {
        private var playerName:String = null;

        private var actionMarkerComponent:ActionMarkerComponent;
        private var contourIconComponent:ContourIconComponent;
        private var damageTextComponent:DamageTextComponent;
        private var healthBarComponent:HealthBarComponent;
        private var levelIconComponent:LevelIconComponent;
        private var textFieldsComponent:TextFieldsComponent;
        private var vehicleIconComponent:VehicleIconComponent;

        public function XvmVehicleMarker()
        {
            //Logger.add(getQualifiedClassName(this));
            super();
            super.markerSettings = XvmVehicleMarkerConstants.DISABLED_MARKER_SETTINGS;
            Xvm.addEventListener(PlayerStateEvent.PLAYER_STATE_CHANGED, onPlayerStateChanged);
            createComponents();
        }

        override protected function configUI():void
        {
            super.configUI();
            // TODO: removeStandardFields();
        }

        override protected function onDispose():void
        {
            super.onDispose();
            Xvm.removeEventListener(PlayerStateEvent.PLAYER_STATE_CHANGED, onPlayerStateChanged);
            deleteComponents();
        }

        override public function setVehicleInfo(vClass:String, vIconSource:String, vType:String, vLevel:int,
            pFullName:String, pName:String, pClan:String, pRegion:String,
            maxHealth:int, entityName:String, hunt:Boolean, squadIndex:int):void
        {
            super.setVehicleInfo.apply(this, arguments);
            this.playerName = pName;
            var playerState:VOPlayerState = BattleState.getByPlayerName(playerName);
            if (playerState != null)
            {
                playerState.maxHealth = maxHealth;
                Macros.RegisterVehicleMarkerData(this.RegisterVehicleMarkerData);
            }
            dispatchEvent(new Event(Event.INIT));
        }

        override protected function draw():void
        {
            super.draw();
            if (isInvalid(InvalidationType.DATA))
            {
                dispatchEvent(new Event(Event.CHANGE));
            }
        }

        override public function set markerSettings(value:Object):void
        {
            // stub
        }

        override public function layoutParts(param1:Vector.<Boolean>):void
        {
            // stub
        }

        // PRIVATE

        private function createComponents():void
        {
            actionMarkerComponent = new ActionMarkerComponent(this);
            contourIconComponent = new ContourIconComponent(this);
            damageTextComponent = new DamageTextComponent(this);
            healthBarComponent = new HealthBarComponent(this);
            levelIconComponent = new LevelIconComponent(this);
            textFieldsComponent = new TextFieldsComponent(this);
            vehicleIconComponent = new VehicleIconComponent(this);
        }

        private function deleteComponents():void
        {
            actionMarkerComponent.dispose();
            actionMarkerComponent = null;
            contourIconComponent.dispose();
            contourIconComponent = null;
            damageTextComponent.dispose();
            damageTextComponent = null;
            healthBarComponent.dispose();
            healthBarComponent = null;
            levelIconComponent.dispose();
            levelIconComponent = null;
            textFieldsComponent.dispose();
            textFieldsComponent = null;
            vehicleIconComponent.dispose();
            vehicleIconComponent = null;
        }

        private function RegisterVehicleMarkerData(m_dict:Object):void
        {
            if (!m_dict.hasOwnProperty(playerName))
                m_dict[playerName] = {};
            var pdata:Object = m_dict[playerName];

            // {{turret}}
            pdata["turret"] = getTurretData();
        }

        private function onPlayerStateChanged(e:PlayerStateEvent):void
        {
            if (e.playerName == playerName)
            {
                invalidate(InvalidationType.DATA);
            }
        }

        private function getTurretData():String
        {
            var turret:int = XvmVehicleMarkerConstants.TURRET_UNKNOWN_VULN_DATABASE_VAL;
            var playerState:VOPlayerState = BattleState.getByPlayerName(playerName);
            if (playerState != null)
            {
                var vdata:VOVehicleData = VehicleInfo.get(playerState.vehCD);
                if (vdata != null)
                {
                    if (vdata.hpStock == playerState.maxHealth)
                    {
                        switch (turret)
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

