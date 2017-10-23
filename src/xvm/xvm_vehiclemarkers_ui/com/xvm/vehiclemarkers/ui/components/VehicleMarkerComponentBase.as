/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.vehiclemarkers.ui.*;
    import net.wg.infrastructure.interfaces.entity.*;

    public class VehicleMarkerComponentBase implements IDisposable
    {
        protected var marker:XvmVehicleMarker;
        protected var initialized:Boolean;

        public function VehicleMarkerComponentBase(marker:XvmVehicleMarker)
        {
            this.marker = marker;
            this.initialized = false;
            marker.addEventListener(XvmVehicleMarkerEvent.INIT, init, false, 0, true);
            marker.addEventListener(XvmVehicleMarkerEvent.UPDATE, update, false, 0, true);
            marker.addEventListener(XvmVehicleMarkerEvent.EX_INFO, onExInfo, false, 0, true);
        }

        public final function dispose():void
        {
            onDispose();
            marker.removeEventListener(XvmVehicleMarkerEvent.INIT, init);
            marker.removeEventListener(XvmVehicleMarkerEvent.UPDATE, update);
            marker.removeEventListener(XvmVehicleMarkerEvent.EX_INFO, onExInfo);
        }

        protected function onDispose():void
        {
            // virtual
            //Logger.add("onDispose()");
        }

        protected function init(e:XvmVehicleMarkerEvent):void
        {
            // virtual
            this.initialized = true;
        }

        protected function update(e:XvmVehicleMarkerEvent):void
        {
            // virtual
        }

        protected function onExInfo(e:XvmVehicleMarkerEvent):void
        {
            update(e);
        }
    }
}
