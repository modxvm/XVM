/**
 * Base Widget Settings (abstract)
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import gfx.controls.CheckBox;
import gfx.controls.Slider;
import com.xvm.Defines;
import com.xvm.Locale;
import com.xvm.Components.Widgets.Settings.SwitcherWidgetSettings; 
import com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog;

class com.xvm.Components.Widgets.Settings.BaseWidgetSettings
{
    /////////////////////////////////////////////////////////////////
    // SINGLETON INSTANCE
    
    private static var _instance:BaseWidgetSettings = null;
    
    // virtual
    private static function get instance():BaseWidgetSettings
    {
        throw new Error("Cannot create instance of abstract class: BaseWidgetSettings");
        return null; // stub for compiler bug
    }
    
    /////////////////////////////////////////////////////////////////
    // PUBLIC
    
    // virtual
    public function createWidgetSettingsControls(owner:WidgetsSettingsDialog, mc:MovieClip)
    {
        _settingsDlg = owner;
            
        if (!(this instanceof SwitcherWidgetSettings))
        {
            var mode1:CheckBox = CheckBox.createInstance(mc, "CheckBox", "mode1", mc.getNextHighestDepth(),
                { _x: 10, _y: 10, autoSize: true, label: Locale.get("Mode 1") } );
            mode1.addEventListener("select", this, "onModeChange");

            var mode2:CheckBox = CheckBox.createInstance(mc, "CheckBox", "mode2", mc.getNextHighestDepth(),
                { _x: 100, _y: 10, autoSize: true, label: Locale.get("Mode 2") } );
            mode2.addEventListener("select", this, "onModeChange");
        }

        CreateLabel(mc, "lBgAlpha", 10, 300, 140, 25, Locale.get("Background transparency"));
        var bgAlpha:Slider = Slider.createInstance(mc, "Slider", "bgAlpha", mc.getNextHighestDepth(),
            { _x: 160, _y: 300, _width: 200, minimum: 0, maximum: 100, liveDragging: true } );
        bgAlpha.addEventListener("change", this, "onBgAlphaChange");
    }
    
    // virtual
    public function drawWidgetSettings(mc:MovieClip, w:Object)
    {
        mc.mode1.selected = (w.modes & Defines.WIDGET_MODE_1);
        mc.mode2.selected = (w.modes & Defines.WIDGET_MODE_2);
        mc.bgAlpha.value = w.bgAlpha;
    }
    
    /////////////////////////////////////////////////////////////////
    // PROTECTED
    
    private function get currentWidgetSettings()
    {
        return _settingsDlg.currentWidgetSettings;
    }
    
    private function set widgetsChanged(value:Boolean):Void
    {
        _settingsDlg.widgetsChanged = value;
    }

    private function updateListData():Void
    {
        _settingsDlg.list.invalidateData();
    }
    
    private function CreateLabel(mc, name, x, y, w, h, text):TextField
    {
        var tfLbl:TextField = mc.createTextField("tf_lbl", mc.getNextHighestDepth(), x, y, w, h);
        tfLbl.selectable = false;
        tfLbl.verticalAlign = "center";
        tfLbl.textColor = Defines.UICOLOR_DEFAULT;
        var fmt:TextFormat =  tfLbl.getNewTextFormat();
        fmt.font = "$FieldFont";
        fmt.size = 13;
        tfLbl.setNewTextFormat(fmt);
        tfLbl.text = text;
        return tfLbl;
    }
    
    /////////////////////////////////////////////////////////////////
    // PRIVATE
    
    private var _settingsDlg:WidgetsSettingsDialog;

    private function onModeChange(event)
    {
        //com.xvm.Logger.addObject(arguments, "onModeChange", 2);
        var w = currentWidgetSettings;
        if (w == null)
            return;
        var n = 0;
        switch (event.target._name)
        {
            case "mode1": n = Defines.WIDGET_MODE_1; break;
            case "mode2": n = Defines.WIDGET_MODE_2; break;
        }
        w.modes = (event.target.selected) ? w.modes | n : w.modes & ~n;
        widgetsChanged = true;
    }
    

    private function onBgAlphaChange(event)
    {
        //com.xvm.Logger.addObject(arguments, "onBgAlphaChange", 2);
        var w = currentWidgetSettings;
        if (w == null)
            return;
        w.bgAlpha = event.target.value;
        widgetsChanged = true;
    }
}