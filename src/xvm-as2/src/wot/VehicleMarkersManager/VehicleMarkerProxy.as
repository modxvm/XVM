/**
 * Proxy class for vehicle marker components
 * Dispatches event for config loading if it is not loaded
 */
import com.xvm.*;
import com.xvm.DataTypes.*;
import wot.VehicleMarkersManager.*;
import wot.VehicleMarkersManager.log.*;

/* TODO:
 * Check for performance boost with marker object caching
 * http://sourcemaking.com/design_patterns/object_pool
 */

class wot.VehicleMarkersManager.VehicleMarkerProxy implements IVehicleMarker
{
    // Public members
    public var m_playerName:String;

    // Private members
    private var m_vehicleName:String;
    private var m_level:Number;
    private var m_playerClan:String;
    private var m_playerRegion:String;
    private var m_curHealth:Number;
    private var m_defaultIconSource:String;
    private var m_vehicleClass:String;
    private var m_dead:Boolean;
    private var m_vid:Number;

    /**
     * called by Battle.pyc
     */
    public static var INIT_ARGS_COUNT:Number = 16;
    public function init(vClass:String, vIconSource:String, vType:String, vLevel:Number, pFullName:String, pName:String,
        pClan:String, pRegion:String, curHealth:Number, maxHealth:Number, entityName:String, speaking:Boolean,
        hunt:Boolean, entityType:String, isFlagBearer:Boolean, squadIconIdx:Number)
        /* added by XVM: playerId:Number, vid:Number, marksOnGun:Number, vehicleState:Number, frags:Number, squad:Number*/
    {
        // Invoked on new marker creation
        //Logger.addObject("init: " + arguments);

        m_vehicleName = vType;
        m_level = vLevel;
        m_playerName = pName; // alex
        m_playerClan = pClan; // "" || ALX
        m_playerRegion = pRegion; // null || ?
        m_defaultIconSource = vIconSource;
        m_vehicleClass = vClass;
        m_curHealth = curHealth;
        m_dead = m_curHealth <= 0;

        var playerId = arguments[INIT_ARGS_COUNT + 0];
        var vid:Number = m_vid = arguments[INIT_ARGS_COUNT + 1];

        // for markers, hitlog and hpleft
        var wr = wrapper;
        var registerMacros = function()
        {
            Macros.RegisterPlayerData(pName,
            {
                uid: playerId,
                vid: vid,
                label: pName + (pClan == "" ? "" : "[" + pClan + "]"),
                squad: entityName == "squadman" ? 11 : 0,
                maxHealth: maxHealth
            }, wr.m_team == "ally" ? Defines.TEAM_ALLY : Defines.TEAM_ENEMY);
        };

        if (!subject)
            initializeSubject();
        if (wrapper.m_team == "enemy")
        {
            logLists.onNewMarkerCreated.apply(logLists, arguments);
        }
        call("init", arguments, registerMacros);
    }

    public function updateHealth(curHealth:Number, flag:Number, damageType:String):Void
    {
        if (curHealth <= 0)
        {
            m_dead = true;
            if (flag == Defines.FROM_PLAYER)
                Macros.s_my_frags++;
        }

        var curHealthAbsolute:Number = (curHealth < 0 ? 0 : curHealth);

        if (wrapper.m_team == "enemy") /** Omit allies */
        {
            if (logLists != null)
            {
                var delta = m_curHealth - curHealthAbsolute;
                var vdata = VehicleInfo.get(m_vid);
                logLists.onHpUpdate(flag, delta, curHealth,
                    vdata.localizedName,
                    m_defaultIconSource,
                    m_playerName, m_level, damageType,
                    Config.config.texts.vtype[vdata.vtype],
                    GraphicsUtil.GetVTypeColorValue(m_vid),
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
            UnitDestroyedAccounting.instance.logDead(m_playerName);
        }
        return call("updateState", arguments);
    }

    // XVM

    public function as_xvm_setMarkerState()
    {
        //Logger.add("as_xvm_setMarkerState: " + arguments);
        if (IsXvmMarker)
            call("as_xvm_setMarkerState", arguments);
    }

    public function as_xvm_onXmqpEvent(event:String, data:String)
    {
        if (IsXvmMarker)
            call("as_xvm_onXmqpEvent", arguments);
    }
}
