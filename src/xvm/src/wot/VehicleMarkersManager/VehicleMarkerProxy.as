/**
 * Proxy class for vehicle marker components
 */
import wot.VehicleMarkersManager.IVehicleMarker;
import wot.VehicleMarkersManager.XVM;
import wot.utils.Config;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Logger;
import wot.utils.Utils;

class wot.VehicleMarkersManager.VehicleMarkerProxy extends gfx.core.UIComponent implements IVehicleMarker
{
    // dummy var to avoid import warning
    private static var __dummy = Logger.dummy;

    // Used in child classes VehicleMarkerAlly and VehicleMarkerEnemy
    public var m_team:String; // protected
    public var m_entityName:String; // protected

    // Inherited from sprite
    // TODO: try to remove and create dynamically only with standard markers to improove performance
    private var levelIcon:MovieClip;
    private var iconLoader:MovieClip;
    private var vNameField:TextField;
    private var pNameField:TextField;
    private var actionMarker:MovieClip;
    private var marker:MovieClip;
    private var healthBar:MovieClip;
    private var bgShadow:MovieClip;

    // Private vars
    private var m_playerName;

    /**
     * Subject class with real implementation
     */
    private var subject: IVehicleMarker;

    /**
     * Pending calls missed while config is loading.
     * Records is object: { func:String, args:Array }
     */ 
    private var pendingCalls:Array;

    private function trace(str:String)
    {
        //if (m_playerName == "Feuer30")
        //Logger.add(m_playerName + "> " + str);
    }
    
    /**
     * ctor()
     */
    public function VehicleMarkerProxy()
    {
        subject = null;

        // ScaleForm optimization
        if (!_global.noInvisibleAdvance)
            _global.noInvisibleAdvance = true;

        trace("VehicleMarkerProxy()");

        super();

        Utils.TraceXvmModule("VehicleMarkerProxy");

        if (Config.s_loaded == true)
            initializeSubject();
        else
        {
            vNameField.text = "Loading...";
            pNameField._visible = false;
            marker._visible = false;
            healthBar._visible = false;
            bgShadow._visible = false;
            Config.LoadConfig("VehicleMarkerProxy.as", undefined, true);
            GlobalEventDispatcher.addEventListener("config_loaded", this, onConfigLoaded);
        }
    }

    private function onConfigLoaded()
    {
        trace("onConfigLoaded()");
        marker._visible = true;
        GlobalEventDispatcher.removeEventListener("config_loaded", this, onConfigLoaded);
        initializeSubject();
    }

    private function initializeSubject()
    {
        trace("initializeSubject()");

        if (Config.s_config.battle.useStandardMarkers == true)
            subject = new net.wargaming.ingame.VehicleMarker();
        else
            subject = new XVM();

        subject["_proxy"] = this;
        subject["gotoAndStop"] = function(frame) {
            //Logger.add("**************** " + frame);
            this["_proxy"].gotoAndStop(frame);
            this["_proxy"].bindStandardElements();
        };

        if (pendingCalls.length > 0)
            processPendingCalls();
    }

    private function bindStandardElements()
    {
        marker._x = marker._y = 0; // TODO: TK vtype marker in not centered using standard markers
        subject["marker"] = marker;
        subject["levelIcon"] = levelIcon;
        subject["iconLoader"] = iconLoader;
        subject["vNameField"] = vNameField;
        subject["pNameField"] = pNameField;
        subject["actionMarker"] = actionMarker;
        subject["healthBar"] = healthBar;
        subject["bgShadow"] = bgShadow;
    }
    
    private function call(func:String, args:Array)
    {
        if (func != "showExInfo")
            trace("call(): " + func);

        if (subject != null)
            subject[func].apply(subject, args);
        else
        {
            if (!pendingCalls)
                pendingCalls = [];
            pendingCalls.push( { name:m_playerName, func:func, args:args } );
        }
    }

    private function processPendingCalls()
    {
        trace("processPendingCalls()");
        if (subject == null)
            return;
        
        var len = pendingCalls.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var data = pendingCalls[i];
            call(data.func, data.args);
        }
        pendingCalls = null;
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
        m_playerName = pFullName;
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
        Logger.add("setEntityName(" + value + ")");
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
     */

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

    public function validateNow()
    {
        call("validateNow");
    }

    public function toString()
    {
        trace("*** toString()");
        return "[proxy]" + (subject != null ? subject.toString() : "[(null)]");
    }

    public function configUI()
    {
        call("configUI");
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
