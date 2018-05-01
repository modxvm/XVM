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

    public class DamageIndicatorComponent extends VehicleMarkerComponentBase
    {
        public function DamageIndicatorComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            marker.addEventListener(XvmVehicleMarkerEvent.UPDATE_STATE, onUpdateState, false, 0, true);
        }

        override protected function update(e:XvmVehicleMarkerEvent):void
        {
            try
            {
                super.update(e);
                var cfg:CMarkersDamageIndicator = e.cfg.damageIndicator;
                if (cfg.enabled)
                {
                    marker.hitExplosion.x = Macros.FormatNumber(cfg.x, e.playerState);
                    marker.hitExplosion.y = Macros.FormatNumber(cfg.y, e.playerState);
                    marker.hitExplosion.alpha = Macros.FormatNumber(cfg.alpha, e.playerState) / 100.0;
                    marker.criticalHitLabel.x = marker.hitExplosion.x + 14;
                    marker.criticalHitLabel.y = marker.hitExplosion.y - 14;
                    marker.criticalHitLabel.alpha = marker.hitExplosion.alpha;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

        private function onUpdateState(e:XvmVehicleMarkerEvent):void
        {
            var cfg:CMarkersDamageIndicator = e.cfg.damageIndicator;
            marker.hitExplosion.visible = cfg.enabled;
            marker.criticalHitLabel.visible = cfg.enabled && cfg.showText;
            if (cfg.enabled)
            {
                marker.hitExplosion.playShowTween();
                if (marker.criticalHitLabel.visible)
                {
                    marker.criticalHitLabel.setLabel(e.playerState.markerState.criticalHitLabelText, "white");
                }
                marker.hitExplosion.setAnimationType(e.playerState.markerState.hitExplosionAnimationType);
                if (marker.criticalHitLabel.visible)
                {
                    marker.criticalHitLabel.playShowTween();
                }
            }
        }
    }
}
