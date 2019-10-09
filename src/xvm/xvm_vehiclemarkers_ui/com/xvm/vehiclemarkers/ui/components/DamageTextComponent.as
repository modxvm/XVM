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
    import flash.display.*;
    import flash.text.*;
    import scaleform.gfx.*;

    public final class DamageTextComponent extends VehicleMarkerComponentBase implements IVehicleMarkerComponent
    {
        private var damage:MovieClip;

        public final function DamageTextComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            marker.addEventListener(XvmVehicleMarkerEvent.UPDATE_HEALTH, showDamage, false, 0, true);
        }

        override protected function onDispose():void
        {
            if (damage)
            {
                marker.removeChild(damage);
                damage = null;
            }
            super.onDispose();
        }

        public final function init(e:XvmVehicleMarkerEvent):void
        {
            if (!this.initialized)
            {
                this.initialized = true;
                damage = new MovieClip();
                marker.addChild(damage);
            }
        }

        [Inline]
        public final function onExInfo(e:XvmVehicleMarkerEvent):void
        {
            // stub
        }

        [Inline]
        public final function update(e:XvmVehicleMarkerEvent):void
        {
            // stub
        }

        // PRIVATE

        /**
         * Show floating damage indicator
         */
        private function showDamage(e:XvmVehicleMarkerEvent):void
        {
            var e_cfg:CMarkers4 = e.cfg;
            var playerState:VOPlayerState = e.playerState;
            var damageInfo:VODamageInfo = playerState.damageInfo;
            if (damageInfo && damageInfo.damageDelta > 0)
            {
                var damageFlag:Number = damageInfo.damageFlag;
                var cfg:CMarkersDamageText = damageFlag == Defines.FROM_PLAYER ? e_cfg.damageTextPlayer
                    : damageFlag == Defines.FROM_SQUAD ? e_cfg.damageTextSquadman
                    : e_cfg.damageText;
                var visible:Boolean = Macros.FormatBoolean(cfg.enabled, playerState, true);
                damage.visible = visible;
                if (visible)
                {
                    var text:String = Macros.FormatString(playerState.isBlown ? Locale.get(cfg.blowupMessage) : Locale.get(cfg.damageMessage), playerState);
                    var alpha:Number = Macros.FormatNumber(cfg.alpha, playerState, 1) / 100.0;

                    // create text field
                    var mc:MovieClip = new MovieClip();
                    damage.addChild(mc);
                    mc.y = Macros.FormatNumber(cfg.y, playerState, -67);

                    var textField:TextField = new TextField();
                    mc.addChild(textField);
                    textField.mouseEnabled = false;
                    textField.selectable = false;
                    TextFieldEx.setNoTranslate(textField, true);
                    textField.antiAliasType = AntiAliasType.ADVANCED;
                    textField.x = Macros.FormatNumber(cfg.x, playerState, 0);
                    textField.y = 0;
                    textField.width = 200;
                    textField.height = 100;
                    textField.multiline = true;
                    textField.wordWrap = false;
                    textField.alpha = alpha;
                    if (!cfg.textFormat)
                    {
                        cfg.textFormat = CTextFormat.GetDefaultConfigForMarkers();
                        cfg.textFormat.color = "{{c:dmg}}";
                    }
                    if (cfg.textFormat.color == null)
                    {
                        cfg.textFormat.color = "{{c:dmg}}";
                    }
                    if (cfg.textFormat.leading == null)
                    {
                        cfg.textFormat.leading = -2;
                    }
                    textField.defaultTextFormat = Utils.createTextFormatFromConfig(cfg.textFormat, playerState);
                    textField.filters = Utils.createShadowFiltersFromConfig(cfg.shadow, playerState);
                    textField.x -= (textField.width / 2.0);
                    textField.htmlText = text;

                    var maxRange:Number = Macros.FormatNumber(cfg.maxRange, playerState, 40);
                    new DamageTextAnimation(cfg, mc, maxRange); // defines and starts
                }
            }
        }
    }
}

