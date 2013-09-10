/**
 * Clock Widget Settings
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import gfx.controls.TextInput;
import gfx.core.UIComponent;
import com.xvm.Defines;
import com.xvm.Locale;
import com.xvm.Components.Widgets.Settings.BaseWidgetSettings;
import com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog;

class com.xvm.Components.Widgets.Settings.ClockWidgetSettings extends BaseWidgetSettings
{
    /////////////////////////////////////////////////////////////////
    // SINGLETON INSTANCE
    
    private static var _instance:ClockWidgetSettings = null;
    
    public static function get instance()
    {
        if (_instance == null)
            _instance = new ClockWidgetSettings();
        return _instance;
    }

    /////////////////////////////////////////////////////////////////
    // PUBLIC

    // virtual
    public function createWidgetSettingsControls(owner:WidgetsSettingsDialog, mc:MovieClip)
    {
        super.createWidgetSettingsControls(owner, mc);

        CreateLabel(mc, "lFormat", 10, 30, 40, 25, Locale.get("Format"));
        var tiFormat:TextInput = TextInput.createInstance(mc, "TextInput", "format", mc.getNextHighestDepth(),
            { _x: 50, _y: 30, _width: 300 } );
        tiFormat.addEventListener("textChange", this, "onClockFormatChange");
        var tip:TextField = CreateLabel(mc, "lFormatTip", 50, 50, 200, 150,
            Locale.get("Y - year\nM - month\nD - day\nH - hour\nN - minutes\nS - seconds"));
        tip.textColor = Defines.UICOLOR_DEFAULT2;
    }
    
    // virtual
    public function drawWidgetSettings(mc:MovieClip, w:Object)
    {
        super.drawWidgetSettings(mc, w);
        
        if (!w.format)
            w.format = "H:N:S";
        mc.format.text = w.format;

        mc.bgAlpha.value = w.bgAlpha != null ? w.bgAlpha : 60;
    }

    /////////////////////////////////////////////////////////////////
    // PRIVATE

    private function onClockFormatChange(event)
    {
        //Logger.addObject(arguments, "onClockFormatChange", 2);
        var w = currentWidgetSettings;
        if (w == null)
            return;
        w.format = event.target.text;
        widgetsChanged = true;
    }
}
