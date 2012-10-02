import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.*;
import com.greensock.plugins.*;

class wot.VehicleMarkersManager.components.DamageTextAnimation
{
    // Animates textField and cleans it up.
    
    private var tf:TextField;
    private var timeline:TimelineLite;
    private var cfg:Object
    
    private static var WHITE_FLASH_DURATION:Number = 1;
    
    private var movementDuration:Number; 
    private var distanceUpward:Number;
    // Movement starts after N second of white flash animation progress
    private static var MOVEMENT_TIME_OFFSET:Number = - WHITE_FLASH_DURATION;
    
    private static var OPACITY_DURATION:Number = 0.5;
    // Opacity animates in last N seconds of movement animation
    private static var OPACITY_TIME_OFFSET:Number = -OPACITY_DURATION;
    
    public function DamageTextAnimation(tf:TextField, cfg:Object) 
    {
        this.tf = tf;
        this.cfg = cfg;
        
        timeline = new TimelineLite({onComplete:removeTextField});
        
        whiteFlash();
        moveUpward();
        fadeOut();
    }
    
    private function whiteFlash()
    {
        TweenPlugin.activate([TintPlugin]);
        TweenPlugin.activate([GlowFilterPlugin]);
        timeline.appendMultiple([
            TweenLite.from(tf, WHITE_FLASH_DURATION, { tint:"0xFFFFFF", ease: Linear.easeNone} ),
            TweenLite.from(tf, WHITE_FLASH_DURATION,
            {
                glowFilter: { color:0xFFFFFF, blurX:126, blurY:116, strength:118, alpha:1 },
                ease: Linear.easeNone
            })
        ]);
    }
    
    private function moveUpward()
    {
        movementDuration = cfg.speed; // TODO: alias config val to duration
        distanceUpward = - cfg.maxRange;
        timeline.append(
            new TweenLite(tf, movementDuration, { _y:distanceUpward, ease:Quint.easeIn }),
            MOVEMENT_TIME_OFFSET);
    }
    
    private function fadeOut()
    {
        timeline.append(
            new TweenLite(tf, OPACITY_DURATION, { _alpha:0, ease:Linear.easeNone }),
            OPACITY_TIME_OFFSET);//OPACITY_TIME_OFFSET
    }
    
    private function removeTextField():Void
    {
        tf.removeTextField();
        delete tf;
    }
}