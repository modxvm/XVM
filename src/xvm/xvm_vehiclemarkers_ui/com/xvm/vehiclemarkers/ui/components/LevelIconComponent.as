/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
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
                marker.levelIcon.visible = cfg.enabled;
                if (cfg.enabled)
                {
                    marker.levelIcon.x = cfg.x;
                    marker.levelIcon.y = cfg.y;
                    marker.levelIcon.alpha = cfg.alpha / 100.0;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
