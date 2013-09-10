/**
 * Simple Dossier Widget Settings
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Components.Widgets.SimpleDossierWidget;
import com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog;
import com.xvm.Components.Widgets.Settings.BaseDossierWidgetSettings;

class com.xvm.Components.Widgets.Settings.SimpleDossierWidgetSettings extends BaseDossierWidgetSettings
{
    /////////////////////////////////////////////////////////////////
    // SINGLETON INSTANCE
    
    private static var _instance:SimpleDossierWidgetSettings = null;
    
    public static function get instance()
    {
        if (_instance == null)
            _instance = new SimpleDossierWidgetSettings();
        return _instance;
    }

    /////////////////////////////////////////////////////////////////
    // PUBLIC
    
    // virtual
    public function createWidgetSettingsControls(owner:WidgetsSettingsDialog, mc:MovieClip)
    {
        super.createWidgetSettingsControls(owner, mc);
    }

    // virtual
    public function drawWidgetSettings(mc:MovieClip, w:Object)
    {
        super.drawWidgetSettings(mc, w);
    }

    /////////////////////////////////////////////////////////////////
    // PROTECTED
    
    // virtual
    private function get $widgetType():String
    {
        return SimpleDossierWidget.WIDGET_TYPE;
    }
    
}
