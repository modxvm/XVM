/**
 * Clock Widget (view)
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
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

    public function ClockWidgetView(mc:MovieClip, settings:Object, defaults:Object)
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
        recalculateSize(formatDate(Date(2000)));
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

    private var _sizeTester:TextField;
    private function recalculateSize(def:String)
    {
        if (!_sizeTester)
        {
            _sizeTester = _root.createTextField("__xvm_clock_widget_sizeTester", _root.getNextHighestDepth(), 0, 0, 1024, 768);
            _sizeTester.autoSize = false;
            _sizeTester.html = true;
            _sizeTester._visible = false;
            _sizeTester.setNewTextFormat(clock.textField.getNewTextFormat());
        }
        
        _sizeTester.htmlText = "<span class='tf'><font size='" + clock.fontSize + "'>" + def + "</font></span>";
        var lineMetrics = _sizeTester.getLineMetrics(0);
        var w = lineMetrics.width + 4 + 4;
        var h = lineMetrics.height + 4 + 4;
        panel.setSize(w, h);
        //clock.setSize(w, h);
        clock._x = w / 2;
        clock._y = h / 2;
    }
}
