/**
 * Widgets Factory Class
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.Comm;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Logger;
import com.xvm.Strings;
import com.xvm.VehicleInfo;
import com.xvm.Components.Widgets.IWidget;
import com.xvm.Components.Widgets.BaseWidget;

class com.xvm.Components.Widgets.WidgetsFactory
{
    /////////////////////////////////////////////////////////////////
    // PUBLIC STATIC METHODS

    public static function initialize(holder:MovieClip, playerName:String, widgetsSettings:Array)
    {
        //Logger.addObject(widgetsSettings, "", 2);
        _instance = new WidgetsFactory(holder, playerName, widgetsSettings);
    }

    public static function update(widgetsSettings:Array)
    {
        with (_instance)
        {
            m_widgetsSettings = widgetsSettings;
            updateWidgets();
        }
    }

    public static function get widgetsSettings()
    {
        return _instance.m_widgetsSettings;
    }

    /////////////////////////////////////////////////////////////////
    // PROPERTIES
    
    private static var _instance:WidgetsFactory = null;
    
    private var m_holder:MovieClip;
    private var m_playerName:String;
    private var m_widgetsSettings:Array;
    private var m_widgets:Array;
    
    private var m_timer:Function;
    private var m_commandCounter:Number;

    /////////////////////////////////////////////////////////////////
    // PRIVATE
    
    private function WidgetsFactory(holder:MovieClip, playerName:String, widgetsSettings:Array)
    {
        m_holder = holder;
        m_playerName = playerName;
        m_widgetsSettings = widgetsSettings;
        m_widgets = [];

        m_commandCounter = 0;

        var me = this;
        m_timer = _global.setInterval(function() { me.idleFunc.call(me) }, 10);
        
        updateWidgets();
        
        GlobalEventDispatcher.addEventListener("save_widgets_settings", this, SaveWidgetsSettings);
    }

    private function SaveWidgetsSettings()
    {
        // TODO Comm.SaveSettings(m_playerName + ":" + Defines.SETTINGS_WIDGETS, m_widgetsSettings);
    }
    
    private function updateWidgets()
    {
        //Logger.addObject(m_widgetsSettings, "", 2);

        // remove
        while (m_widgets.length > 0)
        {
            var widget:IWidget = IWidget(m_widgets.pop());
            widget.remove();
            delete widget;
        }
        
        // create
        for (var i = 0; i < m_widgetsSettings.length; ++i)
        {
            var widget:IWidget = BaseWidget.CreateWidget(m_holder, m_widgetsSettings[i], m_playerName);
            if (widget != null)
                m_widgets.push(widget);
        }
    }

    // DOSSIER DATA UPDATE
    
    private var _lastUpdateDataCall; 
    // called by timer every 10 ms
    private function idleFunc()
    {
return;
        var now = (new Date()).getTime();
        if (!_lastUpdateDataCall)
        {
            _lastUpdateDataCall = now - 59000;
            updateData();
        }
        if (now - _lastUpdateDataCall > 60000)
        {
            _lastUpdateDataCall = now;
            updateData();
        }
    }
    
    private function updateData()
    {
        // TODO Comm.SyncEncoded(Defines.COMMAND_DOSSIER,
        //    String(m_commandCounter++) + ";" +
        //    m_playerName + ";" +        // player name
        //    1372938628 + ";" +        // end
        //    (15 * 60) + ";" +         // interval(sec)
        //    100 + ";" +               // count
        //    "2;" +                    // 1 - per vehicle, 2 - summary
        //    "battlesCount,wins;" +    // data fields
        //    ";" +                     // company fields
        //    "",                       // clan fields
        //    this, answerCallback);
    }
    
    private function answerCallback(event):Void
    {
        var answer:String = event.str;
        if (answer == null || answer == "")
            return;
        if (Strings.startsWith("[ERROR]", answer))
        {
            Logger.add("Dossier answer error: " + answer);
            return;
        }

        var data = parseAnswer(answer);
        //Logger.addObject(data);
    }
    
    private function parseAnswer(answer:String):Object
    {
        var lines:Array = answer.split("\n");
        var len:Number = lines.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var values:Array = lines[i].split(";");
            var period = int(values[0]);
            var vi = VehicleInfo.getInfo2ByVid(int(values[1]));
            Logger.add(lines[i]);
        }
        return "";
    }
}
