/**
 * Complex Dossier Widget Settings
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.Components.Widgets.ComplexDossierWidget;
import com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog;
import com.xvm.Components.Widgets.Settings.BaseDossierWidgetSettings;

class com.xvm.Components.Widgets.Settings.ComplexDossierWidgetSettings extends BaseDossierWidgetSettings
{
    /////////////////////////////////////////////////////////////////
    // SINGLETON INSTANCE
    
    private static var _instance:ComplexDossierWidgetSettings = null;
    
    public static function get instance()
    {
        if (_instance == null)
            _instance = new ComplexDossierWidgetSettings();
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
        return ComplexDossierWidget.WIDGET_TYPE;
    }
    
}
