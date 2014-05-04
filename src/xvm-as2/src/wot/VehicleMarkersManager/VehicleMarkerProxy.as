/**
 * Proxy class for vehicle marker components
 * Dispatches event for config loading if it is not loaded
 */
import com.xvm.*;
import wot.VehicleMarkersManager.*;
import wot.VehicleMarkersManager.log.*;

/* TODO:
 * Check for performance boost with marker object caching
 * http://sourcemaking.com/design_patterns/object_pool
 */

class wot.VehicleMarkersManager.VehicleMarkerProxy implements IVehicleMarker
{
    /////////////////////////////////////////////////////////////////

    public var wrapper:net.wargaming.ingame.VehicleMarker;
    private var base:net.wargaming.ingame.VehicleMarker;

    public function VehicleMarkerProxy(wrapper:net.wargaming.ingame.VehicleMarker, base:net.wargaming.ingame.VehicleMarker)
    {
        this.wrapper = wrapper;
        this.base = base;
        VehicleMarkerProxyCtor();
    }

    /////////////////////////////////////////////////////////////////

    // Private members
    private var m_vehicleName:String;
    private var m_level:Number;
    private var m_playerName:String;
    private var m_playerClan:String;
    private var m_playerRegion:String;
    private var m_playerFullName:String;
    private var m_curHealth:Number;
    private var m_defaultIconSource:String;
    private var m_vehicleClass:String;
    private var m_dead:Boolean;

    // Components
    private static var logLists:LogLists = null;

    /**
     * Instance of subject class with real implementation
     */
    private var subject:IVehicleMarker;

    /**
     * List of pending calls (missed while config is loading).
     * Records is object: { func:String, args:Array }
     */
    private var pendingCalls:Array;

    /**
     * ctor()
     */
    var start;
    private function VehicleMarkerProxyCtor()
    {
        Utils.TraceXvmModule("VehicleMarkersManager");

        //trace("VehicleMarkerProxy::ctor()");

        subject = null;

        // Check config
        if (Config.config)
        {
            // if not loaded:
            //   cleaning the marker until the configuration is loaded
            wrapper.pNameField._visible = false;
            wrapper.marker._visible = false;
            wrapper.healthBar._visible = false;
            wrapper.bgShadow._visible = false;
            wrapper.vNameField.text = "Loading...";
            //   register config load complete event
            GlobalEventDispatcher.addEventListener(Config.E_CONFIG_LOADED, this, onConfigLoaded);
        }
        else
        {
            // if already loaded, initialize immediately
            initialize();
        }
    }

    /**
     * Config load callback
     * Calls on config loading is complete. Calls always, even if config is missed or loading failed.
     */
    private function onConfigLoaded():Void
    {
        //Logger.add("onConfigLoaded()");

        //GlobalEventDispatcher.removeEventListener(Config.E_CONFIG_LOADED, this, onConfigLoaded);

        //Config.config.markers.useStandardMarkers = true;

        initialize();
    }

    private function initialize():Void
    {
        // Don't draw at hangar
        if (Sandbox.GetCurrentSandboxPrefix() == Sandbox.SANDBOX_VMM)
        {
            if (logLists == null)
            {
                logLists = new LogLists(Config.config.hitLog);
            }
        }

        // finalize initialization
        if (m_playerFullName && !subject)
        {
            initializeSubject();
        }
    }

    /**
     * Create subject class in depend of config setting
     */
    private function initializeSubject():Void
    {
        trace("initializeSubject() standard=" + Config.config.markers.useStandardMarkers + " " + m_playerFullName);

        // Create marker class depending on config setting
        if (Config.config.markers.useStandardMarkers == true)
            createStandardMarker();
        else
            createXvmMarker();

        // Invoke all deferred method calls while config was loading
        if (pendingCalls.length > 0)
            processPendingCalls();
    }

    private function createStandardMarker()
    {
        trace("createStandardMarker()");

        // re-enable vehicle type marker for standard marker
        wrapper.marker._visible = true;

        // fix icon visibility after load for standard marker
        var wr = wrapper;
        wrapper.iconLoader.addEventListener("init",
            function() { wr.iconLoader.visible = wr.getPartVisibility(net.wargaming.ingame.VehicleMarker.ICON) });

        subject = base;
    }

    private function createXvmMarker()
    {
        subject = new wot.VehicleMarkersManager.Xvm(this);
    }

    // TODO: Check performance
    function onEnterFrame():Void
    {
        if (subject == null)
            return;
        if (subject.onEnterFrame != null)
            subject.onEnterFrame();
    }

    function gotoAndStop(frame:Object):Void
    {
        //trace("gotoAndStop(" + frame + ")");
        base.gotoAndStop(frame);

        if (IsStandardMarker && !wrapper.m_speaking && !wrapper.marker.marker.icon["_xvm_colorized"])
        {
            // WARNING: do not touch proxy.marker.marker - marker animation will be broken
            wrapper.marker.marker.icon["_xvm_colorized"] = true;
            GraphicsUtil.colorize(wrapper.marker.marker.icon, wrapper.colorsManager.getRGB(wrapper.colorSchemeName),
                Config.config.consts.VM_COEFF_VMM); // darker to improve appearance
        }

        if (IsXvmMarker)
            wot.VehicleMarkersManager.Xvm(subject).setupMarkerFrame();
    }

    /**
     * Call all skipped steps
     * subject must be created when this function is called
     */
    private function processPendingCalls():Void
    {
        //trace("processPendingCalls()");

        // Calls order is important
        var len = pendingCalls.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var data = pendingCalls[i];
            if (data.func != "showExInfo")
                trace("deferred");
            call(data.func, data.args, data.pre);
            delete data;
        }
        pendingCalls = null;
    }

    /**
     * Translate function call to subject or save in pending calls if subject is not created yet
     * @param	func    Name of function
     * @param	args    Array of arguments
     */
    private function call(func:String, args:Array, pre:Function)
    {
        if (func != "showExInfo")
            trace("call(): " + func + (args ? " [" + args.join(", ") + "]" : ""));

        if (subject != null)
        {
            if (pre)
                pre();
            return subject[func].apply(subject, args);
        }
        else
        {
            if (!pendingCalls)
                pendingCalls = [];
            pendingCalls.push( { func:func, args:args, pre: pre } );
        }
    }

    /**
     * Configured marker type
     */

    private function get IsStandardMarker()
    {
        return subject != null && Config.config.markers.useStandardMarkers == true;
    }

    private function get IsXvmMarker()
    {
        return subject != null && Config.config.markers.useStandardMarkers != true;
    }

    /**
     * called by Battle.pyc
     */
    public function init(vClass:String, vIconSource:String, vType:String, vLevel:Number,
        pFullName:String, pName:String, pClan:String, pRegion:String,
        curHealth:Number, maxHealth:Number, entityName:String, speaking:Boolean, hunt:Boolean, entityType:String):Void
    {
        /**
         * Invoked on new marker creation.
         * Does not get invoked on Alt or unit death.
         */
        m_vehicleName = vType;
        m_level = vLevel;
        m_playerName = pName;
        m_playerClan = pClan;
        m_playerRegion = pRegion;
        m_playerFullName = pFullName;
        m_defaultIconSource = vIconSource;
        m_vehicleClass = vClass;
        m_curHealth = curHealth;
        m_dead = m_curHealth <= 0;

        // for markers, hitlog and hpleft
        var wr = wrapper;
        var registerMacros = function()
        {
            Macros.RegisterPlayerData(Utils.GetPlayerName(pFullName),
            {
                label: pFullName,
                vehicle: vType,
                icon: vIconSource,
                squad: entityName == "squadman" ? "1" : "",
                level: vLevel,
                vtype: Utils.vehicleClassToVehicleType(vClass),
                maxHealth: maxHealth
            }, wr.m_team == "ally" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);
        };

        if (Config.config && !subject)
            initializeSubject();
        if (wrapper.m_team == "enemy")
        {
            logLists.onNewMarkerCreated(vClass, vIconSource, vType, vLevel, pFullName, pName, pClan, pRegion, curHealth, maxHealth);
        }
        call("init", [ vClass, vIconSource, vType, vLevel, pFullName, pName, pClan, pRegion, curHealth, maxHealth, entityName, speaking, hunt, entityType ], registerMacros);
    }

    public function update():Void { return call("update", arguments); }
    public function updateMarkerSettings():Void { return call("updateMarkerSettings", arguments); }
    public function setSpeaking(value:Boolean):Void { return call("setSpeaking", arguments); }
    public function setEntityName(value:String):Void { return call("setEntityName", arguments); }

    public function updateHealth(curHealth:Number, flag:Number, damageType:String):Void
    {
        if (curHealth <= 0)
            m_dead = true;

        var curHealthAbsolute:Number = (curHealth < 0 ? 0 : curHealth);

        if (wrapper.m_team == "enemy") /** Omit allies */
        {
            if (logLists != null)
            {
                var delta = m_curHealth - curHealthAbsolute;
                var vdata = VehicleInfo.getByIcon(m_defaultIconSource);
                logLists.onHpUpdate(flag, delta, curHealth,
                    vdata.localizedName,
                    m_defaultIconSource,
                    m_playerFullName, m_level, damageType,
                    Config.config.texts.vtype[vdata.vtype],
                    GraphicsUtil.GetVTypeColorValue(m_defaultIconSource),
                    m_dead, curHealthAbsolute);
            }
        }
        m_curHealth = curHealthAbsolute;

        return call("updateHealth", arguments);
    }

    public function updateState(newState:String, isImmediate:Boolean):Void
    {
        if (newState == "dead")
        {
            m_dead = true;

            /**
             * updateState is sufficient for logDead routine.
             *
             * Method is invoked both on new marker created being already dead
             * and present marker becoming dead at some point in time.
             */
            UnitDestroyedAccounting.instance.logDead(m_playerFullName);
        }
        return call("updateState", arguments);
    }

    public function showExInfo(show:Boolean):Void
    {
        GlobalEventDispatcher.dispatchEvent(new VMMEvent(VMMEvent.ALT_STATE_INFORM, show));
        return call("showExInfo", arguments);
    }
    public function showActionMarker(actionState):Void { return call("showActionMarker", arguments); }

    //public function settingsUpdate()              { return call("settingsUpdate", arguments); }
    //public function onSplashHidden()              { return call("onSplashHidden", arguments); }
    //public function layoutParts()                 { return call("layoutParts", arguments); }
    //public function __get__colorsManager()        { return call("__get__colorsManager", arguments); }
    //public function __get__colorSchemeName()      { return call("__get__colorSchemeName", arguments); }
    //public function __get__vehicleDestroyed()     { return call("__get__vehicleDestroyed", arguments); }
    //public function __get__isEnabledExInfo()      { return call("__get__isEnabledExInfo", arguments); }
    //public function isSpeaking()                  { return call("isSpeaking", arguments); }
    //public function getMarkerState()              { return call("getMarkerState", arguments); }
    //public function setMarkerState()              { return call("setMarkerState", arguments); }
    //public function getPartVisibility()           { return call("getPartVisibility", arguments); }
    //public function getNameText()                 { return call("getNameText", arguments); }
    //public function getHelthText()                { return call("getHelthText", arguments); }
    //public function getHealthPercents()           { return call("getHealthPercents", arguments); }
    //public function configUI()                    { return call("configUI", arguments); }
    //public function draw():Void                   { return call("draw", arguments); }
    //public function setupIconLoader()             { return call("setupIconLoader", arguments); }
    //public function populateData()                { return call("populateData", arguments); }
    //public function setVehicleClass()             { return call("setVehicleClass", arguments); }
    //public function initMarkerLabel()             { return call("initMarkerLabel", arguments); }
    //public function updateMarkerLabel()           { return call("updateMarkerLabel", arguments); }
    //public function _centeringIcon()              { return call("_centeringIcon", arguments); }
    //public function _onCompleteLoad()             { return call("_onCompleteLoad", arguments); }
    //public function _getVehicleClassName()        { return call("_getVehicleClassName", arguments); }
    //public function __get__exInfo()               { return call("__get__exInfo", arguments); }
    //public function __set__exInfo()               { return call("__set__exInfo", arguments); }
    //public function __get__markerSettings()       { return call("__get__markerSettings", arguments); }
    //public function __set__markerSettings()       { return call("__set__markerSettings", arguments); }

    public function onLoad()                      { return call("onLoad", arguments); }
    //public function __get__disabled()             { return call("__get__disabled", arguments); }
    //public function __set__disabled()             { return call("__set__disabled", arguments); }
    //public function __get__visible()              { return call("__get__visible", arguments); }
    //public function __set__visible()              { return call("__set__visible", arguments); }
    //public function __get__width()                { return call("__get__width", arguments); }
    //public function __set__width()                { return call("__set__width", arguments); }
    //public function __get__height()               { return call("__get__height", arguments); }
    //public function __set__height()               { return call("__set__height", arguments); }
    //public function setSize()                     { return call("setSize", arguments); }
    //public function __get__focused()              { return call("__get__focused", arguments); }
    //public function __set__focused()              { return call("__set__focused", arguments); }
    //public function __get__displayFocus()         { return call("__get__displayFocus", arguments); }
    //public function __set__displayFocus()         { return call("__set__displayFocus", arguments); }
    //public function handleInput()                 { return call("handleInput", arguments); }
    //public function invalidate()                  { return call("invalidate", arguments); }
    //public function validateNow()                 { return call("validateNow", arguments); }
    //public function toString()                    { return call("toString", arguments); }
    //public function initSize()                    { return call("initSize", arguments); }
    //public function changeFocus()                 { return call("changeFocus", arguments); }
    //public function onMouseWheel()                { return call("onMouseWheel", arguments); }
    //public function scrollWheel()                 { return call("scrollWheel", arguments); }

    ///**
     //* Ingame original WG marker settings.
     //*
     //* Five methods below are called when player touches some marker setting
     //* at ingame marker setting menu.
     //*
     //* settingsUpdate() is new method in 0.8.0.
     //*
     //* For XVM - do nothing.
     //*/
    //public function settingsUpdate(flag):Void
    //{
        //if (IsStandardMarker)
            //call("settingsUpdate", [ flag ]);
    //}
//
    // IUIComponent implementation
//
    //public function get visible():Boolean            { return base.visible; }
    //public function set visible(value:Boolean):Void  { base.visible = subject.visible = value; }
    //public function get disabled():Boolean           { return base.disabled; }
    //public function set disabled(value:Boolean):Void { base.disabled = subject.disabled = value; }
//
    //public function configUI():Void    { call("configUI"); }
//
    //public function validateNow():Void
    //{
        //base.validateNow();
        //call("validateNow");
    //}
//
    //
    //public function setSize(width:Number, height:Number):Void { call("setSize", [ width, height ]); }
    //
    // VehicleMarker wrappers for settings dialog with standard markers
//
    //public function invalidate():Void
    //{
        //if (IsStandardMarker)
            //subject.invalidate();
    //}
//
    //private function setMarkerState(value):Void
    //{
        //if (IsStandardMarker)
            //subject["setMarkerState"](value);
    //}
//
    //private function get exInfo():Boolean
    //{
        //if (IsStandardMarker)
            //return subject["exInfo"];
    //}
    //private function set exInfo(value:Boolean):Void
    //{
        //if (IsStandardMarker)
            //subject["exInfo"] = value;
    //}
    //private function get markerSettings()
    //{
        //if (IsStandardMarker)
            //return subject["markerSettings"];
    //}
    //private function set markerSettings(value)
    //{
        //if (IsStandardMarker)
            //subject["markerSettings"] = value;
    //}
//
    ///**
     //* TODO: not all is required, remove unused.
     //*/
//
    //public function get width():Number{
        //trace("*** get width()");
        //return subject.width;
    //}
    //public function set width(value:Number):Void{
        //trace("*** set width()");
        //subject.width = value;
    //}
//
    //public function get height():Number{
        //trace("*** get height()");
        //return subject.height;
    //}
    //public function set height(value:Number):Void{
        //trace("*** set height()");
        //subject.height = value;
    //}
//
    //public function get focused():Boolean{
        //trace("*** get focused()");
        //return subject.focused;
    //}
    //public function set focused(value:Boolean):Void{
        //trace("*** set focused()");
        //subject.focused = value;
    //}
//
    //public function get displayFocus():Boolean{
        //trace("*** get displayFocus()");
        //return subject.displayFocus;
    //}
    //public function set displayFocus(value:Boolean):Void
    //{
        //trace("*** set displayFocus()");
        //subject.displayFocus = value;
    //}
//
    //public function handleInput(details, pathToFocus):Void {
        //trace("*** handleInput()");
        //call("handleInput", [ details, pathToFocus ]);
    //}
//
    //public function toString():String {
        //trace("*** toString()");
        //return "[proxy]" + (subject != null ? subject.toString() : "[(null)]");
    //}
//
    //public function initSize():Void {
        //trace("*** initSize()");
        //call("initSize");
    //}
//
    //public function draw():Void {
        //trace("*** draw()");
        //base.draw();
        //call("draw");
    //}
//
    //public function changeFocus():Void {
        //trace("*** changeFocus()");
        //call("changeFocus");
    //}
//
    //public function onMouseWheel(delta:Number, target:Object):Void {
        //trace("*** onMouseWheel()");
        //call("onMouseWheel", [ delta, target ]);
    //}
//
    //public function scrollWheel(delta:Number):Void {
        //trace("*** scrollWheel()");
        //call("scrollWheel", [ delta ]);
    //}
//
//
//
//
//
///*
    //function onSplashHidden(event)
    //{
        //trace("*** onSplashHidden()");
    //} // End of the function
//
    //function layoutParts(partsVisArray)
    //{
        //trace("*** layoutParts()");
    //} // End of the function
//
    //function get colorsManager()
    //{
        //trace("*** colorsManager()");
    //} // End of the function
    //function get colorSchemeName()
    //{
        //trace("*** colorSchemeName()");
    //} // End of the function
    //function get vehicleDestroyed()
    //{
        //trace("*** vehicleDestroyed()");
    //} // End of the function
    //function get isEnabledExInfo()
    //{
        //trace("*** isEnabledExInfo()");
    //} // End of the function
    //function isSpeaking()
    //{
        //trace("*** isSpeaking()");
    //} // End of the function
    //function getMarkerState()
    //{
        //trace("*** getMarkerState()");
    //} // End of the function
    //function getPartVisibility(part)
    //{
        //trace("*** getPartVisibility()");
    //} // End of the function
    //function getNameText(part)
    //{
        //trace("*** getNameText()");
    //} // End of the function
    //function getHelthText()
    //{
        //trace("*** getHelthText()");
    //} // End of the function
    //function getHealthPercents()
    //{
        //trace("*** getHealthPercents()");
    //} // End of the function
    //function setupIconLoader()
    //{
        //trace("*** setupIconLoader()");
    //} // End of the function
    //function populateData()
    //{
        //trace("*** populateData()");
    //} // End of the function
    //function setVehicleClass()
    //{
        //trace("*** setVehicleClass()");
    //} // End of the function
    //function initMarkerLabel()
    //{
        //trace("*** initMarkerLabel()");
    //} // End of the function
    //*/
    //function updateMarkerLabel()
    //{
        //trace("*** updateMarkerLabel()");
        //call("updateMarkerLabel", arguments);
    //}
    ///*
    //function _centeringIcon()
    //{
        //trace("*** _centeringIcon()");
    //} // End of the function
    //function _getVehicleClassName()
    //{
        //trace("*** _getVehicleClassName()");
    //} // End of the function
//*/
}
