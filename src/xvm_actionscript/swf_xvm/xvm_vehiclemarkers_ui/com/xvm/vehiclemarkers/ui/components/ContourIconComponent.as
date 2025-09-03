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
    import flash.display.MovieClip;

    public final class ContourIconComponent extends VehicleMarkerComponentBase implements IVehicleMarkerComponent
    {
        public final function ContourIconComponent(marker:XvmVehicleMarker)
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
            var cfg:CMarkersContourIcon = e.cfg.contourIcon;
            var visible:Boolean = cfg.enabled  && !marker.isStickyAndOutOfScreen;
            var marker_vehicleIcon:MovieClip = marker.vehicleIcon;
            marker_vehicleIcon.visible = visible;
            if (visible)
            {
                marker_vehicleIcon.x = cfg.x;
                marker_vehicleIcon.y = cfg.y;
                marker_vehicleIcon.alpha = cfg.alpha / 100.0;
                if (!isNaN(cfg.amount))
                {
                    var color:Number = isNaN(cfg.color) ? Macros.FormatNumber("{{c:system}}", e.playerState) : cfg.color;
                    GraphicsUtil.tint(marker_vehicleIcon, color, cfg.amount / 100.0);
                }
            }
        }
    }
}
