/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vehiclemarkers.ui.*;

    public class ActionMarkerComponent extends VehicleMarkerComponentBase
    {
        public function ActionMarkerComponent(marker:XvmVehicleMarker)
        {
            super(marker);
        }

        override protected function init(e:XvmVehicleMarkerEvent):void
        {
            super.init(e);
        }

        override protected function update(e:XvmVehicleMarkerEvent):void
        {
            try
            {
                super.update(e);
                var cfg:CMarkersActionMarker = e.cfg.actionMarker;
                marker.actionMarker.visible = cfg.enabled;
                if (cfg.enabled)
                {
                    marker.actionMarker.x = cfg.enabled;
                    marker.actionMarker.y = cfg.enabled;
                    marker.actionMarker.alpha = cfg.enabled / 100.0;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
