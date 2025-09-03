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
    import net.wg.gui.battle.views.vehicleMarkers.VehicleIconAnimation;

    public final class VehicleTypeIconComponent extends VehicleMarkerComponentBase implements IVehicleMarkerComponent
    {
        private var showSpeaker:Boolean = false;

        public final function VehicleTypeIconComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            marker.marker.vehicleTypeIcon = marker.marker.vehicleTypeIcon.addChild(new MovieClip()) as MovieClip;
            marker.addEventListener(XvmVehicleMarkerEvent.SET_SPEAKING, update, false, 0, true);
        }

        public final function init(e:XvmVehicleMarkerEvent):void
        {
            if (!this.initialized)
            {
                this.initialized = true;
                showSpeaker = XfwUtils.toBool(e.cfg.vehicleIcon.showSpeaker, false);
            }
        }

        [Inline]
        public final function onExInfo(e:XvmVehicleMarkerEvent):void
        {
            update(e);
        }

        public final function update(e:XvmVehicleMarkerEvent):void
        {
            var cfg:CMarkersVehicleIcon = e.cfg.vehicleIcon;
            var visible:Boolean = (cfg.enabled || (showSpeaker && marker.isSpeaking())) && !marker.isStickyAndOutOfScreen;
            var marker_marker:VehicleIconAnimation = marker.marker;
            marker_marker.vehicleTypeIcon.visible = visible;
            if (visible)
            {
                var offsetX:Number = cfg.offsetX;
                var offsetY:Number = cfg.offsetY;
                var maxScale:Number = cfg.maxScale / 100.0;
                maxScale = 1; // TODO
                marker_marker.x = cfg.x + offsetX * maxScale;
                marker_marker.y = cfg.y + offsetY * maxScale;
                marker_marker.alpha = Macros.FormatNumber(cfg.alpha, e.playerState, 100) / 100.0;
                // TODO: broken - sometimes icon remains alive for dead vehicles. Touching vehicleTypeIcon kills timeline.
                //marker.marker.vehicleTypeIcon.scaleX = maxScale;
                //marker.marker.vehicleTypeIcon.scaleY = maxScale;
                // TODO: change dynamic to vehicle type marker for dead while speaking
                //if (proxy.isDead && proxy.isSpeaking) // change dynamic to vehicle type marker for dead while speaking
                //    this.setVehicleClass();
            }
        }
    }
}
