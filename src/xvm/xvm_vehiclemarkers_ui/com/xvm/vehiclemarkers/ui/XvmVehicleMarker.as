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
            super();
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            super.onDispose();
        }

        // PRIVATE

        private function onConfigLoaded():void
        {
            try
            {
                Logger.addObject(arguments);
                //marker.m_markerLabel = "";
                //marker.updateMarkerLabel();
                //marker.update();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

    }
}
