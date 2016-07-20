/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vehiclemarkers.ui.*;
    import flash.display.*;
    import net.wg.gui.battle.views.vehicleMarkers.*;

    public class VehicleTypeIconComponent extends VehicleMarkerComponentBase
    {
        private var showSpeaker:Boolean = false;

        public function VehicleTypeIconComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            marker.marker.vehicleTypeIcon = marker.marker.vehicleTypeIcon.addChild(new MovieClip()) as MovieClip;
            marker.addEventListener(XvmVehicleMarkerEvent.SET_SPEAKING, update);
        }

        override protected function init(e:XvmVehicleMarkerEvent):void
        {
            super.init(e);
            showSpeaker = XfwUtils.toBool(e.cfg.showSpeaker, false);
        }

        override protected function update(e:XvmVehicleMarkerEvent):void
        {
            try
            {
                super.update(e);
                var cfg:CMarkersVehicleIcon = e.cfg.vehicleIcon;
                marker.marker.visible = (showSpeaker && marker.isSpeaking()) || Macros.FormatBoolean(cfg.enabled, e.playerState, true);
                if (marker.marker.visible)
                {
                    var offsetX:Number = Macros.FormatNumber(cfg.offsetX, e.playerState);
                    var offsetY:Number = Macros.FormatNumber(cfg.offsetY, e.playerState);
                    var maxScale:Number = Macros.FormatNumber(cfg.maxScale, e.playerState) / 100.0;
                    maxScale = 1; // TODO
                    marker.marker.x = Macros.FormatNumber(cfg.x, e.playerState) + offsetX * maxScale;
                    marker.marker.y = Macros.FormatNumber(cfg.y, e.playerState) + offsetY * maxScale;
                    marker.marker.alpha = Macros.FormatNumber(cfg.alpha, e.playerState, 1) / 100.0;
                    // TODO: broken - sometimes icon remains alive for dead vehicles. Touching vehicleTypeIcon kills timeline.
                    //marker.marker.vehicleTypeIcon.scaleX = maxScale;
                    //marker.marker.vehicleTypeIcon.scaleY = maxScale;

                    // TODO: colorize
                    //var color:Number = Macros.FormatNumber(cfg.color, playerState, NaN, true);
                    // colorizeMarkerIcon(icon, color);

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

        /* TODO
        private function colorizeMarkerIcon(icon:MovieClip, color:String)
        {
            if (proxy.isSpeaking)
            {
                icon.transform.colorTransform = new flash.geom.ColorTransform();
            }
            else
            {
                // filters are not applicable to the MovieClip in Scaleform. Only ColorTransform can be used.
                GraphicsUtil.colorize(icon, proxy.formatDynamicColor(proxy.formatStaticColorText(color)),
                    proxy.isDead ? Config.config.consts.VM_COEFF_VMM_DEAD : Config.config.consts.VM_COEFF_VMM);
            }
        }
        */
    }
}
