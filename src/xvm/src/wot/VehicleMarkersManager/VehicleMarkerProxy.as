/**
 * Proxy class for vehicle marker components
 */
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
    private var levelIcon:MovieClip;
    private var iconLoader:MovieClip;
    private var vNameField:TextField;
    private var pNameField:TextField;
    private var actionMarker:MovieClip;
    private var marker:MovieClip;
    private var healthBar:MovieClip;
    private var bgShadow:MovieClip;

    /**
     * Instanse of subject class with real implementation
     */
    private var subject: IVehicleMarker;

    /**
     * List of pending calls (missed while config is loading).
     * Records is object: { func:String, args:Array }
     */ 
    private var pendingCalls:Array;

    /**
     * Log trace
     * @param	str     Log message
     */
    /*private function trace(str:String):Void
    {
        if (this["_playerName"] == "dosik_dai")
        Logger.add(this["_playerName"] + "> " + str);
    }*/
    
    /**
     * ctor()
     */
    public function VehicleMarkerProxy()
    {
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
            //   start config loading
            Config.LoadConfig("VehicleMarkerProxy.as", undefined, true);
            //   register config load complete event
            GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
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
        trace("onConfigLoaded()");

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
        trace("initializeSubject()");

        // Create marker class depending on config setting
        subject = (Config.s_config.battle.useStandardMarkers == true)
            ? new net.wargaming.ingame.VehicleMarker() // Standard marker
            : new wot.VehicleMarkersManager.XVM(); // XVM marker

        // Translate entity name to subject
        subject["m_entityName"] = m_entityName;

        // Save link to me in subject
        subject["_proxy"] = this;

        // Replace MovieClip.gotoAndStop (calling for changing marker type: squad, team killer, color blind, ...)
        subject["gotoAndStop"] = function(frame) {
            //Logger.add(this["m_playerFullName"] + ": gotoAndStop(" + frame + ")");
            this["_proxy"].gotoAndStop(frame);
            this["_proxy"].bindStandardElements();
            // {{
            // FIXIT: this is required for properly working of dead's markers in standard marker. 
            if (this["m_markerState"] != null)
                this["marker"].gotoAndPlay(this["m_markerState"]);
            // }}
        };

        // Call all skipped steps
        if (pendingCalls.length > 0)
            processPendingCalls();
    }

    // TODO: review
    private function bindStandardElements():Void
    {
        // Fix marker position (required only for standard marker)
        for (var childName in marker.marker)
        {
            marker.marker[childName]._x = 0;
            marker.marker[childName]._y = 16;
        }
        marker._x = 0;
        marker._y = -16;

        // Translate visual elements to subject
        subject["marker"] = marker;
        subject["levelIcon"] = levelIcon;
        subject["iconLoader"] = iconLoader;
        subject["actionMarker"] = actionMarker;
        subject["vNameField"] = vNameField; // required only for standard marker
        subject["pNameField"] = pNameField; // required only for standard marker
        subject["healthBar"] = healthBar; // required only for standard marker
        subject["bgShadow"] = bgShadow; // required only for standard marker
    }
    
    /**
     * Call all skipped steps
     * subject must be created when this function is called
     */
    private function processPendingCalls():Void
    {
        trace("processPendingCalls()");

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
        if (func != "showExInfo")
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

    /**
     * called by Battle.pyc
     * @param	vClass
     * @param	vIconSource
     * @param	vType
     * @param	vLevel
     * @param	pFullName
     * @param	curHealth
     * @param	maxHealth
     * @param	entityName
     * @param	speaking
     * @param	hunt
     */
    public function init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt)
    {
        this["_playerName"] = pFullName; // for debug
        call("init", [ vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt ]);
    }

    /**
     * called by Battle.pyc
     */
    public function update()
    {
        call("update");
    }
    
    /**
     * called by Battle.pyc
     */
    public function updateMarkerSettings()
    {
        call("updateMarkerSettings");
    }
    
    /**
     * called by Battle.pyc
     * @param	value
     */
    public function setSpeaking(value)
    {
        call("setSpeaking", [ value ]);
    }
    
    /**
     * called by Battle.pyc
     * @param	value
     */
    public function setEntityName(value)
    {
        //Logger.add("setEntityName(" + value + ")");
        call("setEntityName", [ value ]);
    }
    
    /**
     * called by Battle.pyc
     * @param	curHealth
     */
    public function updateHealth(curHealth)
    {
        call("updateHealth", [ curHealth ]);
    }

    /**
     * called by Battle.pyc
     * @param	newState
     * @param	isImmediate
     */
    public function updateState(newState, isImmediate)
    {
        call("updateState", [ newState, isImmediate ]);
    }

    /**
     * called by Battle.pyc
     * @param	show
     */
    public function showExInfo(show)
    {
        call("showExInfo", [ show ]);
    }
    
    /**
     * called by Battle.pyc
     * @param	actionState
     */
    public function showActionMarker(actionState)
    {
        call("showActionMarker", [ actionState ]);
    }

    /**
     * IUIComponent implementation
     * TODO: not all is required, remove unused.
     */

    public function configUI()
    {
        call("configUI");
    }

    public function validateNow()
    {
        call("validateNow");
    }

    public function get disabled()
    {
        trace("*** get disabled()");
        return subject.disabled;
    }
    public function set disabled(value)
    {
        trace("*** set disabled()");
        subject.disabled = value;
    }

    public function get visible()
    {
        trace("*** get visible()");
        return subject.visible;
    }
    public function set visible(value)
    {
        trace("*** set visible()");
        subject.visible = value;
    }

    public function get width()
    {
        trace("*** get width()");
        return subject.width;
    }
    public function set width(value)
    {
        trace("*** set width()");
        subject.width = value;
    }

    public function get height()
    {
        trace("*** get height()");
        return subject.height;
    }
    public function set height(value)
    {
        trace("*** set height()");
        subject.height = value;
    }

    public function setSize(width, height)
    {
        call("setSize", [ width, height ]);
    }

    public function get focused()
    {
        trace("*** get focused()");
        return subject.focused;
    }
    public function set focused(value)
    {
        trace("*** set focused()");
        subject.focused = value;
    }

    public function get displayFocus()
    {
        trace("*** get displayFocus()");
        return subject.displayFocus;
    }
    public function set displayFocus(value)
    {
        trace("*** set displayFocus()");
        subject.displayFocus = value;
    }

    public function handleInput(details, pathToFocus)
    {
        call("handleInput", [ details, pathToFocus ]);
    }

    public function invalidate()
    {
        call("invalidate");
    }

    public function toString()
    {
        trace("*** toString()");
        return "[proxy]" + (subject != null ? subject.toString() : "[(null)]");
    }

    public function initSize()
    {
        call("initSize");
    }

    public function draw()
    {
        call("draw");
    }

    public function changeFocus()
    {
        call("changeFocus");
    }

    public function onMouseWheel(delta, target)
    {
        call("onMouseWheel", [ delta, target ]);
    }

    public function scrollWheel(delta)
    {
        call("scrollWheel", [ delta ]);
    }
}
