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

    public class LevelIconComponent extends VehicleMarkerComponentBase
    {
        public function LevelIconComponent(marker:XvmVehicleMarker)
        {
            super(marker);
        }

        override protected function update(e:XvmVehicleMarkerEvent):void
        {
            try
            {
                super.update(e);
                var cfg:CMarkersLevelIcon = e.cfg.levelIcon;
                marker.levelIcon.visible = Macros.FormatBoolean(cfg.enabled, e.playerState, true);
                if (marker.levelIcon.visible)
                {
                    marker.levelIcon.x = Macros.FormatNumber(cfg.x, e.playerState);
                    marker.levelIcon.y = Macros.FormatNumber(cfg.y, e.playerState);
                    marker.levelIcon.alpha = Macros.FormatNumber(cfg.alpha, e.playerState, 1) / 100.0;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
