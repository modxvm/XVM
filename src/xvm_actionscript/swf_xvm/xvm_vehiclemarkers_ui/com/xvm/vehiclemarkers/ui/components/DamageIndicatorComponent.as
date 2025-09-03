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
    import net.wg.gui.battle.views.vehicleMarkers.AnimateExplosion;
    import net.wg.gui.battle.views.vehicleMarkers.HealthBarAnimatedLabel;

    public final class DamageIndicatorComponent extends VehicleMarkerComponentBase implements IVehicleMarkerComponent
    {
        public final function DamageIndicatorComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            marker.addEventListener(XvmVehicleMarkerEvent.UPDATE_STATE, onUpdateState, false, 0, true);
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
            var cfg:CMarkersDamageIndicator = e.cfg.damageIndicator;
            if (cfg.enabled)
            {
                var playerState:VOPlayerState = e.playerState;
                var marker_hitExplosion:AnimateExplosion = marker.hitExplosion;
                var x:Number = Macros.FormatNumber(cfg.x, playerState);
                var y:Number = Macros.FormatNumber(cfg.y, playerState);
                var alpha:Number = Macros.FormatNumber(cfg.alpha, playerState) / 100.0;
                marker_hitExplosion.x = x;
                marker_hitExplosion.y = y;
                marker_hitExplosion.alpha = alpha;
                var marker_criticalHitLabel:HealthBarAnimatedLabel = marker.criticalHitLabel;
                marker_criticalHitLabel.x = x + 14;
                marker_criticalHitLabel.y = y - 14;
                marker_criticalHitLabel.alpha = alpha;
            }
        }

        // PRIVATE

        private function onUpdateState(e:XvmVehicleMarkerEvent):void
        {
            var cfg:CMarkersDamageIndicator = e.cfg.damageIndicator;
            var playerState:VOPlayerState = e.playerState;
            var marker_hitExplosion:AnimateExplosion = marker.hitExplosion;
            var marker_criticalHitLabel:HealthBarAnimatedLabel = marker.criticalHitLabel;
            marker_hitExplosion.visible = cfg.enabled;
            marker_criticalHitLabel.visible = cfg.enabled && cfg.showText;
            if (cfg.enabled)
            {
                marker_hitExplosion.playShowTween();
                if (marker_criticalHitLabel.visible)
                {
                    marker_criticalHitLabel.setLabel(playerState.markerState.criticalHitLabelText, "white");
                }
                marker_hitExplosion.setAnimationType(playerState.markerState.hitExplosionAnimationType);
                if (marker_criticalHitLabel.visible)
                {
                    marker_criticalHitLabel.playShowTween();
                }
            }
        }
    }
}
