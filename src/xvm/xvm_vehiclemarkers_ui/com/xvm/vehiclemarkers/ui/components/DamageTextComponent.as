/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
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

    public class DamageTextComponent extends VehicleMarkerComponentBase
    {
        public function DamageTextComponent(marker:XvmVehicleMarker)
        {
            super(marker);
            marker.addEventListener(XvmVehicleMarkerEvent.UPDATEHEALTH, showDamage);
        }

        private var damage:MovieClip;

        override protected function init(e:XvmVehicleMarkerEvent):void
        {
            try
            {
                damage = new MovieClip();
                marker.addChild(damage);
                super.init(e);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
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
                var damageFlag:Number = playerState.damageInfo.damageFlag;
                var cfg:CMarkersDamageText = damageFlag == Defines.FROM_PLAYER ? e.cfg.damageTextPlayer : damageFlag == Defines.FROM_SQUAD ? e.cfg.damageTextSquadman : e.cfg.damageText;
                damage.visible = Macros.FormatBoolean(cfg.visible, e.playerState, true);
                if (damage.visible)
                {
                    var text:String = Macros.FormatString(playerState.isBlown ? Locale.get(cfg.blowupMessage) : Locale.get(cfg.damageMessage), playerState);
                    var color:Number = Macros.FormatNumber(cfg.color || "{{c:dmg}}", playerState, 0, true);
                    var alpha:Number = Macros.FormatNumber(cfg.alpha, playerState, 1) / 100.0;

                    // create text field
                    var mc:MovieClip = new MovieClip();
                    damage.addChild(mc);
                    mc.y = Macros.FormatNumber(cfg.y, playerState, -67);

                    var textField:TextField = new TextField();
                    mc.addChild(textField);
                    textField.x = Macros.FormatNumber(cfg.x, playerState, 0);
                    textField.y = 0;
                    textField.width = 200;
                    textField.height = 100;
                    textField.antiAliasType = AntiAliasType.ADVANCED;
                    textField.multiline = true;
                    textField.wordWrap = false;
                    textField.alpha = alpha;
                    textField.defaultTextFormat = new TextFormat(
                        Macros.Format(cfg.font.name, playerState) || "$UniversCondC",
                        Macros.FormatNumber(cfg.font.size, playerState, 18),
                        color,
                        Macros.FormatBoolean(cfg.font.bold, playerState),
                        Macros.FormatBoolean(cfg.font.italic, playerState),
                        null,
                        null,
                        null,
                        Macros.Format(cfg.font.align, playerState));
                    if (cfg.shadow.color == null)
                        cfg.shadow.color = "{{c:dmg}}";
                    textField.filters = Utils.createShadowFiltersFromConfig(cfg.shadow, playerState);
                    textField.x -= (textField.width / 2.0);
                    textField.htmlText = "<textformat leading='-2'>" + text + "</textformat>";

                    new DamageTextAnimation(cfg, mc); // defines and starts
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
    public function DamageTextAnimation(cfg:CMarkersDamageText, mc:MovieClip)
    {
        this.mc = mc;

        var movementDuration:Number = cfg.speed;
        var distanceUpward:Number = mc.y - cfg.maxRange;

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
        mc.removeChildren();
        mc.parent.removeChild(mc);
        mc = null;
    }
}
