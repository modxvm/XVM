/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.vo.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vehiclemarkers.ui.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import flash.display.*;

    public final class HealthBarComponent extends VehicleMarkerComponentBase implements IVehicleMarkerComponent
    {
        private var healthBar:Sprite = null;
        private var border:Sprite;
        private var fill:Sprite;
        private var damage:MovieClip;

        public final function HealthBarComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            marker.addEventListener(XvmVehicleMarkerEvent.UPDATE_HEALTH, showDamage, false, 0, true);
        }

        override protected function onDispose():void
        {
            if (healthBar)
            {
                var i:int = healthBar.numChildren;
                while (--i > -1)
                {
                    healthBar.removeChildAt(0);
                }
                marker.removeChild(healthBar);
                border = null;
                fill = null;
                damage = null;
                healthBar = null;
            }
            super.onDispose();
        }

        public final function init(e:XvmVehicleMarkerEvent):void
        {
            if (!this.initialized)
            {
                this.initialized = true;
                healthBar = new Sprite();
                marker.addChild(healthBar);
                border = new Sprite();
                healthBar.addChild(border);
                fill = new Sprite();
                healthBar.addChild(fill);
                damage = new MovieClip();
                healthBar.addChild(damage);
            }
        }

        [Inline]
        public final function onExInfo(e:XvmVehicleMarkerEvent):void
        {
            update(e);
        }

        public final function update(e:XvmVehicleMarkerEvent):void
        {
            var cfg:CMarkersHealthBar = e.cfg.healthBar;
            var enabled:Boolean = cfg.enabled;
            healthBar.visible = enabled;
            if (enabled)
            {
                var playerState:VOPlayerState = e.playerState;

                var cfg_border:CMarkersHealthBarBorder = cfg.border;
                var cfg_border_size:Number = cfg_border.size;
                var cfg_width:Number = cfg.width;
                var cfg_height:Number = cfg.height;

                var border_color:Number = Macros.FormatNumber(cfg_border.color, playerState);
                var border_alpha:Number = Macros.FormatNumber(cfg_border.alpha, playerState, 100) / 100.0;
                var border_graphics:Graphics = border.graphics;
                border_graphics.clear();
                border_graphics.beginFill(border_color, border_alpha);
                border_graphics.drawRect(0, 0, cfg_width + cfg_border_size * 2, cfg_height + cfg_border_size * 2);
                border_graphics.endFill();

                var color:Number = Macros.FormatNumber(cfg.color, playerState);
                var lcolor:Number = Macros.FormatNumber(cfg.lcolor, playerState);
                var healthRatio:Number = playerState.curHealth / playerState.maxHealth;
                if (isNaN(healthRatio))
                    healthRatio = 1;
                var fill_alpha:Number = Macros.FormatNumber(cfg.fill.alpha, playerState, 100) / 100.0;
                var fill_graphics:Graphics = fill.graphics;
                fill_graphics.clear();
                fill_graphics.beginFill(GraphicsUtil.colorByRatio(healthRatio, lcolor, color), fill_alpha);
                fill_graphics.drawRect(cfg_border_size, cfg_border_size, cfg_width * Math.min(healthRatio, 1.0), cfg_height);
                fill_graphics.endFill();

                var damage_graphics:Graphics = damage.graphics;
                damage_graphics.clear();
                damage.scaleX = 0;
                damage_graphics.beginFill(0);
                damage_graphics.drawRect(cfg_border_size, cfg_border_size, cfg_width, cfg_height);
                damage_graphics.endFill();

                healthBar.x = cfg.x;
                healthBar.y = cfg.y;
                healthBar.alpha = Macros.FormatNumber(cfg.alpha, playerState, 100) / 100.0;
            }
        }

        // PRIVATE

        /**
         * Show floating damage indicator
         */
        private function showDamage(e:XvmVehicleMarkerEvent):void
        {
            if (healthBar.visible)
            {
                var cfg:CMarkersHealthBar = e.cfg.healthBar;
                var playerState:VOPlayerState = e.playerState;
                TweenLite.killTweensOf(damage);
                var damageInfo:VODamageInfo = playerState.damageInfo;
                if (damageInfo && damageInfo.damageDelta > 0)
                {
                    damage.x = cfg.border.size + cfg.width * (playerState.curHealth / playerState.maxHealth) - 1;
                    damage.scaleX += damageInfo.damageDelta / playerState.maxHealth;
                    var cfg_damage:CMarkersHealthBarDamage = cfg.damage;
                    var color:Number = Macros.FormatNumber(cfg_damage.color, playerState);
                    GraphicsUtil.tint(damage, color);
                    damage.alpha = Macros.FormatNumber(cfg_damage.alpha, playerState, 100) / 100.0;
                    TweenLite.to(damage, cfg_damage.fade, { scaleX: 0, ease: Cubic.easeIn } );
                }
            }
        }
    }
}
