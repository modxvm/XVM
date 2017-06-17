/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vehiclemarkers.ui.*;

    public class StunMarkerComponent extends VehicleMarkerComponentBase
    {
        public function StunMarkerComponent(marker:XvmVehicleMarker)
        {
            super(marker);
        }

        override protected function update(e:XvmVehicleMarkerEvent):void
        {
            try
            {
                super.update(e);
                var cfg:CMarkersStunMarker = e.cfg.stunMarker;
                marker.stunMarker.visible = cfg.enabled;
                if (cfg.enabled)
                {
                    marker.stunMarker.x = Macros.FormatNumber(cfg.x, e.playerState);
                    marker.stunMarker.y = Macros.FormatNumber(cfg.y, e.playerState) - 38;
                    marker.stunMarker.alpha = Macros.FormatNumber(cfg.alpha, e.playerState) / 100.0;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
