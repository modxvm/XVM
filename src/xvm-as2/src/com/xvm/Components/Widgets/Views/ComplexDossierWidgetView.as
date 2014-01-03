/**
 * Clock Widget (view)
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Defines;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.Utils;
import com.xvm.Controls.Panel;
import com.xvm.Controls.Chart;
import com.xvm.Controls.Grid;
import com.xvm.Controls.Label;
import com.xvm.Controls.Progress;

class com.xvm.Components.Widgets.Views.ComplexDossierWidgetView
{
    private var cfg:Object;
    private var holder:MovieClip;
    private var panel:Panel;
    private var progress:Progress;
    private var chartDay:Chart;
    private var chartWeek:Chart;
    private var chartYear:Chart;
    private var gridStat:Grid;
    private var test:Label;

    public function ComplexDossierWidgetView(cfg:Object, holder:MovieClip)
    {
        this.cfg = cfg;

        var me = this;
        this.holder = holder;
        holder._x = cfg.x;
        holder._y = cfg.y;
        holder._alpha = cfg.alpha;
        holder.onRollOver = function() { holder._alpha = cfg.activeAlpha; }
        holder.onRollOut = function()  { holder._alpha = cfg.alpha; }
        holder.onPress = function()          { me.onPress.apply(me, arguments); }
        holder.onRelease = function()        { me.onRelease.apply(me, arguments); }
        holder.onReleaseOutside = function() { me.onRelease.apply(me, arguments); }
        holder.onMouseMove = function()      { me.onMouseMove.apply(me, arguments); }

        panel = Panel.Create(holder, "panel", 0,   0,   410, 200, 0x000000, 60, 1, 0xCCCCCC, 50);

        progress = Progress.Create(panel.mc, "progress");

        Label.Create(panel.mc, "labelDay",              10,  10,  100, 20,  Defines.UICOLOR_DEFAULT2, 100, "$FieldFont", 13, Locale.get("Day"));
        chartDay = Chart.Create(panel.mc, "chartDay",   10,  30,  100, 40,  0x000000, 60, 0xCCCCCC, 1, 0x008000, 50);

        Label.Create(panel.mc, "labelWeek",             10,  70,  100, 20,  Defines.UICOLOR_DEFAULT2, 100, "$FieldFont", 13, Locale.get("Week"));
        chartWeek = Chart.Create(panel.mc, "chartWeek", 10,  90,  100, 40,  0x000000, 60, 0xCCCCCC, 1, 0x008000, 50);

        Label.Create(panel.mc, "labelYear",             10,  130, 100, 20,  Defines.UICOLOR_DEFAULT2, 100, "$FieldFont", 13, Locale.get("Year"));
        chartYear = Chart.Create(panel.mc, "chartYear", 10,  150, 100, 40,  0x000000, 60, 0xCCCCCC, 1, 0x008000, 50);

        gridStat = Grid.Create(panel.mc, "gridStat",    120, 10,  280, 180, 0x000000, 60, 1, 0xCCCCCC, 50,
            [
                { w:55, title:"",      align:"left" },
                { w:45, title:"Today", align:"right" },
                { w:45, title:"Y day", align:"right" },
                { w:45, title:"Week",  align:"right" },
                { w:45, title:"Month", align:"right" },
                { w:45, title:"Year",  align:"right" }
            ], 20, 8);

        //test = Label.Create(gridStat.mc, "test",        10,  10,  150, 160, Defines.UICOLOR_DEFAULT, 100, "$FieldFont", 10);
        //test.SetText("ABCDEFGHIJKLMNOPQRSTUVWXYZ\nABCDEFGHIJKLMNOPQRSTUVWXYZ\nABCDEFGHIJKLMNOPQRSTUVWXYZ");
    }

    public function update(data:Object)
    {
        //Logger.addObject(data);
        //test.SetText(com.xvm.JSONx.stringify(data));
    }

    public function updateIdle(pos:Number)
    {
        progress.SetPos(pos);
    }

    private var mouseDown:Boolean = false;
    private var mouseX:Number;
    private var mouseY:Number;

    private function onPress(mouseIndex, button)
    {
        //Logger.addObject("onPress: " + com.xvm.JSONx.stringify(arguments));
        mouseDown = true;
        mouseX = _root._xmouse;
        mouseY = _root._ymouse;
    }

    private function onRelease(mouseIndex, button)
    {
        //Logger.addObject("onRelease: " + com.xvm.JSONx.stringify(arguments));
        mouseDown = false;
    }

    private function onMouseMove()
    {
        if (mouseDown && (mouseX != _root._xmouse || mouseY != _root._ymouse))
        {
            //Logger.addObject("onMouseMove: " + _root._xmouse + ", " + _root._ymouse + "   "  + mouseX + ", " + mouseY);
            holder._x += _root._xmouse - mouseX;
            holder._y += _root._ymouse - mouseY;
            mouseX = _root._xmouse;
            mouseY = _root._ymouse;
        }
    }
}
