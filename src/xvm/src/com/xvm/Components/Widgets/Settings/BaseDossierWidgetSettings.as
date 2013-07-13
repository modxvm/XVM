/**
 * Base Dossier Widget Settings (abstract)
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import gfx.controls.NumericStepper;
import com.xvm.Locale;
import com.xvm.Components.Widgets.BaseDossierWidget;
import com.xvm.Components.Widgets.SimpleDossierWidget;
import com.xvm.Components.Widgets.ComplexDossierWidget;
import com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog;
import com.xvm.Components.Widgets.Settings.BaseWidgetSettings;

class com.xvm.Components.Widgets.Settings.BaseDossierWidgetSettings extends BaseWidgetSettings
{
    /////////////////////////////////////////////////////////////////
    // SINGLETON INSTANCE
    
    private static var _instance:BaseWidgetSettings = null;
    
    // virtual
    private static function get instance()
    {
        throw new Error("Cannot create instance of Abstract class: BaseDossierWidgetSettings");
    }

    /////////////////////////////////////////////////////////////////
    // PUBLIC
    
    // virtual
    public function createWidgetSettingsControls(owner:WidgetsSettingsDialog, mc:MovieClip)
    {
        super.createWidgetSettingsControls(owner, mc);

        CreateLabel(mc, "lInterval", 10, 30, 130, 25, Locale.get("Update interval, sec"));
        var interval:NumericStepper = (NumericStepper)(mc.attachMovie("NumericStepper", "interval_" + $widgetType, mc.getNextHighestDepth(),
            { _x: 140, _y: 30, _width: 60, minimum: 0, maximum: 3600, stepSize: 10 } ));
        interval.addEventListener("change", this, "onIntervalChange");
    }

    // virtual
    public function drawWidgetSettings(mc:MovieClip, w:Object)
    {
        super.drawWidgetSettings(mc, w);

        if (isNaN(w.interval))
            w.interval = 300;
        mc["interval_" + $widgetType].value = w.interval;
    }

    /////////////////////////////////////////////////////////////////
    // PROTECTED
    
    // virtual
    private function get $widgetType():String
    {
        return BaseDossierWidget.WIDGET_TYPE;
    }
    
    /////////////////////////////////////////////////////////////////
    // PRIVATE

    private function onIntervalChange(event)
    {
        //Logger.addObject(arguments, "onIntervalChange", 2);
        var w = currentWidgetSettings;
        if (w == null)
            return;
        if (w.interval != event.target.value && (
            w.type == SimpleDossierWidget.WIDGET_TYPE && event.target._name == "interval_" + SimpleDossierWidget.WIDGET_TYPE ||
            w.type == ComplexDossierWidget.WIDGET_TYPE && event.target._name == "interval_" + ComplexDossierWidget.WIDGET_TYPE))
        {
            w.interval = event.target.value;
            widgetsChanged = true;
        }
    }
}
