package com.xvm.vehiclemarkers.ui.components
{
    import com.xfw.*
    import com.xvm.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import com.greensock.plugins.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;

    internal final class DamageTextAnimation
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
        public final function DamageTextAnimation(cfg:CMarkersDamageText, mc:MovieClip, maxRange:Number)
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

        // PRIVATE

        [Inline]
        private final function emerge():TweenLite
        {
            return TweenLite.from(mc, EMERGE_DURATION, { alpha: 0, ease: Linear.easeNone, cacheAsBitmap: true } );
        }

        [Inline]
        private final function tint():TweenLite
        {
            return TweenLite.from(mc, TINT_DURATION, { tint: "0xFFFFFF", ease: Linear.easeNone, cacheAsBitmap: true } );
        }

        [Inline]
        private final function moveUpward(movementDuration:Number, distanceUpward:Number):TweenLite
        {
            return TweenLite.to(mc, movementDuration, { y: distanceUpward, ease: Linear.easeNone, cacheAsBitmap: true } );
        }

        [Inline]
        private final function fadeOut():TweenLite
        {
            return TweenLite.to(mc, FADEOUT_DURATION, { alpha: 0, ease: Linear.easeNone, cacheAsBitmap: true } );
        }

        [Inline]
        private final function removeMovieClip():void
        {
            if (mc == null)
            {
                return;
            }

            while (mc.numChildren > 0)
            {
                mc.removeChildAt(0);
            }

            if (mc.parent != null)
            {
                mc.parent.removeChild(mc);
            }

            mc = null;
        }
    }
}