/**
 * GameLoadingForm Worker
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Utils;
import com.xvm.Components.PingServers.PingServers;

class wot.gameloading.GameLoadingForm
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    public var wrapper:net.wargaming.gameloading.GameLoadingForm;
    private var base:net.wargaming.gameloading.GameLoadingForm;

    public function GameLoadingForm(wrapper:net.wargaming.gameloading.GameLoadingForm, base:net.wargaming.gameloading.GameLoadingForm)
    {
        this.wrapper = wrapper;
        this.base = base;
        GameLoadingFormCtor();
    }

    function setVersion()
    {
        return this.setVersionImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private var currentLoadingName:String;
    private var holder:MovieClip;

    private function GameLoadingFormCtor()
    {
        Utils.TraceXvmModule("gameloading");
        //Logger.addObject(_root);
        currentLoadingName = "";
        holder = null;

        GlobalEventDispatcher.addEventListener(Config.E_CONFIG_LOADED, this, onConfigLoaded);
        Config.LoadConfig();
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener(Config.E_CONFIG_LOADED, this, onConfigLoaded);

        // ------------------ DEBUG ------------------
        //var mc = wrapper.createEmptyMovieClip("widgetsHolder", wrapper.getNextHighestDepth());
        //com.xvm.Components.Widgets.WidgetsFactory.initialize(mc, "sirmax2", [ com.xvm.Components.Widgets.SwitcherWidget.DEFAULT_SETTINGS ]);
        //var wsd = new com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog(_root.header, "sirmax2");
        // ------------------ DEBUG ------------------

        // Send first ping as early as possible, to be ready on login screen.
        if (Config.s_config.login.pingServers.enabled || Config.s_config.hangar.pingServers.enabled);
            PingServers.sendPing();
    }

    function setVersionImpl(value)
    {
        wrapper.version._height = 50;
        wrapper.version.multiline = true;
        wrapper.version.text = value + "   XVM " + Defines.XVM_VERSION + " (WoT " + Defines.WOT_VERSION + ")";
    }
}
