/**
 * Switcher Widget
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Defines;
import com.xvm.Locale;
import com.xvm.Components.Widgets.BaseWidget;
import com.xvm.Components.Widgets.Views.SwitcherWidgetView

class com.xvm.Components.Widgets.SwitcherWidget extends BaseWidget
{
    /////////////////////////////////////////////////////////////////
    // CONSTANTS
    
    public static var WIDGET_TITLE = Locale.get("Switcher");
    public static var WIDGET_NAME = Locale.get("Switcher");
    public static var WIDGET_TYPE = "switcher";
    
    public static function get DEFAULT_SETTINGS()
    {
        return {
            id: (new Date()).getTime(),
            name: WIDGET_NAME,
            type: WIDGET_TYPE,
            label: "|<img src='../maps/icons/buttons/tuning.png'>|",
            modes: Defines.WIDGET_MODES_ALL,
            x: 0,
            y: 20,
            width: 20,
            height: 20,
            color: Defines.UICOLOR_DEFAULT2,
            alpha: 100,
            bgColor: 0x000000,
            bgAlpha: 60,
            pinned: false
        };
    }
    
    /////////////////////////////////////////////////////////////////
    // IWidget implementation

    // override
    public function create(holder:MovieClip, settings:Object, playerName:String)
    {
        super.create(holder, settings, playerName);
        _view = new SwitcherWidgetView(mc, settings);
    }

    /////////////////////////////////////////////////////////////////
    // PRIVATE

}
