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
import com.xvm.Components.WGComponents;

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
        LanguageBarCtor();
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private var playerName:String;
    private var currentLoadingName:String;
    private var mc_ping:MovieClip;
    private var mc_widgets:MovieClip;
    
    private function LanguageBarCtor()
    {
        Utils.TraceXvmModule("LangBarPanel");
        //Logger.addObject(_root);
        
        currentLoadingName = "";
        mc_ping = null;
        mc_widgets = null;

        GlobalEventDispatcher.addEventListener(Config.E_CONFIG_LOADED, this, onConfigLoaded);
        Config.LoadConfig();
    }

    private function onConfigLoaded()
    {
        GlobalEventDispatcher.removeEventListener(Config.E_CONFIG_LOADED, this, onConfigLoaded);
        Utils.Interval(this, onTimer, 1000);
        onTimer();
    }

    private function onTimer()
    {
        // save carousel tanks in _global to be available from the Achievements dialog.
        // FIXIT: dirty hack, find the best place to initialize carousel without timer
        if (WGComponents.carousel != null && WGComponents.carousel.dataProvider != null)
        {
            if (_global._xvm_carousel_dataProvider == null || _global._xvm_carousel_dataProvider.length != WGComponents.carousel.dataProvider.length)
                _global._xvm_carousel_dataProvider = WGComponents.carousel.dataProvider;
        }

        //Logger.add(_root.loadingName);
        if (currentLoadingName == _root.loadingName)
            return;
        currentLoadingName = _root.loadingName;
        //Logger.add(currentLoadingName);

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
        catch (e:Error)
        {
            Logger.add("ERROR: " + e.message);
        }
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

        // Hide tutorial
        if (Config.s_config.hangar.hideTutorial == true)
            _root.header.tutorialDispatcher._visible = false;

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
        var bar:ButtonBar = WGComponents.headerButtons;
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
