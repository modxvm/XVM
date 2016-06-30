/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.utils.*;
    import flash.events.*;

    public dynamic class XvmVehicleMarker extends VehicleMarker
    {
        public function XvmVehicleMarker()
        {
            Logger.add(getQualifiedClassName(this));
            super();
        }

        override protected function configUI():void
        {
            super.configUI();
            //marker.m_markerLabel = "";
            //marker.updateMarkerLabel();
            //marker.update();
        }

        override protected function onDispose():void
        {
            super.onDispose();
        }

        // PRIVATE

    }
}
