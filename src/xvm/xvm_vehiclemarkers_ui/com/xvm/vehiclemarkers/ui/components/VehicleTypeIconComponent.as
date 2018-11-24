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

    public class VehicleTypeIconComponent extends VehicleMarkerComponentBase
    {
        private var showSpeaker:Boolean = false;

        public function VehicleTypeIconComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            marker.marker.vehicleTypeIcon = marker.marker.vehicleTypeIcon.addChild(new MovieClip()) as MovieClip;
            marker.addEventListener(XvmVehicleMarkerEvent.SET_SPEAKING, update, false, 0, true);
        }

        override protected function init(e:XvmVehicleMarkerEvent):void
        {
            if (this.initialized)
                return;
            showSpeaker = XfwUtils.toBool(e.cfg.showSpeaker, false);
            super.init(e);
        }

        override protected function update(e:XvmVehicleMarkerEvent):void
        {
            try
            {
                super.update(e);
                var cfg:CMarkersVehicleIcon = e.cfg.vehicleIcon;
                marker.marker.visible = cfg.enabled || (showSpeaker && marker.isSpeaking());
                if (marker.marker.visible)
                {
                    var offsetX:Number = cfg.offsetX;
                    var offsetY:Number = cfg.offsetY;
                    var maxScale:Number = cfg.maxScale / 100.0;
                    maxScale = 1; // TODO
                    marker.marker.x = cfg.x + offsetX * maxScale;
                    marker.marker.y = cfg.y + offsetY * maxScale;
                    marker.marker.alpha = Macros.FormatNumber(cfg.alpha, e.playerState, 100) / 100.0;
                    // TODO: broken - sometimes icon remains alive for dead vehicles. Touching vehicleTypeIcon kills timeline.
                    //marker.marker.vehicleTypeIcon.scaleX = maxScale;
                    //marker.marker.vehicleTypeIcon.scaleY = maxScale;

                    // TODO: change dynamic to vehicle type marker for dead while speaking
                    //if (proxy.isDead && proxy.isSpeaking) // change dynamic to vehicle type marker for dead while speaking
                    //    this.setVehicleClass();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
