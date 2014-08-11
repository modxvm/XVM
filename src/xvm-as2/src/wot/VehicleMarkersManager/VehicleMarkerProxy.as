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

        subject = null;

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
        //trace("initializeSubject() standard=" + Config.config.markers.useStandardMarkers + " " + m_playerFullName);

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
        //trace("createStandardMarker()");

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
        //Logger.add("gotoAndStop(" + frame + ")");
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
            //if (data.func != "showExInfo")
            //    trace("deferred");
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
        //if (func != "showExInfo")
        //    trace("call(): " + func + (args ? " [" + args.join(", ") + "]" : ""));

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
                squad: entityName == "squadman" ? 11 : 0,
                level: vLevel,
                vtype: Utils.vehicleClassToVehicleType(vClass),
                maxHealth: maxHealth
            }, wr.m_team == "ally" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);
        };

        if (!subject)
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

    /**
     * Use this method also for vehicle state update (because invokeMarker is incapsulated into C++ part and cannot be enhanced)
     */
    public function showActionMarker(actionState):Void {
        if (actionState != null)
        {
            call("showActionMarker", [actionState]);
        }
        else
        {
            if (IsXvmMarker && arguments.length > 2)
            {
                switch (arguments[1])
                {
                    case 1:
                        call("invalidateVehicleStatus", [arguments[2]]);
                        break;

                    case 2:
                        call("invalidateVehicleStats", [arguments[2]]);
                        break;
                }
            }
        }
    }

    public function onLoad()                      { return call("onLoad", arguments); }

    //
    function invalidateVehicleStatus(vehicleState:Number):Void
    {
        if (IsXvmMarker)
            call("invalidateVehicleStatus", arguments);
    }

}
