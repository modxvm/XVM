/**
 * Switcher Widget Settings
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import gfx.controls.CheckBox;
import gfx.controls.TextInput;
import com.xvm.Locale;
import com.xvm.Components.Widgets.SwitcherWidget;
import com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog;
import com.xvm.Components.Widgets.Settings.BaseWidgetSettings;

class com.xvm.Components.Widgets.Settings.SwitcherWidgetSettings extends BaseWidgetSettings
{
    /////////////////////////////////////////////////////////////////
    // SINGLETON INSTANCE
    
    private static var _instance:SwitcherWidgetSettings = null;
    
    public static function get instance()
    {
        if (_instance == null)
            _instance = new SwitcherWidgetSettings();
        return _instance;
    }

    /////////////////////////////////////////////////////////////////
    // PUBLIC
    
    // virtual
    public function createWidgetSettingsControls(owner:WidgetsSettingsDialog, mc:MovieClip)
    {
        super.createWidgetSettingsControls(owner, mc);

        CreateLabel(mc, "lLabel", 10, 30, 40, 25, Locale.get("Label"));
        var tiLbl:TextInput = (TextInput)(mc.attachMovie("TextInput", "label", mc.getNextHighestDepth(),
            { _x: 50, _y: 30, _width: 300 } ));
        tiLbl.addEventListener("textChange", this, "onSwitcherLabelChange");

        CreateLabel(mc, "lLabel", 10, 60, 100, 25, Locale.get("Modes"));
        var cb1:CheckBox = (CheckBox)(mc.attachMovie("CheckBox", "cb1", mc.getNextHighestDepth(),
            { _x: 10, _y: 80, width:200, label: Locale.get("Hide all widgets") } ));
        cb1.addEventListener("select", this, "onSwitcherCbChange");
        var cb2:CheckBox = (CheckBox)(mc.attachMovie("CheckBox", "cb2", mc.getNextHighestDepth(),
            { _x: 10, _y: 100, width:200, label: Locale.get("Select Mode 1") } ));
        cb2.addEventListener("select", this, "onSwitcherCbChange");
        var cb3:CheckBox = (CheckBox)(mc.attachMovie("CheckBox", "cb3", mc.getNextHighestDepth(),
            { _x: 10, _y: 120, width:200, label: Locale.get("Select Mode 2") } ));
        cb3.addEventListener("select", this, "onSwitcherCbChange");
        var cb4:CheckBox = (CheckBox)(mc.attachMovie("CheckBox", "cb4", mc.getNextHighestDepth(),
            { _x: 10, _y: 140, width:200, label: Locale.get("Show detailed info window") } ));
        cb4.addEventListener("select", this, "onSwitcherCbChange");
    }

    // virtual
    public function drawWidgetSettings(mc:MovieClip, w:Object)
    {
        super.drawWidgetSettings(mc, w);
        
        if (!w.label)
            w.label = "";
        mc.label.text = w.label;
        if (isNaN(parseInt(w.modes)))
            w.modes = 0x0F;
        mc.cb1.selected = (w.modes & 0x01);
        mc.cb2.selected = (w.modes & 0x02);
        mc.cb3.selected = (w.modes & 0x04);
        mc.cb4.selected = (w.modes & 0x08);
    }

    /////////////////////////////////////////////////////////////////
    // PRIVATE

    private function onSwitcherLabelChange(event)
    {
        //Logger.addObject(arguments, "onSwitcherLabelChange", 2);
        var w = currentWidgetSettings;
        if (w == null)
            return;
        w.label = event.target.text;
        w.name = SwitcherWidget.WIDGET_NAME + (w.label == "" ? "" : " : " + w.label);
        updateListData();
        widgetsChanged = true;
    }

    private function onSwitcherCbChange(event)
    {
        //Logger.addObject(arguments, "onSwitcherCbChange", 2);
        var w = currentWidgetSettings;
        if (w == null)
            return;
        var n = 0;
        switch (event.target._name)
        {
            case "cb1": n = 0x01; break;
            case "cb2": n = 0x02; break;
            case "cb3": n = 0x04; break;
            case "cb4": n = 0x08; break;
        }
        w.modes = (event.target.selected) ? w.modes | n : w.modes & ~n;
        widgetsChanged = true;
    }
    
}
