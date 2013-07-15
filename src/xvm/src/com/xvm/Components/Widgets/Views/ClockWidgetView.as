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
        clock = Label.Create(m_panel.mc, "label", 5, 5, 55, 20, Defines.UICOLOR_DEFAULT2, 100, "$TitleFont", 15, "");
        update(new Date());
    }
    
    /////////////////////////////////////////////////////////////////
    // IWidgetView implementation

    public function update(data:Object)
    {
        var now:Date = Date(data);
        var h:Number = now.getHours();
        var m:Number = now.getMinutes();
        var s:Number = now.getSeconds();
        clock.SetText((h < 10 ? "0" : "") + h + ":" + (m < 10 ? "0" : "") + m + ":" + (s < 10? "0" : "") + s);
    }
}
