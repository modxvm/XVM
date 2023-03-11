/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.vehiclemarkers.ui.*;
    import net.wg.infrastructure.interfaces.entity.*;

    public class VehicleMarkerComponentBase implements IDisposable
    {
        protected var marker:XvmVehicleMarker;
        protected var initialized:Boolean;

        private var _disposed:Boolean = false;

        public function VehicleMarkerComponentBase(marker:XvmVehicleMarker)
        {
            this.marker = marker;
            this.initialized = false;
            var instance:IVehicleMarkerComponent = this as IVehicleMarkerComponent;
            marker.addEventListener(XvmVehicleMarkerEvent.INIT, instance.init, false, 0, true);
            marker.addEventListener(XvmVehicleMarkerEvent.UPDATE, instance.update, false, 0, true);
            marker.addEventListener(XvmVehicleMarkerEvent.EX_INFO, instance.onExInfo, false, 0, true);
        }

        public final function dispose():void
        {
            onDispose();
            var instance:IVehicleMarkerComponent = this as IVehicleMarkerComponent;
            marker.removeEventListener(XvmVehicleMarkerEvent.INIT, instance.init);
            marker.removeEventListener(XvmVehicleMarkerEvent.UPDATE, instance.update);
            marker.removeEventListener(XvmVehicleMarkerEvent.EX_INFO, instance.onExInfo);

            _disposed = true;
        }

        public final function isDisposed(): Boolean
        {
            return _disposed;
        }

        protected function onDispose():void
        {
            // virtual
        }
    }
}
