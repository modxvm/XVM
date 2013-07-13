/**
 * Grid control
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Defines;
import com.xvm.Locale;
import com.xvm.Controls.IControl;
import com.xvm.Controls.ControlBase;
import com.xvm.Controls.Label;

class com.xvm.Controls.Grid extends ControlBase
{
    public static function Create(parent:MovieClip, name:String, x:Number, y:Number, w:Number, h:Number, color:Number, alpha:Number,
        gridSize:Number, gridColor:Number, gridAlpha:Number, columns:Array, rowHeight:Number, rowCount:Number):Grid
    {
        var mc:MovieClip = ControlBase.Create(parent, name, x, y, w, h, color, alpha);
        return new Grid(mc, gridSize, gridColor, gridAlpha, columns, rowHeight, rowCount);
    }

    private var cells:Array;
    private var grid_mc:MovieClip;
    
    public function Grid(mc:MovieClip, gridSize:Number, gridColor:Number, gridAlpha:Number, columns:Array, rowHeight:Number, rowCount:Number)
    {
        super(mc);
        
        var cells_mc:MovieClip = mc.createEmptyMovieClip("cells", 0);
        grid_mc = mc.createEmptyMovieClip("grid", 1);

        DrawGrid(gridSize, gridColor, gridAlpha, columns, rowHeight, rowCount);
        DrawHeaders(columns, rowHeight);
        CreateCells(cells_mc, columns, rowHeight, rowCount);
    }

    private function DrawGrid(gridSize:Number, gridColor:Number, gridAlpha:Number, columns:Array, rowHeight:Number, rowCount:Number)
    {
        grid_mc.lineStyle(gridSize, gridColor, gridAlpha);
        grid_mc.moveTo(0, 0);
        grid_mc.lineTo(mc.width, 0);
        grid_mc.lineTo(mc.width, mc.height);
        grid_mc.lineTo(0, mc.height);
        grid_mc.lineTo(0, 0);

        for (var i:Number = 1, x:Number = columns[0].w; i < columns.length; x += columns[i++].w)
        {
            for (var y:Number = 0; y < mc.height; y += 3)
            {
                grid_mc.moveTo(x, y);
                grid_mc.lineTo(x, y + 1);
            }
        }

        for (var y:Number = rowHeight, i:Number = 0; y < mc.height, i < rowCount; y += rowHeight, ++i)
        {
            for (var x:Number = 0; x < mc.width; x += 3)
            {
                grid_mc.moveTo(x, y);
                grid_mc.lineTo(x + 1, y);
            }
        }
    }

    private function DrawHeaders(columns:Array, rowHeight:Number)
    {
        for (var i:Number = 0, x:Number = 0; i < columns.length; x += columns[i++].w)
        {
            var lbl:Label = Label.Create(grid_mc, "header" + i, x, 0, columns[i].w, rowHeight, Defines.UICOLOR_DEFAULT2, 100, "$FieldFont", 13,
                "<b>" + Locale.get(columns[i].title) + "</b>");
            lbl.TextField.multiline = false;
            lbl.TextField.wordWrap = false;
            lbl.TextField.autoSize = "center";
        }
    }

    private function CreateCells(mc:MovieClip, columns:Array, rowHeight:Number, rowCount:Number)
    {
        cells = [];
        for (var i:Number = 0; i < rowCount; ++i)
        {
            var row:Array = [];
            for (var j:Number = 0, x:Number = 0; j < columns.length; x += columns[j++].w)
            {
                var lbl:Label = Label.Create(mc, "cell_" + i + "_" + j, x, (i + 1) * rowHeight, columns[j].w, rowHeight, Defines.UICOLOR_DEFAULT, 100, "$FieldFont", 13, i + "," + j);
                lbl.TextField.multiline = false;
                lbl.TextField.wordWrap = false;
                lbl.TextField.autoSize = columns[j].align;
                row.push(lbl);
            }
            cells.push(row);
        }
    }
}
