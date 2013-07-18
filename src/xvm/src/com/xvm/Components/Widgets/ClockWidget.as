/**
 * Clock Widget
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Defines;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.Components.Widgets.BaseWidget;
import com.xvm.Components.Widgets.Views.ClockWidgetView;

class com.xvm.Components.Widgets.ClockWidget extends BaseWidget
{
    /////////////////////////////////////////////////////////////////
    // CONSTANTS
    
    public static var WIDGET_TITLE = Locale.get("Clock");
    public static var WIDGET_NAME = Locale.get("Clock");
    public static var WIDGET_TYPE = "clock";
    
    public static function get DEFAULT_SETTINGS()
    {
        return {
            id: (new Date()).getTime(),
            name: WIDGET_NAME,
            type: WIDGET_TYPE,
            format: "H:N:S",
            modes: Defines.WIDGET_MODE_1 | Defines.WIDGET_MODE_2,
            x: 0,
            y: 20,
            width: 30,
            height: 30,
            alpha: 100,
            bgAlpha: 60,
            pinned: false
        };
    }
    
    /////////////////////////////////////////////////////////////////
    // PRIVATE

    var m_timer:Number;
    
    /////////////////////////////////////////////////////////////////
    // IWidget implementation

    // override
    public function create(holder:MovieClip, settings:Object, playerName:String)
    {
        //Logger.addObject(settings, "[CLOCK] create");
        super.create(holder, settings, playerName);
        
        _view = new ClockWidgetView(mc, settings);
        
        var me = this;
        m_timer = _global.setInterval(function() { me.onTimer.call(me) }, 100);
    }

    // override
    public function remove()
    {
        //Logger.addObject(settings, "[CLOCK] remove");
        _global.clearInterval(m_timer);
        super.remove();
    }

    /////////////////////////////////////////////////////////////////
    // PRIVATE

    private var _last_sec:Number;
    private function onTimer()
    {
        var now:Date = new Date();
        var s = now.getSeconds();
        if (_last_sec == s)
            return;
        _last_sec = s;
        view.update(now);
    }
}
