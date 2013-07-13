/**
 * Chart control
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Controls.IControl;
import com.xvm.Controls.ControlBase;

class com.xvm.Controls.Chart extends ControlBase
{
    public static function Create(parent:MovieClip, name:String, x:Number, y:Number, w:Number, h:Number, color:Number, alpha:Number,
        borderColor:Number, gridSize:Number, gridColor:Number, gridAlpha:Number):Chart
    {
        var mc:MovieClip = ControlBase.Create(parent, name, x, y, w, h, color, alpha);
        return new Chart(mc, borderColor, gridSize, gridColor, gridAlpha);
    }

    private var chart_mc:MovieClip;
    private var grid_mc:MovieClip;
    
    public function Chart(mc:MovieClip, borderColor:Number, gridSize:Number, gridColor:Number, gridAlpha:Number)
    {
        super(mc);
        
        chart_mc = mc.createEmptyMovieClip("chart", 0);
        grid_mc = mc.createEmptyMovieClip("grid", 1);
        
        DrawGrid(borderColor, gridSize, gridColor, gridAlpha);
    }
    
    private function DrawGrid(borderColor:Number, gridSize:Number, gridColor:Number, gridAlpha:Number)
    {
        grid_mc.lineStyle(gridSize, borderColor, gridAlpha);
        grid_mc.moveTo(0, 0);
        grid_mc.lineTo(mc.width, 0);
        grid_mc.lineTo(mc.width, mc.height);
        grid_mc.lineTo(0, mc.height);
        grid_mc.lineTo(0, 0);

        grid_mc.lineStyle(gridSize, gridColor, gridAlpha);

        // dotted lines
        for (var x:Number = mc.width - 20; x > 0; x -= 20)
        {
            for (var y:Number = 0; y < mc.height; y += 3)
            {
                grid_mc.moveTo(x, y);
                grid_mc.lineTo(x, y + 1);
            }
        }

        for (var y:Number = mc.height - 10; y > 0; y -= 10)
        {
            for (var x:Number = 0; x < mc.width; x += 5)
            {
                grid_mc.moveTo(x, y);
                grid_mc.lineTo(x + 1, y);
            }
        }
    }
}