/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.vehiclemarkers.ui.*;
    import flash.events.*;
    import net.wg.infrastructure.interfaces.entity.*;

    public class VehicleMarkerComponentBase implements IDisposable
    {
        protected var marker:XvmVehicleMarker;

        public function VehicleMarkerComponentBase(marker:XvmVehicleMarker)
        {
            this.marker = marker;
            marker.addEventListener(XvmVehicleMarkerEvent.INIT, init, false, 0, true);
            marker.addEventListener(XvmVehicleMarkerEvent.UPDATE, update, false, 0, true);
            marker.addEventListener(XvmVehicleMarkerEvent.EX_INFO, onExInfo, false, 0, true);
        }

        public final function dispose():void
        {
            onDispose();
        }

        protected function onDispose():void
        {
            // virtual
            marker.removeEventListener(XvmVehicleMarkerEvent.INIT, init);
            marker.removeEventListener(XvmVehicleMarkerEvent.UPDATE, update);
            marker.removeEventListener(XvmVehicleMarkerEvent.EX_INFO, onExInfo);
        }

        protected function init(e:XvmVehicleMarkerEvent):void
        {
            // virtual
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
