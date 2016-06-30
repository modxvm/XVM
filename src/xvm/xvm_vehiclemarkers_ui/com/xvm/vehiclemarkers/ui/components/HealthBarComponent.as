/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.vo.VOPlayerState;
    import com.xvm.types.cfg.CMarkersHealthBar;
    import com.xvm.vehiclemarkers.ui.*;
    import flash.display.*;

    public class HealthBarComponent extends VehicleMarkerComponentBase
    {
        public function HealthBarComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            marker.addEventListener(XvmVehicleMarkerEvent.UPDATEHEALTH, showDamage);
        }

        private var healthBar:Sprite;
        private var border:Sprite;
        private var fill:Sprite;
        private var damage:MovieClip;

        override protected function init(e:XvmVehicleMarkerEvent):void
        {
            healthBar = new Sprite();
            marker.addChild(healthBar);
            border = new Sprite();
            healthBar.addChild(border);
            fill = new Sprite();
            healthBar.addChild(fill);
            damage = new MovieClip();
            healthBar.addChild(damage);
            super.init(e);
        }

        /**
         * Show floating damage indicator
         * @param	delta absolute damage
         * @param	flag  damage source: 0 - "FROM_UNKNOWN", 1 - "FROM_ALLY", 2 - "FROM_ENEMY", 3 - "FROM_SQUAD", 4 - "FROM_PLAYER"
         * @param	damageType damage kind: "shot", "fire", "ramming", "world_collision", "death_zone", "drowning"
         */
        public function showDamage(e:XvmVehicleMarkerEvent):void
        {
            //var cfg = state_cfg.healthBar;
            ////Flow bar animation
            //TweenLite.killTweensOf(damage);
            //damage._x = cfg.border.size + cfg.width * (curHealth / maxHealth) - 1;
            //damage._xscale = damage._xscale + 100 * (delta / maxHealth);
            //GraphicsUtil.setColor(damage, proxy.formatDynamicColor(cfg.damage.color, delta, flag, damageType));
            //damage._alpha = proxy.formatDynamicAlpha(cfg.damage.alpha);
            //TweenLite.to(damage, cfg.damage.fade, {_xscale: 0, ease: Cubic.easeIn });
        }

        override protected function update(e:XvmVehicleMarkerEvent):void
        {
            super.update(e);
            var cfg:CMarkersHealthBar = e.cfg.healthBar;
            healthBar.visible = cfg.visible;
            if (cfg.visible)
            {
                var playerState:VOPlayerState = e.playerState;

                border.graphics.clear();
                border.graphics.beginFill(
                    Macros.FormatNumber(cfg.border.color, playerState, 0, true),
                    Macros.FormatNumber(cfg.border.alpha, playerState, 100) / 100.0);
                border.graphics.drawRect(0, 0, cfg.width + cfg.border.size * 2, cfg.height + cfg.border.size * 2);
                border.graphics.endFill();

                var color:Number = Macros.FormatNumber(cfg.color, playerState, 0, true);
                var lcolor:Number = Macros.FormatNumber(cfg.lcolor, playerState, color, true);
                var healthRatio:Number = playerState.curHealth / playerState.maxHealth;
                fill.graphics.clear();
                fill.graphics.beginFill(
                    GraphicsUtil.colorByRatio(healthRatio, lcolor, color),
                    Macros.FormatNumber(cfg.fill.alpha, playerState) / 100.0);
                fill.graphics.drawRect(cfg.border.size, cfg.border.size, cfg.width * Math.min(healthRatio, 1.0), cfg.height);
                fill.graphics.endFill();

                damage.graphics.clear();
                damage._xscale = 0;
                damage.graphics.beginFill(
                    Macros.FormatNumber(cfg.damage.color, playerState, 0, true),
                    Macros.FormatNumber(cfg.damage.alpha, playerState) / 100.0);
                damage.graphics.drawRect(cfg.border.size, cfg.border.size, cfg.width, cfg.height);
                damage.graphics.endFill();

                healthBar.x = cfg.x;
                healthBar.y = cfg.y;
                healthBar.alpha = Macros.FormatNumber(cfg.alpha, playerState) / 100.0;
            }
        }

        // PRIVATE

    }
}
