/**
 * Proxy class for vehicle marker components
 * Dispatches event for config loading if it is not loaded
 * Draws XVM version watermark
 */
import gfx.core.UIComponent;
import wot.VehicleMarkersManager.IVehicleMarker;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.Utils;

/* TODO:
 * Check for performance boost with marker object caching
 * http://sourcemaking.com/design_patterns/object_pool
 */

class wot.VehicleMarkersManager.VehicleMarkerProxy extends gfx.core.UIComponent implements IVehicleMarker
{
    // dummy var to avoid import warning
    private static var __dummy = Logger.dummy;

    // Used in child classes VehicleMarkerAlly and VehicleMarkerEnemy
    // TODO: can include to interface as property?
    public var m_entityName:String; // protected

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
    
    /**
     * Instance of subject class with real implementation
     */
    private var subject: IVehicleMarker;

    /**
     * List of pending calls (missed while config is loading).
     * Records is object: { func:String, args:Array }
     */ 
    private var pendingCalls:Array;

    private function trace(str:String):Void
    {
        //if (this["_playerName"] == "dosik_dai")
        Logger.add(this["_playerName"] + "> " + str);
    }
    
    /**
     * ctor()
     */
    public function VehicleMarkerProxy()
    {
        //Logger.add("VehicleMarkerProxy::ctor()");
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
            initializeSubject();
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

        // Draw watermark
        if (!Config.s_config.battle.hideXVMVersion && !_global.xvmWatermark)
            DrawXvmWatermark();

        // re-enable vehicle type marker (required only for standard marker)
        marker._visible = true;

        // finalize initialization
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
        {
            // Create Standard marker
            subject = new net.wargaming.ingame.VehicleMarker()
            // Translate entity name to subject
            subject["m_entityName"] = m_entityName;
            // Save link to me in subject
            subject["_proxy"] = this;
            // Replace MovieClip.gotoAndStop (calling for changing marker type: squad, team killer, color blind, ...)
            subject["gotoAndStop"] = function(frame) {
                this["_proxy"].gotoAndStop(frame);

                // FIXIT: this is required for properly working of dead's markers. Is there another way to do it?
                if (this["m_markerState"] != null)
                    this["marker"].gotoAndPlay(this["m_markerState"]);
            };
        }
        else
        {
            // Create XVM marker
            subject = new wot.VehicleMarkersManager.XVM(this, m_entityName);
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
        if (mc.hasOwnProperty("onEnterFrame"))
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
                pNameField.removeTextField();
                delete pNameField;
            }

            if (vNameField)
            {
                vNameField._visible = false;
                vNameField.removeTextField();
                delete vNameField;
            }

            if (healthBar)
            {
                healthBar.stop();
                healthBar._visible = false;
                healthBar.removeMovieClip();
                delete healthBar;
            }

            if (hp_mc)
            {
                hp_mc.stop();
                hp_mc._visible = false;
                hp_mc.removeMovieClip();
                delete hp_mc;
            }

            if (hitLbl)
            {
                hitLbl.stop();
                hitLbl._visible = false;
                hitLbl.removeMovieClip();
                delete hitLbl;
            }

            if (hp_mc)
            {
                hp_mc.stop();
                hp_mc._visible = false;
                hp_mc.removeMovieClip();
                delete hp_mc;
            }
        }
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
     * Draw XVM version at top left corner
     */
    function DrawXvmWatermark()
    {
        _global.xvmWatermark = true;
        var wm = _root.createTextField("xvmWatermark", _root.getNextHighestDepth(), -1, -2, 100, 16);
        wm.antiAliasType = "advanced";
        wm.setNewTextFormat(new TextFormat("$FieldFont", 8, 0x808080, false, false, false, null, null, "left"));
        wm._alpha = 50;
        wm.text = "XVM v" + Defines.XVM_VERSION;
    }
    
    /**
     * IVehicleMarker implementation
     */

    // called by Battle.pyc
    public function init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt, entityType)
    {
        //Logger.add("init: " + pFullName);
        this["_playerName"] = pFullName; // for debug
        call("init",   [ vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt, entityType ]);
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
    public function updateHealth(curHealth, flag, damageType)
                                                  { call("updateHealth", [ curHealth, flag, damageType ]); }
    public function updateState(newState, isImmediate)
                                                  { call("updateState",  [ newState, isImmediate ]);}

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
    public function get visible()  { return subject.visible; }
    public function set visible(value)  {   subject.visible  = value; }
    public function get disabled() { return subject.disabled; }
    public function set disabled(value) {   subject.disabled = value; }
    
    // IUIComponent implementation
    
    public function configUI()    { call("configUI"); }
    public function validateNow() { call("validateNow"); }
    
    /**
     * TODO: not all is required, remove unused.
     */

    public function get width(){
        trace("*** get width()");
        return subject.width;
    }
    public function set width(value){
        trace("*** set width()");
        subject.width = value;
    }

    public function get height(){
        trace("*** get height()");
        return subject.height;
    }
    public function set height(value){
        trace("*** set height()");
        subject.height = value;
    }

    public function setSize(width, height){
        call("setSize", [ width, height ]);
    }

    public function get focused(){
        trace("*** get focused()");
        return subject.focused;
    }
    public function set focused(value){
        trace("*** set focused()");
        subject.focused = value;
    }

    public function get displayFocus(){
        trace("*** get displayFocus()");
        return subject.displayFocus;
    }
    public function set displayFocus(value)
    {
        trace("*** set displayFocus()");
        subject.displayFocus = value;
    }

    public function handleInput(details, pathToFocus) {
        trace("*** handleInput()");
        call("handleInput", [ details, pathToFocus ]);
    }

    public function invalidate() {
        trace("*** invalidate()");
        call("invalidate");
    }

    public function toString() {
        trace("*** toString()");
        return "[proxy]" + (subject != null ? subject.toString() : "[(null)]");
    }

    public function initSize() {
        trace("*** initSize()");
        call("initSize");
    }

    public function draw() {
        trace("*** draw()");
        call("draw");
    }

    public function changeFocus() {
        trace("*** changeFocus()");
        call("changeFocus");
    }

    public function onMouseWheel(delta, target) {
        trace("*** onMouseWheel()");
        call("onMouseWheel", [ delta, target ]);
    }

    public function scrollWheel(delta) {
        trace("*** scrollWheel()");
        call("scrollWheel", [ delta ]);
    }
}
