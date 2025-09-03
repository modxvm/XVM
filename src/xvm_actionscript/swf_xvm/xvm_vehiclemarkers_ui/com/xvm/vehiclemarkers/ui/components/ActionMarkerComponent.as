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
    import net.wg.gui.battle.views.vehicleMarkers.VehicleActionMarker;

    public final class ActionMarkerComponent extends VehicleMarkerComponentBase implements IVehicleMarkerComponent
    {
        public final function ActionMarkerComponent(marker:XvmVehicleMarker)
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
            var cfg:CMarkersActionMarker = e.cfg.actionMarker;
            var visible:Boolean = cfg.enabled;
            var marker_actionMarker:VehicleActionMarker = marker.actionMarker;
            marker_actionMarker.visible = visible;
            if (visible)
            {
                var playerState:VOPlayerState = e.playerState;
                marker_actionMarker.x = Macros.FormatNumber(cfg.x, playerState);
                marker_actionMarker.y = Macros.FormatNumber(cfg.y, playerState);
                marker_actionMarker.alpha = Macros.FormatNumber(cfg.alpha, playerState) / 100.0;
            }
        }
    }
}
