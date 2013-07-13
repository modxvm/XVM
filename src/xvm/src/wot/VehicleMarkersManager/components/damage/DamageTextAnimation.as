import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Linear;
//import com.xvm.Logger;

class wot.VehicleMarkersManager.components.damage.DamageTextAnimation
{
    // Animates textField and cleans it up.

    private var tf:TextField;
    private var timeline:TimelineLite;
    private var cfg:Object

    private static var EMERGE_DURATION:Number = 0.3;
    private static var TINT_DURATION:Number = 0.3;
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
     *  tint        ###
     *  moveUpward  ##### ##### ##### ##### ~ ~ ~ +++++
     *  fadeOut     ----- ----- ----- ----- ~ ~ ~ #####
     */

     /**
      * In case of whiteFlash coding:
      * Tint recolors Glow? Recolors shadowFilter?
      * Make two movieclips?
      * Use GraphicsUtil.createShadowFilter and tween filter?
      */

    public function DamageTextAnimation(cfg:Object, tf:TextField)
    {
        this.tf = tf;
        this.cfg = cfg;

        var movementDuration:Number = cfg.speed; // TODO: alias config val to duration?
        var distanceUpward:Number = - cfg.maxRange;

        timeline = new TimelineLite({onComplete:removeTextField});

        timeline.insert(emerge(), 0);
        timeline.insert(tint(), 0);
        timeline.insert(moveUpward(movementDuration, distanceUpward), 0);
        timeline.append(fadeOut(), FADEOUT_TIME_OFFSET);
    }

    private function emerge():TweenLite
    {
        return TweenLite.from(tf, EMERGE_DURATION, { _alpha:0, ease:Linear.easeNone, cacheAsBitmap:true } );
    }

    private function tint():TweenLite
    {
        return TweenLite.from(tf, TINT_DURATION, { tint:"0xFFFFFF", ease: Linear.easeNone, cacheAsBitmap:true } );
    }

    private function moveUpward(movementDuration:Number, distanceUpward:Number):TweenLite
    {
        return TweenLite.to(tf, movementDuration, { _y:distanceUpward, ease:Linear.easeNone, cacheAsBitmap:true } );
    }

    private function fadeOut():TweenLite
    {
        return TweenLite.to(tf, FADEOUT_DURATION, { _alpha:0, ease:Linear.easeNone, cacheAsBitmap:true } );
    }

    private function removeTextField():Void
    {
        tf.removeTextField();
        delete tf;
    }
}