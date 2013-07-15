/**
 * LanguageBar Worker
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
import gfx.controls.ButtonBar;
import com.xvm.Comm;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.JSONx;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.Utils;
import com.xvm.Components.PingServers.PingServers;
import com.xvm.Components.Widgets.WidgetsFactory;
import com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog;

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

    private var playerName:String;
    private var currentLoadingName:String;
    private var mc_ping:MovieClip;
    private var mc_widgets:MovieClip;
    
    public function LanguageBarCtor()
    {
        currentLoadingName = "";
        mc_ping = null;
        mc_widgets = null;

        GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        Config.LoadConfig("LanguageBar.as");
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);

        var me = this;
        _global.setInterval(function() { me.onTimer.call(me); }, 1000);
        onTimer();
    }

    private function onTimer()
    {
        //Logger.add(_root.loadingName);
        if (currentLoadingName == _root.loadingName)
            return;
        currentLoadingName = _root.loadingName;

        // "startgamevideo", "login", "hangar"

        if (mc_ping != null)
        {
            mc_ping.removeMovieClip();
            mc_ping = null;
        }
        if (mc_widgets != null)
        {
            mc_widgets.removeMovieClip();
            mc_widgets = null;
        }
        
        try
        {
            if (currentLoadingName == "startgamevideo" || currentLoadingName == "login")
                initLogin();
            else if (currentLoadingName == "hangar")
                initHangar();
        }
        catch (e)
        {
            Logger.add("ERROR: " + e.message);
        }
    }
    
    function initImpl()
    {
        //Logger.add("LanguageBar.init()");
    }
    
    // PRIVATE
    
    private function initLogin()
    {
        var main:MovieClip = _root.contentHolder.main;

        // PingServers component
        mc_ping = main.createEmptyMovieClip("pingHolder", main.getNextHighestDepth());
        // _root.contentHolder.main is fixed size (1024x768), so create holder and place it at the top left corner of screen.
        mc_ping._x = Math.round((1024 - main.__width) / 2);
        mc_ping._y = Math.round((768 - main.__height) / 2);
        PingServers.initFeature(Config.s_config.login.pingServers, mc_ping);

        // ------------------ DEBUG ------------------
        //var mc = main.createEmptyMovieClip("widgetsHolder", main.getNextHighestDepth());
        //WidgetsFactory.initialize(mc, "sirmax2",
        //    [ com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog.DEFAULT_WIDGET_SETTINGS ]);
        //var wsd = new com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog(main, "sirmax2");
        // ------------------ DEBUG ------------------
    }
    
    private function initHangar()
    {
        var header:MovieClip = _root.header;
        playerName = _root.header.tankPanel.account_name.text;

        // PingServers component
        mc_ping = header.createEmptyMovieClip("pingHolder", header.getNextHighestDepth());
        PingServers.initFeature(Config.s_config.hangar.pingServers, mc_ping);
        
        // Widgets
        if (Config.s_config.hangar.widgetsEnabled == true)
        {
            createMenuWidgetsButton();
            Comm.LoadSettings(playerName + ":" + Defines.SETTINGS_WIDGETS, this, onWidgetsLoaded);
        }
    }
    
    private function createMenuWidgetsButton()
    {
        var bar:ButtonBar = (ButtonBar)(_root.header.buttonsBlock.bar);
        if (bar.xvm_initialized != true)
        {
            bar.xvm_initialized = true;
            var dp:Array = bar.dataProvider;
            dp.push({ value: "widget", label: Locale.get("Widgets") });
            bar.dataProvider = dp;
            bar.addEventListener("itemClick", this, "menuBarSelectEvent");
            bar.draw();
        }
    }
    
    private function onWidgetsLoaded(event:Object)
    {
        var widgetsSettings = null;
        try
        {
            if (!event || !event.str || event.str == "")
                return;
            widgetsSettings = (Array)(JSONx.parse(event.str));
        }
        catch (e)
        {
            Logger.add("Error loading widgets: " + e.message + "\n" + JSONx.stringify(event));
            widgetsSettings = [];
        }

        var holder = _root.header.buttonsBlock;
        mc_widgets = holder.createEmptyMovieClip("widgets", holder.getNextHighestDepth());
        WidgetsFactory.initialize(mc_widgets, playerName, widgetsSettings);
    }

    private function menuBarSelectEvent(event)
    {
        if (event.item.value == "widget")
            var wsd = new WidgetsSettingsDialog(_root.header, playerName);
    }
}
