import com.xvm.Components.PingServers.PingServers;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Utils;

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

        Utils.TraceXvmModule("gameloading");

        GameLoadingFormCtor();

        //Logger.addObject(_root);
    }

    function setVersion()
    {
        return this.setVersionImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private var currentLoadingName:String;
    private var holder:MovieClip;

    public function GameLoadingFormCtor()
    {
        currentLoadingName = "";
        holder = null;

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("GameLoadingForm.as");
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);

        // Send first ping as early as possible, to be ready on login screen.
        if (Config.s_config.login.pingServers.enabled || Config.s_config.hangar.pingServers.enabled);
            PingServers.sendPing();

        if (Config.s_config.login.pingServers.showPingOnGameLoading != true)
            return;

        var me = this;
        _global.setInterval(function() { me.pingInitializationTimer.call(me); }, 1000);
    }

    private function pingInitializationTimer()
    {
        var main:MovieClip = wrapper;
        var holder = main.createEmptyMovieClip("pingHolder", main.getNextHighestDepth());
        // _root.contentHolder.main is fixed size (1024x768), so create holder and place it at the top left corner of screen.
        holder._x = Math.round((1024 - main.__width) / 2);
        holder._y = Math.round((768 - main.__height) / 2);
        //holder._x = 512;
        //holder._y = 384;
        PingServers.initFeature(Config.s_config.login.pingServers, holder);
    }

    function setVersionImpl(value)
    {
        wrapper.version._height = 50;
        wrapper.version.multiline = true;
        wrapper.version.text = value + "   XVM " + Defines.XVM_VERSION + " (WoT " + Defines.WOT_VERSION + ")";
    }
}
