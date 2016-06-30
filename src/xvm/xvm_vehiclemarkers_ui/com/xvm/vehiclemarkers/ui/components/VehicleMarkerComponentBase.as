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
            marker.addEventListener(Event.INIT, init);
            marker.addEventListener(Event.CHANGE, draw);
        }

        public function dispose():void
        {
            //
        }

        protected function init():void
        {

        }

        protected function draw():void
        {

        }
    }
}
