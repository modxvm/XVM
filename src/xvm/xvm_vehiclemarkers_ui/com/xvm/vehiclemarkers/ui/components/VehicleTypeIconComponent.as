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
    import net.wg.gui.battle.views.vehicleMarkers.*;

    public class VehicleTypeIconComponent extends VehicleMarkerComponentBase
    {
        // Fix markers centering
        private static const MARKER_CENTER_OFFSET_X:Number = -9.5;
        private static const MARKER_CENTER_OFFSET_Y:Object = {
            "LT": -23.5,
            "MT": -24.5,
            "HT": -29.5,
            "TD": -20.5,
            "SPG": -20.5,
            "dynamic": -22.5
        }

        private var showSpeaker:Boolean = false;

        public function VehicleTypeIconComponent(marker:XvmVehicleMarker)
        {
            super(marker);
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
                    marker.marker.x = Macros.FormatNumber(cfg.x, e.playerState);
                    marker.marker.y = Macros.FormatNumber(cfg.y, e.playerState);
                    marker.marker.alpha = Macros.FormatNumber(cfg.alpha, e.playerState, 1) / 100.0;

                    var offsetX:Number = Macros.FormatNumber(cfg.offsetX, e.playerState);
                    var offsetY:Number = Macros.FormatNumber(cfg.offsetY, e.playerState);
                    var maxScale:Number = Macros.FormatNumber(cfg.maxScale, e.playerState) / 100.0;

                    var x:Number = (offsetX + MARKER_CENTER_OFFSET_X) * maxScale;
                    var y:Number = (offsetY + MARKER_CENTER_OFFSET_Y[e.playerState.vehicleData.vtype]) * maxScale;
                    marker.marker.vehicleTypeIcon.x = x;
                    marker.marker.vehicleTypeIcon.y = y;
                    marker.marker.vehicleTypeIcon.scaleX = marker.marker.vehicleTypeIcon.scaleY = maxScale;

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
