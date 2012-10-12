import flash.filters.DropShadowFilter;
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Linear;
import wot.utils.Evaluator;
import wot.utils.Logger;
import wot.VehicleMarkersManager.ErrorHandler;

class wot.VehicleMarkersManager.EffectsProvider
{
    private static var dummy = Logger.dummy; // avoid import warning
    private function trace(str:String):Void
    {
        Logger.add("[EffectsProvider]> " + str);
    }

    // Animates textField and cleans it up.
    private var target:TextField;
    private var _tl:TimelineLite;

    public function DamageTextAnimation(effects:String, textField:TextField)
    {
        target = textField;
        _tl = new TimelineLite( { onComplete:removeTextField } );

        //trace(effects);
        try
        {
            Evaluator.evaluate(effects, this);
        }
        catch (ex)
        {
                var head = ex.at > 0 ? ex.text.substring(0, ex.at) : "";
                head = head.split("\r").join("").split("\n").join("");
                while (head.indexOf("  ") != -1)
                    head = head.split("  ").join(" ");
                head = head.substr(Math.max(0, ex.at - 25), 25);

                var tail = (ex.at + 1 < ex.text.length) ? ex.text.substring(ex.at + 1, ex.text.length) : "";
                tail = tail.split("\r").join("").split("\n").join("");
                while (tail.indexOf("  ") != -1)
                    tail = tail.split("  ").join(" ");

                var pfx:String = "[" + ex.at + "] " + ex.name + ": " + ex.message + ": ";
                var text:String = head + ">>>" + ex.text.charAt(ex.at) + "<<<" + tail;
                Logger.add(pfx + String(text).substr(0, 50));

                var htmlText:String =
                    head + "<font color='#FFFFFF'><b>&gt;&gt;&gt;" + ex.text.charAt(ex.at) + "&lt;&lt;&lt;</b></font>" + tail;
                ErrorHandler.setText(pfx + String(htmlText).substr(0, 100));
        }
    }

    private function removeTextField():Void
    {
        target.removeTextField();
        delete target;
    }

    // provider for evaluator
    // http://www.greensock.com/as/docs/tween/

    // Timeline

    public function set(tween:TweenLite)
    {
        //trace("set:" + arguments.join(", "));
        _tl.insert(tween, 0);
    }

    public function insert(tween:TweenLite, time)
    {
        //trace("insert:" + arguments.join(", "));
        _tl.insert(tween, time);
    }

    public function append(tween:TweenLite, time)
    {
        //trace("append:" + arguments.join(", "));
        _tl.append(tween, time);
    }

    // Tween

    public function from(duration:Number, vars:Object):TweenLite
    {
        //trace("from:" + com.xvm.JSON.stringify(arguments));
        return TweenLite.from(target, duration, vars);
    }

    public function to(duration:Number, vars:Object):TweenLite
    {
        //trace("to:" + com.xvm.JSON.stringify(arguments));
        return TweenLite.to(target, duration, vars);
    }

    public function alpha(value:Number):TweenLite
    {
        //trace("alpha:" + com.xvm.JSON.stringify(arguments));
        var target = this.target;
        return TweenLite.to(target, 0.01, { _alpha: value, ease:Linear.easeNone } );
    }

    // http://www.greensock.com/as/docs/tween/com/greensock/plugins/DropShadowFilterPlugin.html
    public function shadow(value:Object):TweenLite
    {
        //trace("shadow:" + com.xvm.JSON.stringify(arguments));
        var target = this.target;
        return TweenLite.to(target, 0.01, { onInit: function() {
            target.filters = [ new DropShadowFilter(
                value.distance || 0,
                value.angle || 0,
                value.color || 0x000000,
                value.alpha || 1,
                value.blurX || 3,
                value.blurY || 3,
                value.strength || 1,
                value.quality || 3,
                value.inner || false,
                value.knockout || false,
                value.hideObject || false) ];
        }, ease:Linear.easeNone });
        //return TweenLite.from(target, 0.01, { dropShadowFilter:value } ); // why not works?
    }

    public function fadeIn(duration:Number):TweenLite
    {
        //trace("fadeIn:" + com.xvm.JSON.stringify(arguments));
        return TweenLite.from(target, duration, { _alpha:0, ease:Linear.easeNone } );
    }

    public function fadeOut(duration:Number):TweenLite
    {
        //trace("fadeOut:" + com.xvm.JSON.stringify(arguments));
        return TweenLite.to(target, duration, { _alpha:0, ease:Linear.easeNone } );
    }

    public function tint(duration:Number, color:String):TweenLite
    {
        //trace("tint:" + com.xvm.JSON.stringify(arguments));
        return TweenLite.from(target, duration, { tint:color, ease: Linear.easeNone } );
    }

    public function move(duration:Number, distance:Number, direction:String):TweenLite
    {
        //trace("move:" + com.xvm.JSON.stringify(arguments));
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
        return TweenLite.to(target, duration, { _x:x, _y:y, ease:Linear.easeNone } );
    }
}
