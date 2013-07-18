/**
 * Panel control
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Logger;
import com.xvm.Controls.IControl;
import com.xvm.Controls.ControlBase;

class com.xvm.Controls.Panel extends ControlBase
{
    /////////////////////////////////////////////////////////////////
    // CLASS REGISTRATION
    
    private static var CLASS_NAME = "__Packages.com.xvm.Controls.Panel";
    private static var CLASS_LINKED = Object.registerClass(CLASS_NAME, Panel);
    
    /////////////////////////////////////////////////////////////////
    // PUBLIC STATIC
    
    public static function Create(context:MovieClip, name:String, x:Number, y:Number, w:Number, h:Number, color:Number, alpha:Number,
        borderSize:Number, borderColor:Number, borderAlpha:Number):Panel
    {
        return Panel(createInstance(context, CLASS_NAME, name, context.getNextHighestDepth(),
        {
            _x: x,
            _y: y,
            __width: w,
            __height: h,
            _color: color,
            __alpha: alpha,
            borderSize: borderSize,
            borderColor: borderColor,
            borderAlpha: borderAlpha
        }));
    }

    /////////////////////////////////////////////////////////////////
    // PRIVATE VARS

    private var borderSize:Number;
    private var borderColor:Number;
    private var borderAlpha:Number;

    /////////////////////////////////////////////////////////////////
    // OVERRIDES

    // override
    public function draw()
    {
        //Logger.add("Panel.draw()");
        super.draw();

        clear();
        
        // Body
        beginFill(color, alpha);
        moveTo(0, 0);
        lineTo(width, 0);
        lineTo(width, height);
        lineTo(0, height);
        lineTo(0, 0);
        endFill();

        // Border
        lineStyle(borderSize, borderColor, borderAlpha);
        moveTo(0, 0);
        lineTo(width, 0);
        lineTo(width, height);
        lineTo(0, height);
        lineTo(0, 0);
    }
}
