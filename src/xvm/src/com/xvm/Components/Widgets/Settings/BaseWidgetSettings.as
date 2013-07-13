/**
 * Base Widget Settings (abstract)
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import gfx.controls.CheckBox;
import com.xvm.Defines;
import com.xvm.Locale;
import com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog;
 
class com.xvm.Components.Widgets.Settings.BaseWidgetSettings
{
    /////////////////////////////////////////////////////////////////
    // SINGLETON INSTANCE
    
    private static var _instance:BaseWidgetSettings = null;
    
    // virtual
    private static function get instance():BaseWidgetSettings
    {
        throw new Error("Cannot create instance of Abstract class: BaseWidgetSettings");
        return null; // stub for compiler bug
    }
    
    /////////////////////////////////////////////////////////////////
    // PUBLIC
    
    // virtual
    public function createWidgetSettingsControls(owner:WidgetsSettingsDialog, mc:MovieClip)
    {
        _settingsDlg = owner;
            
        var enable:CheckBox = (CheckBox)(mc.attachMovie("CheckBox", "enable", mc.getNextHighestDepth(),
            { _x: 10, _y: 10, autoSize: true, label: Locale.get("Enable") } ));
        enable.addEventListener("select", this, "onEnableChange");
    }
    
    // virtual
    public function drawWidgetSettings(mc:MovieClip, w:Object)
    {
        mc.enable.selected = w.enable;
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
    
    private function CreateLabel(mc, name, x, y, w, h, text)
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
    }
    
    /////////////////////////////////////////////////////////////////
    // PRIVATE
    
    private var _settingsDlg:WidgetsSettingsDialog;

    private function onEnableChange(event)
    {
        //Logger.addObject(arguments, "onEnableChange", 2);
        var w = currentWidgetSettings;
        if (w == null)
            return;
        w.enable = event.target.selected;
        widgetsChanged = true;
    }
}