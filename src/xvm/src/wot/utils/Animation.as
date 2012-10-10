/**
 * ...
 * @author Maxim Schedriviy
 */
import com.greensock.TweenLite;
import com.greensock.TimelineLite;
import com.greensock.easing.Linear;
import wot.utils.Logger;
import wot.utils.IEvaluatorProvider;
import wot.utils.Evaluator;
import wot.VehicleMarkersManager.ErrorHandler;

class wot.utils.Animation implements IEvaluatorProvider
{
    private function trace(str:String):Void
    {
        //Logger.add("[Animation]> " + str);
    }

    /**
     * IEvaluatorProvider implementation
     */
    public function get functions():Array
    {
        return [
            // TimelineLite
            "insert",
            "append",
            
            // TweenLite
            "fadeIn",
            "fadeOut",
            "tint",
            "move"
        ];
    }

    private var timeline:TimelineLite;
    private var target:Object;

    public function Animation(timeline:TimelineLite, target:Object)
    {
        this.timeline = timeline;
        this.target = target;
    }

    public function evaluate(animation:String, cfg: Object)
    {
        trace(animation);
        try
        {
            timeline.insert(fadeIn(0.3),0)
            //timeline.insert(tint(0.7, '0xFFFFFF'), 0)
            timeline.insert(move(cfg.speed, cfg.maxRange, 'up'), 0)
            timeline.append(fadeOut(0.5), -0.5)

//            var evaluator:Evaluator = new Evaluator(this);
//            var result = evaluator.evaluate(animation);
//            trace("result=" + result);
        }
        catch (e:Error)
        {
          ErrorHandler.setText(e.message);
        }
    }

    private function insert(tween:TweenLite, time)
    {
        trace("insert:" + arguments.join(", "));
        timeline.insert(tween, time);
    }
    
    private function append(tween:TweenLite, time)
    {
        trace("append:" + arguments.join(", "));
        timeline.append(tween, time);
    }
    
    private function fadeIn(duration:Number):TweenLite
    {
        trace("fadeIn:" + arguments.join(", "));
        return TweenLite.from(target, duration, { _alpha:0, ease:Linear.easeNone, cacheAsBitmap:true } );
    }

    private function fadeOut(duration:Number):TweenLite
    {
        trace("fadeOut:" + arguments.join(", "));
        return TweenLite.to(target, duration, { _alpha:0, ease:Linear.easeNone, cacheAsBitmap:true } );
    }

    private function tint(duration:Number, color:String):TweenLite
    {
        trace("tint:" + arguments.join(", "));
        return TweenLite.from(target, duration, { tint:color, ease: Linear.easeNone, cacheAsBitmap:true } );
    }

    private function move(duration:Number, distance:Number, direction:String):TweenLite
    {
        trace("move:" + arguments.join(", "));
        var x = target._x;
        var y = target._y;
        switch (direction.toLowerCase())
        {
            case "left":
                x -= distance;
                break;
            case "right":
                x += distance;
                break;
            case "down":
                y += distance;
                break;
            case "up":
            default:
                y -= distance;
                break;
        }
        return TweenLite.to(target, duration, { _x:x, _y:y, ease:Linear.easeNone, cacheAsBitmap:true } );
    }
}
