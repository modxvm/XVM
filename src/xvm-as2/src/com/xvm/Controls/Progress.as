/**
 * Progress control
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.Controls.IControl;
import com.xvm.Controls.ControlBase;

class com.xvm.Controls.Progress extends ControlBase
{
    public static function Create(parent:MovieClip, name:String):Progress
    {
        var mc:MovieClip = ControlBase.Create(parent, name, 0, -1, parent.width, 2, 0x7FC9FF, 50);
        return new Progress(mc);
    }

    public function Progress(mc:MovieClip)
    {
        super(mc);
        SetPos(0);
    }
    
    public function SetPos(pos:Number)
    {
        mc._xscale = Math.min(pos * 100, 100);
    }
}