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
            marker.addEventListener(XvmVehicleMarkerEvent.INIT, init);
            marker.addEventListener(XvmVehicleMarkerEvent.UPDATE, update);
        }

        public final function dispose():void
        {
            onDispose();
        }

        protected function onDispose():void
        {
            // virtual
        }

        protected function init(e:XvmVehicleMarkerEvent):void
        {
            update(e);
        }

        protected function update(e:XvmVehicleMarkerEvent):void
        {
            // virtual
        }
    }
}
