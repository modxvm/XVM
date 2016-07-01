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

        override protected function update(e:XvmVehicleMarkerEvent):void
        {
            try
            {
                super.update(e);
                var cfg:CMarkersActionMarker = e.cfg.actionMarker;
                marker.actionMarker.visible = Macros.FormatBoolean(cfg.enabled, e.playerState, true);
                if (marker.actionMarker.visible)
                {
                    marker.actionMarker.x = Macros.FormatNumber(cfg.x, e.playerState);
                    marker.actionMarker.y = Macros.FormatNumber(cfg.y, e.playerState);
                    marker.actionMarker.alpha = Macros.FormatNumber(cfg.alpha, e.playerState, 1) / 100.0;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
