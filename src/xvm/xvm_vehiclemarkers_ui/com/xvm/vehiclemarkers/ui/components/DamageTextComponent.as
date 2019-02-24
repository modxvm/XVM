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

    public class DamageTextComponent extends VehicleMarkerComponentBase
    {
        public function DamageTextComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            marker.addEventListener(XvmVehicleMarkerEvent.UPDATE_HEALTH, showDamage, false, 0, true);
        }

        private var damage:MovieClip;

        override protected function init(e:XvmVehicleMarkerEvent):void
        {
            if (this.initialized)
                return;
            damage = new MovieClip();
            marker.addChild(damage);
            super.init(e);
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

        // PRIVATE

        /**
         * Show floating damage indicator
         */
        private function showDamage(e:XvmVehicleMarkerEvent):void
        {
            try
            {
                var playerState:VOPlayerState = e.playerState;
                if (!playerState.damageInfo || playerState.damageInfo.damageDelta <= 0)
                    return;
                var damageFlag:Number = playerState.damageInfo.damageFlag;
                var cfg:CMarkersDamageText = damageFlag == Defines.FROM_PLAYER ? e.cfg.damageTextPlayer : damageFlag == Defines.FROM_SQUAD ? e.cfg.damageTextSquadman : e.cfg.damageText;
                damage.visible = Macros.FormatBoolean(cfg.enabled, e.playerState, true);
                if (damage.visible)
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
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}

import com.xfw.*
import com.greensock.*;
import com.greensock.easing.*;
import com.greensock.plugins.*;
import com.xvm.types.cfg.*;
import flash.display.*;

class DamageTextAnimation
{
    // Animates textField and cleans it up.

    private var mc:MovieClip;
    private var timeline:TimelineLite;

    private static var EMERGE_DURATION:Number = 0.3;
    private static var TINT_DURATION:Number = 0.4;
    // Opacity animates in last N seconds of movement animation
    private static var FADEOUT_DURATION:Number = 0.5;
    private static var FADEOUT_TIME_OFFSET:Number = - FADEOUT_DURATION;

    /**
     *  Legend:
     *   # : operation in progress
     *   + : operation complete and result is visible
     *
     *              0s    0.5s  1s    1.5s  delay Xs
     *  emerge      ###++ +++++ +++++ +++++ ~ ~ ~ -----
     *  tint        ####
     *  moveUpward  ##### ##### ##### ##### ~ ~ ~ +++++
     *  fadeOut     ----- ----- ----- ----- ~ ~ ~ #####
     */

    TweenPlugin.activate([TintPlugin]);

     /**
      * In case of whiteFlash coding:
      * Tint recolors Glow? Recolors shadowFilter?
      * Make two movieclips?
      * Use GraphicsUtil.createShadowFilter and tween filter?
      */
    public function DamageTextAnimation(cfg:CMarkersDamageText, mc:MovieClip, maxRange:Number)
    {
        this.mc = mc;

        var movementDuration:Number = cfg.speed;
        var distanceUpward:Number = mc.y - maxRange;

        timeline = new TimelineLite({onComplete:removeMovieClip});

        timeline.insert(emerge(), 0);
        timeline.insert(tint(), 0);
        timeline.insert(moveUpward(movementDuration, distanceUpward), 0);
        timeline.append(fadeOut(), FADEOUT_TIME_OFFSET);
    }

    private function emerge():TweenLite
    {
        return TweenLite.from(mc, EMERGE_DURATION, { alpha:0, ease:Linear.easeNone, cacheAsBitmap:true } );
    }

    private function tint():TweenLite
    {
        return TweenLite.from(mc, TINT_DURATION, { tint:"0xFFFFFF", ease: Linear.easeNone, cacheAsBitmap:true } );
    }

    private function moveUpward(movementDuration:Number, distanceUpward:Number):TweenLite
    {
        return TweenLite.to(mc, movementDuration, { y:distanceUpward, ease:Linear.easeNone, cacheAsBitmap:true } );
    }

    private function fadeOut():TweenLite
    {
        return TweenLite.to(mc, FADEOUT_DURATION, { alpha:0, ease:Linear.easeNone, cacheAsBitmap:true } );
    }

    private function removeMovieClip():void
    {
        while (mc.numChildren > 0)
        {
            mc.removeChildAt(0);
        }
        mc.parent.removeChild(mc);
        mc = null;
    }
}
