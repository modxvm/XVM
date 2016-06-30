/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.vo.VOPlayerState;
    import com.xvm.battle.vo.VOPlayersData;
    import flash.utils.*;
    import flash.events.*;
    import net.wg.gui.battle.components.constants.*;
    import net.wg.gui.battle.views.vehicleMarkers.VO.*;

    public dynamic class XvmVehicleMarker extends VehicleMarker
    {
        public function XvmVehicleMarker()
        {
            //Logger.add(getQualifiedClassName(this));
            //this._vmManager = VehicleMarkersManager.getInstance();
            //this._atlasManager = VMAtlasManager.instance;
            super();
        }

        override protected function configUI():void
        {
            super.configUI();
            //marker.m_markerLabel = "";
            //marker.updateMarkerLabel();
            //marker.update();
            //this._vmManager.addEventListener(VehicleMarkersManagerEvent.SHOW_EX_INFO,this.onShowExInfoHandler);
            //this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_SETTINGS,this.onUpdateSettingsHandler);
            //this._vmManager.addEventListener(VehicleMarkersManagerEvent.UPDATE_COLORS,this.onUpdateColorsHandler);
//            vehicleIcon:MovieClip = null;
//            hpFieldContainer:HPFieldContainer = null;
//            actionMarker:VehicleActionMarker = null;
//            marker:VehicleIconAnimation = null;
//            hitLabel:HealthBarAnimatedLabel = null;
//            hitExplosion:AnimateExplosion = null;
//            vehicleNameField:TextField = null;
//            playerNameField:TextField = null;
//            healthBar:HealthBar = null;
//            bgShadow:MovieClip = null;
//            marker2:FlagContainer = null;
//            levelIcon:MovieClip = null;
//            squadIcon:MovieClip = null;
        }

        override protected function onDispose():void
        {
            super.onDispose();
        }

        override protected function draw():void
        {
            super.draw();
//            if (isInvalid(InvalidationType.DATA) && this._model != null && !this._isPopulated)
//            {
//            }
        }

        override public function setVehicleInfo(param1:String, param2:String, param3:String, param4:int, param5:String, param6:String, param7:String, param8:String, param9:int, param10:String, param11:Boolean, param12:int):void
        {
            super.setVehicleInfo.apply(this, arguments);
            //BattleState.instance.setVehiclesData();
        }

        // PRIVATE

    }
}
