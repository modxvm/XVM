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
    import flash.display.*;

    public final class LevelIconComponent extends VehicleMarkerComponentBase implements IVehicleMarkerComponent
    {
        public final function LevelIconComponent(marker:XvmVehicleMarker)
        {
            super(marker);
        }

        [Inline]
        public final function init(e:XvmVehicleMarkerEvent):void
        {
            // stub
        }

        [Inline]
        public final function onExInfo(e:XvmVehicleMarkerEvent):void
        {
            update(e);
        }

        public final function update(e:XvmVehicleMarkerEvent):void
        {
            var cfg:CMarkersLevelIcon = e.cfg.levelIcon;
            var enabled:Boolean = cfg.enabled;
            var marker_levelIcon:MovieClip = marker.levelIcon;
            marker_levelIcon.visible = enabled;
            if (enabled)
            {
                marker_levelIcon.x = cfg.x;
                marker_levelIcon.y = cfg.y;
                marker_levelIcon.alpha = cfg.alpha / 100.0;
            }
        }
    }
}
