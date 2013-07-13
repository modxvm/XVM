/**
 * Panel control
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Controls.IControl;
import com.xvm.Controls.ControlBase;

class com.xvm.Controls.Panel extends ControlBase
{
    public static function Create(parent:MovieClip, name:String, x:Number, y:Number, w:Number, h:Number, color:Number, alpha:Number,
        borderSize:Number, borderColor:Number, borderAlpha:Number):Panel
    {
        var mc:MovieClip = ControlBase.Create(parent, name, x, y, w, h, color, alpha);
        return new Panel(mc, borderSize, borderColor, borderAlpha);
    }

    public function Panel(mc:MovieClip, borderSize:Number, borderColor:Number, borderAlpha:Number)
    {
        super(mc);
        mc.lineStyle(borderSize, borderColor, borderAlpha);
        mc.moveTo(0, 0);
        mc.lineTo(mc.width, 0);
        mc.lineTo(mc.width, mc.height);
        mc.lineTo(0, mc.height);
        mc.lineTo(0, 0);
    }
}
