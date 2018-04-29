/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vehiclemarkers.ui.*;

    public class VehicleStatusMarkerComponent extends VehicleMarkerComponentBase
    {
        public function VehicleStatusMarkerComponent(marker:XvmVehicleMarker)
        {
            super(marker);
        }

        override protected function update(e:XvmVehicleMarkerEvent):void
        {
            try
            {
                super.update(e);
                var cfg:CMarkersVehicleStatusMarker = e.cfg.vehicleStatusMarker;
                marker.statusContainer.visible = cfg.enabled;
                if (cfg.enabled)
                {
                    marker.statusContainer.x = Macros.FormatNumber(cfg.x, e.playerState);
                    marker.statusContainer.y = Macros.FormatNumber(cfg.y, e.playerState) - 38;
                    marker.statusContainer.alpha = Macros.FormatNumber(cfg.alpha, e.playerState) / 100.0;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
