/**
 * Switcher Widget (view)
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
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
import com.xvm.Components.Widgets.SwitcherWidget;
import com.xvm.Components.Widgets.Views.BaseWidgetView;
import com.xvm.Components.Widgets.WidgetsEventTypes;

class com.xvm.Components.Widgets.Views.SwitcherWidgetView extends BaseWidgetView
{
    /////////////////////////////////////////////////////////////////
    // PRIVATE

    private var label:Label;

    /////////////////////////////////////////////////////////////////
    // .ctor()

    public function SwitcherWidgetView(mc:MovieClip, settings:Object)
    {
        super(mc, settings, SwitcherWidget.DEFAULT_SETTINGS);
        
        label = Label.Create(panel, "label", 2, 2, 0, 0, {
            color: Defines.UICOLOR_DEFAULT2,
            alpha: 100,
            fontName: "$TitleFont",
            fontSize: 15,
            multiline: false,
            text: m_settings.label
        });
        
        label.addEventListener(WidgetsEventTypes.INITIALIZED, this, onInitialized);
        update(new Date());
    }
    
    /////////////////////////////////////////////////////////////////
    // IWidgetView implementation

    /////////////////////////////////////////////////////////////////
    // PRIVATE

    private function onInitialized(data:Object)
    {
        var sz:Point = label.getSize();
        panel.setSize(sz.x + 4, sz.y + 4);
    }
}
