/**
 * Base Widget Implementation (abstract)
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.Logger;
import com.xvm.Components.Widgets.IWidget;
import com.xvm.Components.Widgets.SimpleDossierWidget;
import com.xvm.Components.Widgets.ComplexDossierWidget;
import com.xvm.Components.Widgets.SwitcherWidget;
import com.xvm.Components.Widgets.ClockWidget;
import com.xvm.Components.Widgets.Views.IWidgetView;

class com.xvm.Components.Widgets.BaseWidget implements IWidget
{
    /////////////////////////////////////////////////////////////////
    // CONSTANTS

    public static var WIDGET_TITLE = "Base";
    public static var WIDGET_NAME = "Base";
    public static var WIDGET_TYPE = "";

    /////////////////////////////////////////////////////////////////
    // PUBLIC STATIC

    public static function CreateWidget(mc:MovieClip, settings:Object, playerName:String):IWidget
    {
        var widget:IWidget;
        switch (settings.type)
        {
            case SimpleDossierWidget.WIDGET_TYPE: widget = new SimpleDossierWidget(); break;
            case ComplexDossierWidget.WIDGET_TYPE: widget = new ComplexDossierWidget(); break;
            case SwitcherWidget.WIDGET_TYPE: widget = new SwitcherWidget(); break;
            case ClockWidget.WIDGET_TYPE: widget = new ClockWidget(); break;
            default:
                Logger.add("WARNING: unknown widget type: " + settings.type);
                return null;
        }
        
        widget.create(mc, settings, playerName);
        return widget;
    }
    
    /////////////////////////////////////////////////////////////////
    // IWidget implementation

    private var _mc:MovieClip
    public function get mc():MovieClip
    {
        return this._mc;
    }

    // protected
    private var _view:IWidgetView;
    public function get view():IWidgetView
    {
        return this._view;
    }

    // mandatory fields: id, type, name, enable
    private var _settings:Object;
    public function get settings():Object
    {
        return _settings;
    }

    private var _playerName:String;
    public function get playerName():String
    {
        return _playerName;
    }

    // virtual
    public function create(holder:MovieClip, settings:Object, playerName:String)
    {
        //Logger.addObject(settings, "[BASE] create");
        this._mc = holder.createEmptyMovieClip("xvm_widget_" + settings.type + "_" + settings.id, holder.getNextHighestDepth());
        this._settings = settings;
        this._playerName = playerName;
    }

    // virtual
    public function remove()
    {
        //Logger.addObject(settings, "[BASE] remove");
        if (this._mc != null)
        {
            this._mc.removeMovieClip();
            this._mc = null;
        }
    }
    
    /////////////////////////////////////////////////////////////////
    // PROTECTED


    /////////////////////////////////////////////////////////////////
    // PRIVATE




    /*


    public static var instance:Dossier = null;

    private var playerName:String;
    private var widgets:Object;
    private var view:DossierView;

    private var timer:Function; // FIXIT: replace timer with event
    private var commandCounter:Number;

    public static function initialize(holder:MovieClip, playerName:String, widgets:Array)
    {
        Logger.addObject(widgets, "", 2);

        if (instance == null)
            instance = new Dossier(playerName, widgets);
        instance.view = new DossierView(widgets, holder);

        if (instance.timer != null)
            _global.clearInterval(instance.timer);
        instance.timer = _global.setInterval(function() { Dossier.instance.idleFunc.call(Dossier.instance) }, 10);

        update(widgets);
    }

    public static function update(widgets:Array)
    {
        instance.widgets = widgets;
        instance.view.update(widgets);
    }

    public static function get Widgets()
    {
        return instance.widgets;
    }

    public function Dossier(playerName:String, widgets:Object)
    {
        commandCounter = 0;
        this.playerName = playerName;
        this.widgets = widgets;
    }

    private var lastUpdateDataCall;
    // called by timer every 10 ms
    private function idleFunc()
    {
        var now = (new Date()).getTime();
        if (!lastUpdateDataCall)
        {
            lastUpdateDataCall = now - 59000;
            updateData();
        }
        if (now - lastUpdateDataCall > 60000)
        {
            lastUpdateDataCall = now;
            updateData();
        }
        view.updateIdle((now - lastUpdateDataCall) / 60000);
    }

    private function updateData()
    {
        Comm.SyncEncoded(Defines.COMMAND_DOSSIER,
            //                                                  end                interval (sec)  count      data fields             company, clan fields
            String(commandCounter++) + ";" +
            playerName + ";" +        // player name
            1372938628 + ";" +        // end
            (15 * 60) + ";" +         // interval(sec)
            100 + ";" +               // count
            "2;" +                    // 1 - per vehicle, 2 - summary
            "battles_count,wins;" +   // data fields
            ";" +                     // company fields
            "",                       // clan fields
            this, answerCallback);
    }

    private function answerCallback(event):Void
    {
        var answer:String = event.str;
        if (answer == null || answer == "")
            return;
        if (Utils.startsWith("[ERROR]", answer))
        {
            Logger.add("Dossier answer error: " + answer);
            return;
        }

        var data = parseAnswer(answer);
        Logger.addObject(data);
        view.update(data);
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
*/
}