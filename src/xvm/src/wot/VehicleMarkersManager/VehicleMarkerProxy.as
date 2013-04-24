/**
 * Proxy class for vehicle marker components
 * Dispatches event for config loading if it is not loaded
 */
import gfx.core.UIComponent;
import net.wargaming.controls.UILoaderAlt;
import com.xvm.Config;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.GraphicsUtil;
import com.xvm.Logger;
import com.xvm.Sandbox;
import com.xvm.Utils;
import com.xvm.VehicleInfo;
import wot.VehicleMarkersManager.HitLog;
import wot.VehicleMarkersManager.IVehicleMarker;

/* TODO:
 * Check for performance boost with marker object caching
 * http://sourcemaking.com/design_patterns/object_pool
 */

class wot.VehicleMarkersManager.VehicleMarkerProxy implements IVehicleMarker
{
    private function trace(str:String):Void
    {
        //if (m_playerFullName == "...")
        Logger.add(m_playerFullName + "> " + str);
    }

    /////////////////////////////////////////////////////////////////

    public var wrapper:net.wargaming.ingame.VehicleMarker;
    private var base:net.wargaming.ingame.VehicleMarker;

    public function VehicleMarkerProxy(wrapper:net.wargaming.ingame.VehicleMarker, base:net.wargaming.ingame.VehicleMarker)
    {
        this.wrapper = wrapper;
        this.base = base;

        Utils.TraceXvmModule("VMM");

        VehicleMarkerProxyCtor();
    }

    /////////////////////////////////////////////////////////////////

    // Private members
    private var m_vehicleName:String;
    private var m_level:Number;
    private var m_playerFullName:String;
    private var m_curHealth:Number;
    private var m_defaultIconSource:String;
    private var m_vehicleClass:String;
    private var m_dead:Boolean;

    // Components
    private static var hitLog:HitLog = null;

    // Used in child classes VehicleMarkerAlly and VehicleMarkerEnemy
    // TODO: include to interface as property?
    public var m_team:String; // values: ally, enemy (readonly)

    // Inherited from sprite
    // TODO: try to remove and create dynamically only with standard markers to improve performance
    public var levelIcon:MovieClip;
    public var iconLoader:UILoaderAlt;
    public var actionMarker:MovieClip;
    public var marker:MovieClip;
    // this fields are not required in the XVM marker, and will be removed
    private var hp_mc:MovieClip;
    private var hitLbl:UIComponent;
    private var hitExplosion:UIComponent;
    private var vNameField:TextField;
    private var pNameField:TextField;
    private var healthBar:MovieClip;
    private var bgShadow:MovieClip;

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
    public function VehicleMarkerProxyCtor()
    {
        start = new Date();
        //trace("VehicleMarkerProxy::ctor()");

        // ScaleForm optimization // FIXIT: is required?
        if (!_global.noInvisibleAdvance)
            _global.noInvisibleAdvance = true;

        subject = null;

        var wr:net.wargaming.ingame.VehicleMarker = net.wargaming.ingame.VehicleMarker(wrapper);
        levelIcon = wr.levelIcon;
        iconLoader = wr.iconLoader;
        hp_mc = wr.hp_mc;
        actionMarker = wr.actionMarker;
        marker = wr.marker;
        hitLbl = wr.hitLbl;
        hitExplosion = wr.hitExplosion;
        vNameField = wr.vNameField;
        pNameField = wr.pNameField;
        healthBar = wr.healthBar;
        bgShadow = wr.bgShadow;

        // Check config
        if (Config.s_loaded != true)
        {
            // if not loaded:
            //   cleaning the marker until the configuration is loaded
            pNameField._visible = false;
            marker._visible = false;
            healthBar._visible = false;
            bgShadow._visible = false;
            vNameField.text = "Loading...";
            //   register config load complete event
            GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
            //   start config loading
            Config.LoadConfig("VehicleMarkerProxy.as");
        }
        else
        {
            // if already loaded, initialize immediately
            initialize();
        }
    }

    // TODO: Check performance
    function onEnterFrame():Void
    {
        if (subject == null)
            return;
        var mc:MovieClip = MovieClip(subject);
        if (mc.onEnterFrame != null)
            mc.onEnterFrame();
    }

    function gotoAndStop(frame:Object):Void
    {
        base.gotoAndStop(frame);

        if (IsStandardMarker)
            setupFrameStandardMarker();
        else
            setupFrameXvmMarker();
    }

    private function setupFrameStandardMarker()
    {
        // Translate visual elements to subject
        //Logger.addObject(this);
        subject["marker"] = marker;
        subject["levelIcon"] = levelIcon;
        subject["iconLoader"] = iconLoader;
//        iconLoader.addEventListener("complete", this, "_onCompleteLoad");
        subject["hp_mc"] = hp_mc;
        subject["actionMarker"] = actionMarker;
        subject["hitLbl"] = hitLbl;
        subject["hitExplosion"] = hitExplosion;
        subject["vNameField"] = vNameField;
        subject["pNameField"] = pNameField;
        subject["healthBar"] = healthBar;
        subject["bgShadow"] = bgShadow;
    }

    private function setupFrameXvmMarker()
    {
    ///**
     //* Quick dirty partial fix of alive markers bad positioning at FragCorrelationBar.
     //* Positioning is broken because of VehicleMarkersManager.xml.patch
     //*/
    //private static function fixFragCorellationBarOffset():Void
    //{
        //_root.fragCorrelationBar.enemyMarkers.drawRenderers =
        //_root.fragCorrelationBar.alliedMarkers.drawRenderers =
        //function(resetPrevData)
        //{
            ///** Original WG code */
            //for (var i = 0; i < this.__get__dataProvider().length; ++i)
            //{
                //this.createItemRenderer(this.__get__dataProvider()[i], resetPrevData);
            //}
            //
            ///** Extra XVM code */
            //for (var vid in this.vIdToRenderer)
            //{
                //var renderer = this.vIdToRenderer[vid];
                //if (renderer._data.isAlive)
                //{
                    //renderer._y = 16;
                    //renderer._x += 6;
                //}
            //}
        //}
    //}
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
    
    /**
     * Config load callback
     * Calls on config loading is complete. Calls always, even if config is missed or loading failed.
     */
    private function onConfigLoaded():Void
    {
        //trace("onConfigLoaded()");

        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        
        initialize();
    }

    private function initialize():Void
    {
        // Don't draw hitlog in hangar
        if (Sandbox.GetCurrentSandboxPrefix() == Sandbox.SANDBOX_HANGAR)
        {
            if (Config.s_config.hitLog.visible && hitLog == null)
                hitLog = new HitLog(Config.s_config.hitLog);
        }

        // finalize initialization
        if (m_playerFullName && !subject)
            initializeSubject();
    }

    /**
     * Create subject class in depend of config setting
     */
    private function initializeSubject():Void
    {
        //trace("initializeSubject() st = " + Config.s_config.battle.useStandardMarkers);

        // Create marker class depending on config setting
        if (Config.s_config.battle.useStandardMarkers == true)
            createStandardMarker();
        else
            createXvmMarker();

        // Invoke all deferred method calls while config was loading
        if (pendingCalls.length > 0)
            processPendingCalls();
    }

    private function createStandardMarker()
    {
        // re-enable vehicle type marker (required only for standard marker)
        marker._visible = true;
        // Create Standard marker
        var vm:net.wargaming.ingame.VehicleMarker = new net.wargaming.ingame.VehicleMarker();
        // Translate entity name to subject
        vm.m_entityName = m_team;
        // Save link to me in subject
        vm.xvm_proxy = this;
        // Replace MovieClip.gotoAndStop (calling for changing marker type: squad, team killer, color blind, ...)
        vm.gotoAndStop = function(frame) { this.xvm_proxy.wrapper.gotoAndStop(frame); };
        
        subject = vm;
    }
    
    private function createXvmMarker()
    {
        //Logger.addObject(this, "this", 2);
        subject = new wot.VehicleMarkersManager.Xvm(this);
    }

/*    private function _onCompleteLoad():Void
    {
        if (subject
        iconLoader.visible = this.subject["getPartVisibility"]("Icon");
    }*/

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
        if (func != "showExInfo" && func != "validateNow")
            trace("call(): " + func + (args ? " [" + args.join(", ") + "]" : ""));

        if (subject != null)
            subject[func].apply(subject, args);
        else
        {
            if (!pendingCalls)
                pendingCalls = [];
            pendingCalls.push( { func:func, args:args } );
        }
    }

    private function get IsStandardMarker()
    {
        return subject != null && Config.s_config.battle.useStandardMarkers == true;
    }

    private function get IsXvmMarker()
    {
        return subject != null && Config.s_config.battle.useStandardMarkers != true;
    }

    /**
     * IVehicleMarker implementation
     */

    /**
     * called by Battle.pyc
     */

    public function init(vClass:String, vIconSource:String, vType:String, vLevel:Number, pFullName:String,
        curHealth:Number, maxHealth:Number, entityName:String, speaking:Boolean, hunt:Boolean, entityType:String):Void
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

    public function update():Void                      { call("update"); }
    public function updateMarkerSettings():Void        { call("updateMarkerSettings"); }
    public function setSpeaking(value:Boolean):Void    { call("setSpeaking",      [ value ]); }
    public function setEntityName(value:String):Void   { call("setEntityName",    [ value ]); }

    public function updateHealth(curHealth:Number, flag:Number, damageType:String):Void
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

    public function updateState(newState:String, isImmediate:Boolean):Void
    {
        if (newState == "dead")
            m_dead = true;
        call("updateState",  [ newState, isImmediate ]);
    }

    public function showExInfo(show:Boolean):Void      { call("showExInfo",       [ show ]); }
    public function showActionMarker(actionState):Void { call("showActionMarker", [ actionState ]); }

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
    public function settingsUpdate(flag):Void
    {
        if (IsStandardMarker)
            call("settingsUpdate", [ flag ]);
    }

    // IUIComponent implementation

    public function get visible():Boolean            { return base.visible; }
    public function set visible(value:Boolean):Void  { base.visible = subject.visible = value; }
    public function get disabled():Boolean           { return base.disabled; }
    public function set disabled(value:Boolean):Void { base.disabled = subject.disabled = value; }

    public function onLoad():Void
    {
        //Logger.add("onLoad: " + Utils.elapsedMSec(start, new Date()) + " ms");
        call("onLoad");
    }

    public function configUI():Void    { call("configUI"); }
    
    public function setSize(width:Number, height:Number):Void { call("setSize", [ width, height ]); }
    
    public function validateNow():Void { call("validateNow"); }

    // VehicleMarker wrappers for settings dialog with standard markers

    public function invalidate():Void
    {
        if (IsStandardMarker)
            subject.invalidate();
    }

    private function setMarkerState(value):Void
    {
        if (IsStandardMarker)
            subject["setMarkerState"](value);
    }

    private function get exInfo():Boolean
    {
        if (IsStandardMarker)
            return subject["exInfo"];
    }
    private function set exInfo(value:Boolean):Void
    {
        if (IsStandardMarker)
            subject["exInfo"] = value;
    }
    private function get markerSettings()
    {
        if (IsStandardMarker)
            return subject["markerSettings"];
    }
    private function set markerSettings(value)
    {
        if (IsStandardMarker)
            subject["markerSettings"] = value;
    }

    /**
     * TODO: not all is required, remove unused.
     */

    public function get width():Number{
        //trace("*** get width()");
        return subject.width;
    }
    public function set width(value:Number):Void{
        //trace("*** set width()");
        subject.width = value;
    }

    public function get height():Number{
        //trace("*** get height()");
        return subject.height;
    }
    public function set height(value:Number):Void{
        //trace("*** set height()");
        subject.height = value;
    }

    public function get focused():Boolean{
        //trace("*** get focused()");
        return subject.focused;
    }
    public function set focused(value:Boolean):Void{
        //trace("*** set focused()");
        subject.focused = value;
    }

    public function get displayFocus():Boolean{
        //trace("*** get displayFocus()");
        return subject.displayFocus;
    }
    public function set displayFocus(value:Boolean):Void
    {
        //trace("*** set displayFocus()");
        subject.displayFocus = value;
    }

    public function handleInput(details, pathToFocus):Void {
        //trace("*** handleInput()");
        call("handleInput", [ details, pathToFocus ]);
    }

    public function toString():String {
        //trace("*** toString()");
        return "[proxy]" + (subject != null ? subject.toString() : "[(null)]");
    }

    public function initSize():Void {
        //trace("*** initSize()");
        call("initSize");
    }

    public function draw():Void {
        //trace("*** draw()");
        call("draw");
    }

    public function changeFocus():Void {
        //trace("*** changeFocus()");
        call("changeFocus");
    }

    public function onMouseWheel(delta:Number, target:Object):Void {
        //trace("*** onMouseWheel()");
        call("onMouseWheel", [ delta, target ]);
    }

    public function scrollWheel(delta:Number):Void {
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
        //trace("*** updateMarkerLabel()");
        call("updateMarkerLabel", arguments);
    }
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
