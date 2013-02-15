/**
 * Proxy class for vehicle marker components
 * Dispatches event for config loading if it is not loaded
 */
import gfx.core.UIComponent;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.GraphicsUtil;
import wot.utils.Logger;
import wot.utils.Utils;
import wot.VehicleMarkersManager.IVehicleMarker;
import wot.VehicleMarkersManager.HitLog;
import wot.utils.VehicleInfo;

/* TODO:
 * Check for performance boost with marker object caching
 * http://sourcemaking.com/design_patterns/object_pool
 */

class wot.VehicleMarkersManager.VehicleMarkerProxy extends gfx.core.UIComponent implements IVehicleMarker
{
    // dummy var to avoid import warning
    private static var __dummy = Logger.dummy;

    // Private members
    var m_vehicleName:String;
    var m_level:Number;
    var m_playerFullName:String;
    var m_curHealth:Number;
    var m_defaultIconSource:String;
    var m_vehicleClass:String;
    var m_dead:Boolean;

    // Components
    private static var hitLog:HitLog = null;

    // Used in child classes VehicleMarkerAlly and VehicleMarkerEnemy
    // TODO: can include to interface as property?
    public var m_team:String; // values: ally, enemy (readonly)
    
    // Inherited from sprite
    // TODO: try to remove and create dynamically only with standard markers to improve performance
    public var levelIcon:MovieClip;
    public var iconLoader:net.wargaming.controls.UILoaderAlt;
    public var hp_mc:MovieClip;
    public var actionMarker:MovieClip;
    public var marker:MovieClip;
    public var hitLbl:UIComponent;
    public var hitExplosion:UIComponent;
    private var vNameField:TextField;
    private var pNameField:TextField;
    private var healthBar:MovieClip;
    private var bgShadow:MovieClip;

//    private static var subjects_free:Array = null;
//    private static var subjects:Object;

    /**
     * Instance of subject class with real implementation
     */
    private var subject: IVehicleMarker;

    /**
     * List of pending calls (missed while config is loading).
     * Records is object: { func:String, args:Array }
     */
    private var pendingCalls:Array;

//    private function trace(str:String):Void
//    {
//        //if (m_playerFullName == "...")
//        //Logger.add(m_playerFullName + "> " + str);
//    }

    /**
     * ctor()
     */
    var start;
    public function VehicleMarkerProxy()
    {
        start = new Date();
        //trace("VehicleMarkerProxy::ctor()");

        // ScaleForm optimization // FIXIT: is required?
        if (!_global.noInvisibleAdvance)
            _global.noInvisibleAdvance = true;

        subject = null;

        // Initialize UIComponent
        super();

        // Show module trace message (optimized for speed - only one call per battle)
        if (_global["__trace_vmm_done"] != true)
        {
            _global["__trace_vmm_done"] = true;
            Utils.TraceXvmModule("VehicleMarkerProxy");
        }

        // Check config
        if (Config.s_loaded != true)
        {
            // if not loaded:
            //   cleanup marker while config is loading
            pNameField._visible = false;
            marker._visible = false;
            healthBar._visible = false;
            bgShadow._visible = false;
            vNameField.text = "Loading...";
            //   register config load complete event
            GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
            //   start config loading
            Config.LoadConfig("VehicleMarkerProxy.as", undefined, true);
        }
        else
        {
            // if already loaded, skip config loading steps
            //if (m_playerFullName)
            //    initializeSubject();
        }
    }

    /**
     * Config load callback
     * Calls on config loading is complete. Calls always, even if config is missed or loading failed.
     */
    private function onConfigLoaded():Void
    {
        //trace("onConfigLoaded()");

        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);

        // Don't draw hitlog in hangar
        if (_root.loadingName != "hangar")
        {
            if (Config.s_config.hitLog.visible && hitLog == null)
                hitLog = new HitLog(Config.s_config.hitLog);
        }

        //if (!subjects_free && Config.s_config.battle.useStandardMarkers != true)
        //    createSubjects();

        // finalize initialization
        if (m_playerFullName && !subject)
            initializeSubject();
    }

    /*
    private function createSubjects()
    {
        subjects_free = [];
        subjects = { };
        for (var i = 0; i < 29; ++i)
            subjects_free.push(new wot.VehicleMarkersManager.Xvm());
    }
    */

    /**
     * Create subject class in depend of config setting
     */
    private function initializeSubject():Void
    {
        //trace("initializeSubject() st = " + Config.s_config.battle.useStandardMarkers);

        // Create marker class depending on config setting
        if (Config.s_config.battle.useStandardMarkers == true)
        {
            // re-enable vehicle type marker (required only for standard marker)
            marker._visible = true;
            // Create Standard marker
            subject = new net.wargaming.ingame.VehicleMarker();
            // Translate entity name to subject
            subject["m_entityName"] = m_team;
            // Save link to me in subject
            subject["_proxy"] = this;
            // Replace MovieClip.gotoAndStop (calling for changing marker type: squad, team killer, color blind, ...)
            subject["gotoAndStop"] = function(frame) {
                this["_proxy"].gotoAndStop(frame);
            };
        }
        else
        {
            //Logger.addObject(this, "this", 2);
            // Create XVM marker
/*
            if (!subjects.hasOwnProperty(m_playerFullName))
            {
                subjects[m_playerFullName] = subjects_free.length > 0 ? subjects_free.pop()
                    : new wot.VehicleMarkersManager.Xvm();
            }
            subject = subjects[m_playerFullName];
            subject["_proxy"] = this;
*/
            subject = new wot.VehicleMarkersManager.Xvm(this);
        }

        // Invoke all deferred method calls while config was loading
        if (pendingCalls.length > 0)
            processPendingCalls();
    }

    // override MovieClip
    // TODO: Check performance
    function onEnterFrame():Void
    {
        if (subject == null)
            return;

        var mc:MovieClip = MovieClip(subject);
        if (mc.onEnterFrame != null)
            mc.onEnterFrame();
    }

    // override MovieClip
    function gotoAndStop(frame:Object):Void
    {
        super.gotoAndStop(frame);

        if (Config.s_config.battle.useStandardMarkers == true)
        {
            // Fix marker position (team Killer for example)
            for (var childName in marker.marker)
            {
                marker.marker[childName]._x = 0;
                marker.marker[childName]._y = 16;
            }
            marker._x = 0;
            marker._y = -16;

            // Translate visual elements to subject
            //Logger.addObject(this);
            subject["marker"] = marker;
            subject["levelIcon"] = levelIcon;
            subject["iconLoader"] = iconLoader;
            iconLoader.addEventListener("complete", this, "_onCompleteLoad");
            subject["hp_mc"] = hp_mc;
            subject["actionMarker"] = actionMarker;
            subject["hitLbl"] = hitLbl;
            subject["hitExplosion"] = hitExplosion;
            subject["vNameField"] = vNameField;
            subject["pNameField"] = pNameField;
            subject["healthBar"] = healthBar;
            subject["bgShadow"] = bgShadow;
        }
        else
        {
            // Remove standard fields for XVM
            if (pNameField)
            {
                pNameField._visible = false;
//                pNameField.removeTextField();
//                delete pNameField;
            }

            if (vNameField)
            {
                vNameField._visible = false;
//                vNameField.removeTextField();
//                delete vNameField;
            }

            if (healthBar)
            {
                healthBar.stop();
                healthBar._visible = false;
//                healthBar.removeMovieClip();
//                delete healthBar;
            }

            if (hp_mc)
            {
                hp_mc.stop();
                hp_mc._visible = false;
//                hp_mc.removeMovieClip();
//                delete hp_mc;
            }

            if (hitLbl)
            {
                hitLbl.stop();
                hitLbl._visible = false;
//                hitLbl.removeMovieClip();
//                delete hitLbl;
            }

            if (hp_mc)
            {
                hp_mc.stop();
                hp_mc._visible = false;
//                hp_mc.removeMovieClip();
//                delete hp_mc;
            }
        }
    }

    private function _onCompleteLoad():Void
    {
        this.iconLoader.visible = this.subject["getPartVisibility"]("Icon");
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
            call(data.func, data.args);
            delete data;
        }
        pendingCalls = null;
    }

    /**
     * Translate function call to subject or save in pending calls if subject is not created yet
     * @param	func    Name of function
     * @param	args    Array of arguments
     */
    private function call(func:String, args:Array):Void
    {
        //if (func != "showExInfo")
        //    trace("call(): " + func + (args ? " [" + args.join(", ") + "]" : ""));

        if (subject != null)
            subject[func].apply(subject, args);
        else
        {
            if (!pendingCalls)
                pendingCalls = [];
            pendingCalls.push( { func:func, args:args } );
        }
    }

    /**
     * IVehicleMarker implementation
     */

    // called by Battle.pyc
    public function init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt, entityType)
    {
        //trace("init: " + pFullName);
        m_vehicleName = vType;
        m_level = vLevel;
        m_playerFullName = pFullName;
        m_defaultIconSource = vIconSource;
        m_vehicleClass = vClass;
        m_curHealth = curHealth;
        m_dead = m_curHealth <= 0;
        if (Config.s_loaded == true && !subject)
            initializeSubject();
        call("init", [ vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt, entityType ]);
    }

    /**
     * called by Battle.pyc
     */
    public function update()                      { call("update"); }
    public function updateMarkerSettings()        { call("updateMarkerSettings"); }
    public function setSpeaking(value)            { call("setSpeaking",      [ value ]); }
    public function setEntityName(value)          { call("setEntityName",    [ value ]); }
    public function showExInfo(show)              { call("showExInfo",       [ show ]); }
    public function showActionMarker(actionState) { call("showActionMarker", [ actionState ]); }

    public function updateState(newState, isImmediate)
    {
        if (newState == "dead")
            m_dead = true;
        call("updateState",  [ newState, isImmediate ]);
    }

    public function updateHealth(curHealth, flag, damageType)
    {
        if (curHealth <= 0)
            m_dead = true;

        if (flag == Defines.FROM_PLAYER && m_team == "enemy" && hitLog != null) // do not calculate friendly fire
        {
            var delta = m_curHealth - (curHealth < 0 ? 0 : curHealth);
            hitLog.update(delta, curHealth,
                VehicleInfo.mapVehicleName(m_defaultIconSource, m_vehicleName),
				m_defaultIconSource,
                m_playerFullName, m_level, damageType,
                VehicleInfo.GetVTypeValue(m_defaultIconSource),
                GraphicsUtil.GetVTypeColorValue(m_defaultIconSource),
                m_dead);
        }
        m_curHealth = curHealth < 0 ? 0 : curHealth;
        call("updateHealth", [ curHealth, flag, damageType ]);
    }

    /**
     * Ingame original WG marker settings.
     *
     * Five methods below are called when player touches some marker setting
     * at ingame marker setting menu.
     *
     * settingsUpdate() is new method in 0.8.0.
     *
     * For XVM - do nothing.
     */
    public function settingsUpdate(flag) { call("settingsUpdate", [ flag ]); }
    public function get visible()  { return super.visible; }
    public function set visible(value)  { super.visible = subject.visible = value; }
    public function get disabled() { return super.disabled; }
    public function set disabled(value) { super.disabled = subject.disabled = value; }

    // IUIComponent implementation

    public function configUI()    { call("configUI"); }
    public function onLoad() {
//Logger.add("onLoad: " + Utils.elapsedMSec(start, new Date()) + " ms");
        call("onLoad");
    }
    public function validateNow() { call("validateNow"); }
    public function setSize(width, height) { call("setSize", [ width, height ]); }

    // VehicleMarker wrappers for settings dialog with standard markers
    public function invalidate()
    {
        if (Config.s_config.battle.useStandardMarkers == true && subject != null)
            subject["invalidate"]();
    }
    private function setMarkerState(value)
    {
        if (Config.s_config.battle.useStandardMarkers == true && subject != null)
            subject["setMarkerState2"](value);
    }
    private function get exInfo()
    {
        if (Config.s_config.battle.useStandardMarkers == true && subject != null)
            return subject["exInfo"];
    }
    private function set exInfo(value)
    {
        if (Config.s_config.battle.useStandardMarkers == true && subject != null)
            subject["exInfo"] = value;
    }
    private function get markerSettings()
    {
        if (Config.s_config.battle.useStandardMarkers == true && subject != null)
            return subject["markerSettings"];
    }
    private function set markerSettings(value)
    {
        if (Config.s_config.battle.useStandardMarkers == true && subject != null)
            subject["markerSettings"] = value;
    }

    /**
     * TODO: not all is required, remove unused.
     */

    public function get width(){
        //trace("*** get width()");
        return subject.width;
    }
    public function set width(value){
        //trace("*** set width()");
        subject.width = value;
    }

    public function get height(){
        //trace("*** get height()");
        return subject.height;
    }
    public function set height(value){
        //trace("*** set height()");
        subject.height = value;
    }

    public function get focused(){
        //trace("*** get focused()");
        return subject.focused;
    }
    public function set focused(value){
        //trace("*** set focused()");
        subject.focused = value;
    }

    public function get displayFocus(){
        //trace("*** get displayFocus()");
        return subject.displayFocus;
    }
    public function set displayFocus(value)
    {
        //trace("*** set displayFocus()");
        subject.displayFocus = value;
    }

    public function handleInput(details, pathToFocus) {
        //trace("*** handleInput()");
        call("handleInput", [ details, pathToFocus ]);
    }

    public function toString() {
        //trace("*** toString()");
        return "[proxy]" + (subject != null ? subject.toString() : "[(null)]");
    }

    public function initSize() {
        //trace("*** initSize()");
        call("initSize");
    }

    public function draw() {
        //trace("*** draw()");
        call("draw");
    }

    public function changeFocus() {
        //trace("*** changeFocus()");
        call("changeFocus");
    }

    public function onMouseWheel(delta, target) {
        //trace("*** onMouseWheel()");
        call("onMouseWheel", [ delta, target ]);
    }

    public function scrollWheel(delta) {
        //trace("*** scrollWheel()");
        call("scrollWheel", [ delta ]);
    }





/*
    function onSplashHidden(event)
    {
        trace("*** onSplashHidden()");
    } // End of the function

    function layoutParts(partsVisArray)
    {
        trace("*** layoutParts()");
    } // End of the function

    function get colorsManager()
    {
        trace("*** colorsManager()");
    } // End of the function
    function get colorSchemeName()
    {
        trace("*** colorSchemeName()");
    } // End of the function
    function get vehicleDestroyed()
    {
        trace("*** vehicleDestroyed()");
    } // End of the function
    function get isEnabledExInfo()
    {
        trace("*** isEnabledExInfo()");
    } // End of the function
    function isSpeaking()
    {
        trace("*** isSpeaking()");
    } // End of the function
    function getMarkerState()
    {
        trace("*** getMarkerState()");
    } // End of the function
    function getPartVisibility(part)
    {
        trace("*** getPartVisibility()");
    } // End of the function
    function getNameText(part)
    {
        trace("*** getNameText()");
    } // End of the function
    function getHelthText()
    {
        trace("*** getHelthText()");
    } // End of the function
    function getHealthPercents()
    {
        trace("*** getHealthPercents()");
    } // End of the function
    function setupIconLoader()
    {
        trace("*** setupIconLoader()");
    } // End of the function
    function populateData()
    {
        trace("*** populateData()");
    } // End of the function
    function setVehicleClass()
    {
        trace("*** setVehicleClass()");
    } // End of the function
    function initMarkerLabel()
    {
        trace("*** initMarkerLabel()");
    } // End of the function
    function updateMarkerLabel()
    {
        trace("*** updateMarkerLabel()");
    } // End of the function
    function _centeringIcon()
    {
        trace("*** _centeringIcon()");
    } // End of the function
    function _getVehicleClassName()
    {
        trace("*** _getVehicleClassName()");
    } // End of the function
*/
}
