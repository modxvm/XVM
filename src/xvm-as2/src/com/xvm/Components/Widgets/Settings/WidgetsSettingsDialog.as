/**
 * Widgets Settings Dialog
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import gfx.controls.Button;
import gfx.controls.ButtonBar;
import gfx.controls.ScrollingList;
import gfx.core.UIComponent;
import net.wargaming.managers.WindowManager;
import net.wargaming.controls.Window;
import com.xvm.Comm;
import com.xvm.Defines;
import com.xvm.JSONx;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.Components.Widgets.WidgetsFactory;
import com.xvm.Components.Widgets.SimpleDossierWidget;
import com.xvm.Components.Widgets.ComplexDossierWidget;
import com.xvm.Components.Widgets.SwitcherWidget;
import com.xvm.Components.Widgets.ClockWidget;
import com.xvm.Components.Widgets.Settings.SimpleDossierWidgetSettings;
import com.xvm.Components.Widgets.Settings.ComplexDossierWidgetSettings;
import com.xvm.Components.Widgets.Settings.SwitcherWidgetSettings;
import com.xvm.Components.Widgets.Settings.ClockWidgetSettings;

class com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog
{
    private static var windowName = "widgets_settings";
    private static var WIDGET_TYPES = { simple: 0, complex: 1, switcher: 2, clock: 3 };
    private static var WIDGET_NAMES = {
            simple: SimpleDossierWidget.WIDGET_NAME,
            complex: ComplexDossierWidget.WIDGET_NAME,
            switcher: SwitcherWidget.WIDGET_NAME,
            clock: ClockWidget.WIDGET_NAME
        };
    
    var savedWidgetsSettings:Array;
    var widgetsSettings:Array;
    var dialogSettings:Object;

    var main_mc:MovieClip;
    var playerName:String;
    
    var wnd:Window;

    var btnAdd:Button;
    var btnRemove:Button;
    var list:ScrollingList;

    var mc_widget:MovieClip;
    var mc_widgetType:ButtonBar;
    var mc_simple:MovieClip;
    var mc_complex:MovieClip;
    var mc_switcher:MovieClip;
    var mc_clock:MovieClip;

    var mc_actions:ButtonBar;
    
    /////////////////////////////////////////////////////////////////
    // PROPERTIES
    
    var _widgetsChanged:Boolean;
    public function get widgetsChanged()
    {
        return _widgetsChanged;
    }

    public function set widgetsChanged(value:Boolean)
    {
        _widgetsChanged = value;
        showCurrentWidget();
        mc_actions.renderers[1].disabled = !value; // apply
    }

    public function get currentWidgetSettings()
    {
        if (list.selectedIndex < 0 || list.selectedIndex > widgetsSettings.length - 1)
            return null;
        return widgetsSettings[list.selectedIndex];
    }
    
    /////////////////////////////////////////////////////////////////
    // INIT
    
    public function WidgetsSettingsDialog(main_mc:MovieClip, playerName:String) 
    {
        this.main_mc = main_mc;
        this.playerName = playerName;

        widgetsSettings = WidgetsFactory.widgetsSettings;
        savedWidgetsSettings = (Array)(JSONx.parse(JSONx.stringify(widgetsSettings)));
        
        //Logger.addObject(widgetsSettings);
        
        WidgetsFactory.update([]);
        _widgetsChanged = false;
        // TODO Comm.LoadSettings(playerName + ":" + Defines.SETTINGS_WIDGETSSETTINGSDIALOG, this, onSettingsLoaded);
    }
    
    public function onSettingsLoaded(event:Object)
    {
        try
        {
            dialogSettings = (!event || !event.str || event.str == "") ? Defines.DEFAULT_SETTINGS_WIDGETSSETTINGSDIALOG : JSONx.parse(event.str);
        }
        catch (e)
        {
            Logger.add("Error loading settings: " + e.message + "\n" + JSONx.stringify(event));
            dialogSettings = Defines.DEFAULT_SETTINGS_WIDGETSSETTINGSDIALOG;
        }
        
        WindowManager.instance.close(windowName, true);
        var wopt = { _x: dialogSettings.x, _y: dialogSettings.y,  _title: Locale.get("Widgets Settings"),
            allowResize: false, _minWidth: 600, _minHeight: 430, _offsetLeft: 10, _offsetTop: 40, _offsetRight: 10, _offsetBottom: 30,
            _formSource: "none", _formType: "symbol", _visible: true, topmostLevel: true};
        wnd = WindowManager.instance.open("Window", "widgets_settings", wopt);
        wnd.addEventListener("confirmFormComplete", this, "onConfirmFormComplete");
        wnd.addEventListener("close", this, "onClose");
    }
    
    private function onConfirmFormComplete()
    {
        try
        {
            var dp_actions = [
                { value: "cancel",   label: Locale.get("Cancel") },
                { value: "apply",    label: Locale.get("Apply"), disabled: true },
                { value: "ok",       label: Locale.get("OK") } ];
            mc_actions = (ButtonBar)(wnd.attachMovie("ButtonBar", "actions", wnd.getNextHighestDepth(),
                { _x: 330, _y: 390, buttonWidth: 80, dataProvider: dp_actions, selectedIndex: -1, spacing: 5, tabEnabled: false, focusEnabled: false,
                  itemRenderer: "Button" } ));
            mc_actions.addEventListener("change", this, "onActionButtonClick");

            list = UIComponent.createInstance(wnd, "ScrollingList", "list", wnd.getNextHighestDepth(),
                { _x: 10, _y: 58, _width: 200, _height: wnd.height - 100, labelField: "name", itemRenderer: "DropdownMenu_ListItemRenderer" } );
            list.addEventListener("change", this, "onListChange");
            list.dataProvider = widgetsSettings;
            list.invalidateData();
            list.selectedIndex = 0;
            
            btnAdd = (Button)(wnd.attachMovie("Button", "btnAdd", wnd.getNextHighestDepth(),
                { _x: 15, _y: 35, _width: 90, _height: 22, label:Locale.get("Add") } ));
            btnAdd.addEventListener("click", this, "onAdd");
            
            btnRemove = (Button)(wnd.attachMovie("Button", "btnRemove", wnd.getNextHighestDepth(),
                { _x: 115, _y: 35, _width: 90, _height: 22, label:Locale.get("Remove") } ));
            btnRemove.addEventListener("click", this, "onRemove");

            wnd.attachMovie("Window_BGForm", "bg", wnd.getNextHighestDepth(),
                { _x: 210, _y: 58, _width: wnd.width - 220, _height: wnd.height - 100 });

            mc_widget = wnd.createEmptyMovieClip("mc_widget", wnd.getNextHighestDepth());

            mc_simple = mc_widget.createEmptyMovieClip("mc_simple", mc_widget.getNextHighestDepth());
            mc_simple._x = 210; mc_simple._y = 58;
            SimpleDossierWidgetSettings.instance.createWidgetSettingsControls(this, mc_simple);
            
            mc_complex = mc_widget.createEmptyMovieClip("mc_complex", mc_widget.getNextHighestDepth());
            mc_complex._x = 210; mc_complex._y = 58;
            ComplexDossierWidgetSettings.instance.createWidgetSettingsControls(this, mc_complex);
            
            mc_switcher = mc_widget.createEmptyMovieClip("mc_switcher", mc_widget.getNextHighestDepth());
            mc_switcher._x = 210; mc_switcher._y = 58;
            SwitcherWidgetSettings.instance.createWidgetSettingsControls(this, mc_switcher);

            mc_clock = mc_widget.createEmptyMovieClip("mc_clock", mc_widget.getNextHighestDepth());
            mc_clock._x = 210; mc_clock._y = 58;
            ClockWidgetSettings.instance.createWidgetSettingsControls(this, mc_clock);

            var dp = [
                { value: SimpleDossierWidget.WIDGET_TYPE,   label: SimpleDossierWidget.WIDGET_TITLE },
                { value: ComplexDossierWidget.WIDGET_TYPE,  label: ComplexDossierWidget.WIDGET_TITLE },
                { value: SwitcherWidget.WIDGET_TYPE,        label: SwitcherWidget.WIDGET_TITLE },
                { value: ClockWidget.WIDGET_TYPE,           label: ClockWidget.WIDGET_TITLE } ];
            mc_widgetType = (ButtonBar)(mc_widget.attachMovie("ButtonBar", "widget_type", mc_widget.getNextHighestDepth(),
                { _x: 215, _y: 34, autoSize: true, dataProvider: dp, selectedIndex: -1, itemRenderer: "WindowTabButton" } ));
            mc_widgetType.addEventListener("change", this, "onWidgetTypeSelect");

            drawWidgetSettings();
            showCurrentWidget();
        }
        catch (e)
        {
            Logger.add("onConfirmFormComplete() ERROR: " + e);
        }
    }

    /////////////////////////////////////////////////////////////////
    // EVENTS
    
    private function onClose()
    {
        // TODO if (dialogSettings.x != wnd._x || dialogSettings.y != wnd._y)
        // TODO     Comm.SaveSettings(playerName + ":" + Defines.SETTINGS_WIDGETSSETTINGSDIALOG, { x: wnd._x, y: wnd._y } );

        wnd.removeMovieClip();
        wnd = null;
        WindowManager.instance.deleteWindow(windowName)

        WidgetsFactory.update(savedWidgetsSettings);
    }

    private function onActionButtonClick(event)
    {
        //Logger.addObject(arguments, "onActionButtonClick", 2);
        
        var save:Boolean = false;
        var close:Boolean = false;
        
        switch (event.item.value)
        {
            case "cancel":
                close = true;
                break;
            
            case "apply":
                save = true;
                break;
            
            case "ok":
                save = true;
                close = true;
                break;
        }

        if (save && widgetsChanged)
        {
            savedWidgetsSettings = (Array)(JSONx.parse(JSONx.stringify(widgetsSettings)));
            widgetsChanged = false;
            // TODO Comm.SaveSettings(playerName + ":" + Defines.SETTINGS_WIDGETS, widgetsSettings);
        }

        if (close)
            onClose();
    }
    
    private function onListChange(event)
    {
        if (event.index > widgetsSettings.length - 1)
            list.selectedIndex = widgetsSettings.length - 1;
        drawWidgetSettings();
        showCurrentWidget();
    }
    
    private function onAdd()
    {
        var w = ClockWidget.DEFAULT_SETTINGS;
        w.id = (new Date()).getTime();
        widgetsSettings.push(JSONx.parse(JSONx.stringify(w)));
        widgetsChanged = true;
        list.invalidateData();
        list.selectedIndex = widgetsSettings.length - 1;
    }
    
    private function onRemove()
    {
        if (list.selectedIndex < 0 || list.selectedIndex > widgetsSettings.length - 1)
            return;
        widgetsSettings.splice(list.selectedIndex, 1);
        widgetsChanged = true;
        list.invalidateData();
        drawWidgetSettings();
    }

    private function onWidgetTypeSelect(event)
    {
        //Logger.addObject(arguments, "onWidgetTypeSelect", 2);
        var w = currentWidgetSettings;
        if (w == null)
            return;
        if (w.type != event.item.value)
        {
            widgetsSettings[list.selectedIndex] = {
                id:  w.id,
                type: event.item.value,
                name: WIDGET_NAMES[event.item.value],
                modes: w.modes,
                pinned: w.pinned,
                x: w.x,
                y: w.y
            }
            if (event.item.value == ClockWidget.WIDGET_TYPE)
                widgetsSettings[list.selectedIndex].format = "H:N:S";
            widgetsChanged = true;
            list.invalidateData();
            drawWidgetSettings();
        }
    }
    
    /////////////////////////////////////////////////////////////////
    // DRAW
    
    private function drawWidgetSettings()
    {
        try
        {
            //Logger.addObject(arguments, "drawWidgetSettings", 2);
            var w = currentWidgetSettings;
            if (w == null)
            {
                btnRemove.disabled = true;
                mc_widget._visible = false;
                return;
            }

            btnRemove.disabled = false;
            mc_widget._visible = true;

            mc_widgetType.selectedIndex = WIDGET_TYPES[w.type];
            mc_simple._visible = w.type == SimpleDossierWidget.WIDGET_TYPE;
            mc_complex._visible = w.type == ComplexDossierWidget.WIDGET_TYPE;
            mc_switcher._visible = w.type == SwitcherWidget.WIDGET_TYPE;
            mc_clock._visible = w.type == ClockWidget.WIDGET_TYPE;
            
            switch (w.type)
            {
                case SimpleDossierWidget.WIDGET_TYPE: SimpleDossierWidgetSettings.instance.drawWidgetSettings(mc_simple, w); break;
                case ComplexDossierWidget.WIDGET_TYPE: ComplexDossierWidgetSettings.instance.drawWidgetSettings(mc_complex, w); break;
                case SwitcherWidget.WIDGET_TYPE: SwitcherWidgetSettings.instance.drawWidgetSettings(mc_switcher, w); break;
                case ClockWidget.WIDGET_TYPE: ClockWidgetSettings.instance.drawWidgetSettings(mc_clock, w); break;
            }
        }
        catch (e)
        {
            Logger.add("drawWidgetSettings() ERROR: " + e);
        }
    }

    
    /////////////////////////////////////////////////////////////////
    // PREVIEW

    private function showCurrentWidget()
    {
        var w = currentWidgetSettings;
        if (w == null)
            WidgetsFactory.update([]);
        else
            WidgetsFactory.update([ w ]);
    }
}
