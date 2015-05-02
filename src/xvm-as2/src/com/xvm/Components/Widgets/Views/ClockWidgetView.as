/**
 * Clock Widget (view)
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import flash.geom.Point;
import com.xvm.Defines;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.Strings;
import com.xvm.Utils;
import com.xvm.Controls.Panel;
import com.xvm.Controls.Chart;
import com.xvm.Controls.Grid;
import com.xvm.Controls.Label;
import com.xvm.Controls.Progress;
import com.xvm.Components.Widgets.ClockWidget;
import com.xvm.Components.Widgets.Views.BaseWidgetView;

class com.xvm.Components.Widgets.Views.ClockWidgetView extends BaseWidgetView
{
    /////////////////////////////////////////////////////////////////
    // PRIVATE

    private var clock:Label;

    /////////////////////////////////////////////////////////////////
    // .ctor()

    public function ClockWidgetView(mc:MovieClip, settings:Object)
    {
        super(mc, settings, ClockWidget.DEFAULT_SETTINGS);
        
        clock = Label.Create(panel, "label", 2, 2, 0, 0, {
            color: Defines.UICOLOR_DEFAULT2,
            alpha: 100,
            fontName: "$TitleFont",
            fontSize: 15,
            multiline: false,
            align: "center",
            valign: "center"
        });
        
        update(new Date());
    }
    
    /////////////////////////////////////////////////////////////////
    // IWidgetView implementation

    public function update(data:Object)
    {
        super.update(data);
        if (!clock.textField)
            return;
        clock.text = formatDate(Date(data));
        //Logger.addObject(clock.textField);

        // recalculate size
        var sz:Point = clock.getSize(formatDate(Date(2000)));
        sz.x += 4;
        sz.y += 4;
        panel.setSize(sz.x, sz.y);
        //clock.setSize(sz.x, sz.y);
        clock._x = sz.x / 2;
        clock._y = sz.y / 2;
    }

    /////////////////////////////////////////////////////////////////
    // PRIVATE

    private function formatDate(date:Date):String
    {
        var res:String = m_settings.format;
        res = res.split("Y").join((date.getYear() + 1900).toString());
        res = res.split("M").join(Strings.padLeft(date.getMonth().toString(), 2, "0"));
        res = res.split("D").join(Strings.padLeft(date.getDay().toString(), 2, "0"));
        res = res.split("H").join(Strings.padLeft(date.getHours().toString(), 2, "0"));
        res = res.split("N").join(Strings.padLeft(date.getMinutes().toString(), 2, "0"));
        res = res.split("S").join(Strings.padLeft(date.getSeconds().toString(), 2, "0"));
        return res;
    }
}
