/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.vo.VOPlayerState;
    import com.xvm.types.cfg.*;
    import com.xvm.vehiclemarkers.ui.*;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleStatusContainerMarker;

    public final class VehicleStatusMarkerComponent extends VehicleMarkerComponentBase implements IVehicleMarkerComponent
    {
        public final function VehicleStatusMarkerComponent(marker:XvmVehicleMarker)
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
            var cfg:CMarkersVehicleStatusMarker = e.cfg.vehicleStatusMarker;
            var enabled:Boolean = cfg.enabled;
            var marker_statusContainer:VehicleStatusContainerMarker = marker.statusContainer;
            marker_statusContainer.visible = enabled;
            if (enabled)
            {
                var playerState:VOPlayerState = e.playerState;
                marker_statusContainer.x = Macros.FormatNumber(cfg.x, playerState);
                marker_statusContainer.y = Macros.FormatNumber(cfg.y, playerState) - 38;
                marker_statusContainer.alpha = Macros.FormatNumber(cfg.alpha, playerState) / 100.0;
            }
        }
    }
}
