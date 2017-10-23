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

    public class ContourIconComponent extends VehicleMarkerComponentBase
    {
        public function ContourIconComponent(marker:XvmVehicleMarker)
        {
            super(marker);
        }

        override protected function update(e:XvmVehicleMarkerEvent):void
        {
            try
            {
                super.update(e);
                var cfg:CMarkersContourIcon = e.cfg.contourIcon;
                marker.vehicleIcon.visible = cfg.enabled;
                if (cfg.enabled)
                {
                    marker.vehicleIcon.x = cfg.x;
                    marker.vehicleIcon.y = cfg.y;
                    marker.vehicleIcon.alpha = cfg.alpha / 100.0;
                    if (!isNaN(cfg.amount))
                    {
                        var color:Number = isNaN(cfg.color) ? Macros.FormatNumber("{{c:system}}", e.playerState) : cfg.color;
                        GraphicsUtil.tint(marker.vehicleIcon, color, cfg.amount / 100.0);
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
