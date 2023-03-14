/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui.components
{
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.vo.VOPlayerState;
    import com.xvm.types.cfg.*;
    import com.xvm.vehiclemarkers.ui.*;
    import net.wg.gui.battle.views.vehicleMarkers.VehicleActionMarker;

    public final class HoverMarkerComponent extends VehicleMarkerComponentBase implements IVehicleMarkerComponent
    {
        private var hoverMarker:MovieClip = null;
        private var enabled:Boolean = true;
        private var isHover:Boolean = false;

        public final function HoverMarkerComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            hoverMarker = marker.vehicleMarkerHoverMC;
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
            var cfg:CMarkersHoverMarker = e.cfg.hoverMarker;
            enabled = cfg.enabled;
            activateHover(isHover); // force refresh on ExInfo change
            if (enabled)
            {
                var playerState:VOPlayerState = e.playerState;
                hoverMarker.x = Macros.FormatNumber(cfg.x, playerState);
                hoverMarker.y = Macros.FormatNumber(cfg.y, playerState);
                hoverMarker.alpha = Macros.FormatNumber(cfg.alpha, playerState) / 100.0;
                
                var glowMC:DisplayObject = hoverMarker.getChildAt(0);
                glowMC.visible = cfg.glow.enabled;
                glowMC.x = Macros.FormatNumber(cfg.glow.x, playerState);
                glowMC.y = Macros.FormatNumber(cfg.glow.y, playerState);
                glowMC.alpha = Macros.FormatNumber(cfg.glow.alpha, playerState) / 100.0;
            }
        }

        public function activateHover(value:Boolean):void
        {
            isHover = value;
            hoverMarker.visible = isHover && enabled;
        }

    }
}
