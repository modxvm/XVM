/**
 * Base Control Class (abstract)
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
class com.xvm.Controls.ControlBase
{
    public static function Create(parent:MovieClip, name:String, x:Number, y:Number, w:Number, h:Number, color:Number, alpha:Number):MovieClip
    {
        var mc:MovieClip = parent.createEmptyMovieClip(name, parent.getNextHighestDepth());

        mc._x = x;
        mc._y = y;

        mc.width = w;
        mc.height = h;

        mc.beginFill(color, alpha);
        mc.moveTo(0, 0);
        mc.lineTo(w, 0);
        mc.lineTo(w, h);
        mc.lineTo(0, h);
        mc.lineTo(0, 0);
        mc.endFill();

	mc.onKeyDown = function() { parent.onKeyDown(); }
	mc.onKeyUp = function() { parent.onKeyUp(); }
	mc.onMouseDown = function() { parent.onMouseDown(); }
	mc.onMouseMove = function() { parent.onMouseMove(); }
	mc.onMouseUp = function() { parent.onMouseUp(); }
	mc.onPress = function() { parent.onPress(); }
	mc.onRelease = function() { parent.onRelease(); }
	mc.onReleaseOutside = function() { parent.onReleaseOutside(); }
	mc.onRollOver = function() { parent.onRollOver(); }
        mc.onRollOut = function()  { parent.onRollOut(); }

        return mc;
    }

    public var mc:MovieClip;

    private var dataProvider:Object;
    public function ControlBase(mc:MovieClip)
    {
        this.mc = mc;
        dataProvider = null;
    }
}