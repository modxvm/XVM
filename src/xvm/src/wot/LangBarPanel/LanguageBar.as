import com.xvm.Config;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Logger;
import com.xvm.Utils;
import com.xvm.Components.PingServers.PingServers;

class wot.LangBarPanel.LanguageBar
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    public var wrapper:net.wargaming.LanguageBar;
    private var base:net.wargaming.LanguageBar;

    public function LanguageBar(wrapper:net.wargaming.LanguageBar, base:net.wargaming.LanguageBar)
    {
        this.wrapper = wrapper;
        this.base = base;

        Utils.TraceXvmModule("LangBarPanel");

        LanguageBarCtor();

        //Logger.addObject(_root);
    }

    function init()
    {
        return this.initImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private var currentLoadingName:String;
    private var holder:MovieClip;
    
    public function LanguageBarCtor()
    {
        currentLoadingName = "";
        holder = null;

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("LanguageBar.as");
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);

        var me = this;
        _global.setInterval(function() { me.pingInitializationTimer.call(me); }, 1000);
        pingInitializationTimer();
    }

    private function pingInitializationTimer()
    {
        //Logger.add(_root.loadingName);
        if (currentLoadingName == _root.loadingName)
            return;
        currentLoadingName = _root.loadingName;

        // "startgamevideo", "login", "hangar"

        if (holder != null)
            holder.removeMovieClip();
        
        if (currentLoadingName == "hangar")
        {
            var header:MovieClip = _root.header;
            holder = header.createEmptyMovieClip("pingHolder", header.getNextHighestDepth());
            PingServers.initFeature(Config.s_config.hangar.pingServers, holder);
        }
        else if (currentLoadingName == "startgamevideo" || currentLoadingName == "login")
        {
            var main:MovieClip = _root;
            holder = main.createEmptyMovieClip("pingHolder", main.getNextHighestDepth());
            // _root.contentHolder.main is fixed size (1024x768), so create holder and place it at the top left corner of screen.
            holder._x = Math.round((1024 - main.__width) / 2);
            holder._y = Math.round((768 - main.__height) / 2);
            //holder._x = 512;
            //holder._y = 384;
            PingServers.initFeature(Config.s_config.login.pingServers, holder);
        }
    }
    
    function initImpl()
    {
        //Logger.add("LanguageBar.init()");
    }
}
