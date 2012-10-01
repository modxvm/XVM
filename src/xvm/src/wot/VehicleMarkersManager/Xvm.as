/**
 * Main XVM class, implements workflow logic.
 */
import wot.utils.Config;
import wot.utils.GlobalEventDispatcher;
import wot.utils.StatData;
import wot.utils.StatLoader;
import wot.utils.Utils;
import wot.utils.Logger;
import wot.VehicleMarkersManager.ColorsManager;
import wot.VehicleMarkersManager.ErrorHandler;
import wot.VehicleMarkersManager.VehicleMarkerProxy;
import wot.VehicleMarkersManager.VehicleState;
import wot.VehicleMarkersManager.VehicleStateProxy;
import wot.VehicleMarkersManager.XvmBase;
import wot.VehicleMarkersManager.XvmHelper;
import wot.VehicleMarkersManager.components.ActionMarkerComponent;
import wot.VehicleMarkersManager.components.ActionMarkerProxy;
import wot.VehicleMarkersManager.components.ClanIconComponent;
import wot.VehicleMarkersManager.components.ClanIconProxy;
import wot.VehicleMarkersManager.components.ContourIconComponent;
import wot.VehicleMarkersManager.components.ContourIconProxy;
import wot.VehicleMarkersManager.components.DamageTextComponent;
import wot.VehicleMarkersManager.components.DamageTextProxy;
import wot.VehicleMarkersManager.components.HealthBarComponent;
import wot.VehicleMarkersManager.components.HealthBarProxy;
import wot.VehicleMarkersManager.components.LevelIconComponent;
import wot.VehicleMarkersManager.components.LevelIconProxy;
import wot.VehicleMarkersManager.components.TurretStatusComponent;
import wot.VehicleMarkersManager.components.TurretStatusProxy;
import wot.VehicleMarkersManager.components.VehicleTypeComponent;
import wot.VehicleMarkersManager.components.VehicleTypeProxy;

/*
 * XVM() instance creates corresponding marker
 * each time some player gets in line of sight.
 * Instantiated 14 times at normal round start.
 * Destructed when player get out of sight.
 * Thus may be instantiated ~50 times and more.
 */

class wot.VehicleMarkersManager.Xvm extends XvmBase implements wot.VehicleMarkersManager.IVehicleMarker
{
    // dummy var to avoid import warning
    private static var __dummy = Logger.dummy;

    /**
     * .ctor()
     * @param	proxy Parent proxy class (for placing UI Components)
     */
    function Xvm(proxy:VehicleMarkerProxy)
    {
        super(); // gfx.core.UIComponent
        _proxy = proxy;
        Utils.TraceXvmModule("XVM");

        // initialize ColorsManager for detecting color blind mode
        ColorsManager.initialize();
    }

    /**
     * IVehicleMarker implementation
     */

    /**
     * @see IVehicleMarker
     */
    function init(vClass, vIconSource, vType, vLevel, pFullName,
        curHealth, maxHealth, entityName, speaking, hunt, entityType)
    {
        m_playerFullName = pFullName; // alex

        trace("Xvm::init(): " + entityName + ", " + entityType);

        // Use currently remembered extended / normal status for new markers
        m_showExInfo = s_showExInfo;

        m_defaultIconSource = vIconSource; // ../maps/icons/vehicle/contour/usa-M48A1.png
        m_source = vIconSource;
        m_entityName = entityName; // ally, enemy, squadman, teamKiller
        m_entityType = entityType; // ally, enemy
        m_maxHealth = maxHealth;

        m_vname = vType; // AMX50F155
        m_level = vLevel;
        m_speaking = speaking;

        m_isDead    = curHealth <= 0; // -1 for ammunition storage explosion
        m_curHealth = curHealth >= 0 ? (curHealth) : (0);

        vehicleState = new VehicleState(new VehicleStateProxy(this));

        healthBarComponent = new HealthBarComponent(new HealthBarProxy(this));
        actionMarkerComponent = new ActionMarkerComponent(new ActionMarkerProxy(this));
        clanIconComponent = new ClanIconComponent(new ClanIconProxy(this));
        contourIconComponent = new ContourIconComponent(new ContourIconProxy(this));
        levelIconComponent = new LevelIconComponent(new LevelIconProxy(this));
        turretStatusComponent = new TurretStatusComponent(new TurretStatusProxy(this));
        vehicleTypeComponent = new VehicleTypeComponent(new VehicleTypeProxy(this), vClass /*mediumTank*/, hunt);
        damageTextComponent = new DamageTextComponent(new DamageTextProxy(this));

        // Create clan icon and place to mc.
        clanIconComponent.initialize(vehicleState.getCurrentConfig(), proxy);

        // Initialize states and creating text fields
        initializeTextFields();

        // Draw marker
        XVMUpdateStyle();

        // Load stat
        if (Config.s_config.rating.showPlayersStatistics && !StatData.s_loaded)
        {
            GlobalEventDispatcher.addEventListener("stat_loaded", this, onStatLoaded);
            StatLoader.LoadLastStat();
        }
    }

    /**
     * @see IVehicleMarker
     */
    function update()
    {
        trace("Xvm::update()");
        // Update Color Blind mode
        vehicleTypeComponent.updateMarkerLabel();
        XVMUpdateStyle();
    }

    /**
     * @see IVehicleMarker
     */
    function updateMarkerSettings()
    {
        trace("Xvm::updateMarkerSettings()");
        // do nothing
        // We don't use in-game settings. Yet.
    }

    /**
     * @see IVehicleMarker
     */
    function setSpeaking(value)
    {
        trace("Xvm::setSpeaking(" + value + ")");
        if (m_speaking == value)
            return;
        m_speaking = value;
        if (initialized)
        {
            vehicleTypeComponent.setVehicleClass();
            vehicleTypeComponent.updateState(vehicleState.getCurrentConfig());
        }
    }

    /**
     * @see IVehicleMarker
     */
    function setEntityName(value)
    {
        trace("Xvm::setEntityName(" + value + ")");
        if (value == m_entityName)
            return;
        m_entityName = value;
        vehicleTypeComponent.updateMarkerLabel();
        XVMUpdateStyle();
    }

    /**
     * @see IVehicleMarker
     */
    function updateHealth(newHealth, flag, damageTypeStr)
    {
        /* 
         * newHealth:
         *  1497, 499, 0 and -1 in case of ammo blow up
         * flag - int:
         * 0 - "FROM_UNKNOWN", 1 - "FROM_ALLY", 2 - "FROM_ENEMY", 3 - "FROM_SQUAD", 4 - "FROM_PLAYER"
         * 
         * damageType - string:
         *  "attack", "fire", "ramming", "world_collision", "death_zone", "drowning", "explosion"
         */
        
        //Logger.add("Xvm::updateHealth(" + flag + ", " + damageTypeStr + ", " + newHealth +")");
        
        var damageType:Number = XvmHelper.translateDmgToConst(damageTypeStr);
        
        if (newHealth < 0)
            s_blowedUp[m_playerFullName] = true;
            
        m_isDead = newHealth <= 0;

        var delta: Number = newHealth - m_curHealth;
        m_curHealth = m_isDead ? 0 : newHealth; // fixes "-1"
        
        if (delta < 0) // Damage has been done
        {
            var cfg = vehicleState.getCurrentConfig();
            healthBarComponent.updateState(cfg);
            healthBarComponent.showDamage(cfg, newHealth, m_maxHealth, -delta);
            damageTextComponent.showDamage(vehicleState.getCurrentConfig(), newHealth, -delta, flag, damageType);
        }

        XVMUpdateDynamicTextFields();
    }

    /**
     * @see IVehicleMarker
     */
    function updateState(newState, isImmediate)
    {
        trace("Xvm::updateState(" + newState + ", " + isImmediate + "): " + vehicleState.getCurrentState());

//        if (!initialized)
//            ErrorHandler.setText("updateState: !initialized");

        m_isDead = newState == "dead";

        vehicleTypeComponent.setMarkerState(isImmediate && m_isDead ? "immediate_dead" : newState);

        XVMUpdateStyle();
    }

    /**
     * @see IVehicleMarker
     */
    function showExInfo(show)
    {
        //trace("Xvm::showExInfo()");
        if (m_showExInfo == show)
            return;
        m_showExInfo = show;

        // Save current extended / normal state flag to static variable, so
        // new markers can refer to it when rendered initially
        s_showExInfo = show;

        XVMUpdateStyle();
    }

    /**
     * @see IVehicleMarker
     */
    function showActionMarker(actionState)
    {
        actionMarkerComponent.showActionMarker(actionState);
    }

    /**
     * Second stage of initialization
     * @see init
     * @see StatLoader
     */
    function onStatLoaded(event)
    {
        //trace("Xvm::onStatLoaded()");
        if (event)
            GlobalEventDispatcher.removeEventListener("stat_loaded", this, onStatLoaded);

        initializeTextFields();
        XVMUpdateStyle();
    }

    // CODE BELOW IS NOT CHECKED

    /**
    * MAIN
    */

    function XVMUpdateDynamicTextFields()
    {
        try
        {
            if (textFields)
            {
                var st = vehicleState.getCurrentState();
                for (var i in textFields[st])
                {
                    var tf = textFields[st][i];
                    tf.field.text = formatDynamicText(tf.format, m_curHealth);
                    //tf.field.htmlText = "<p align='center'><font face='$FieldFont'>" + formatDynamicText(tf.format, curHealth) + "</font></p>";
                    tf.field.textColor = formatDynamicColor(tf.color, m_curHealth);
                    tf.field._alpha = formatDynamicAlpha(tf.alpha, m_curHealth);
                }
            }
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMUpdateDynamicTextFields():" + String(e));
        }
    }

    function initializeTextFields()
    {
        //trace("Xvm::initializeTextFields()");
        try
        {
            // cleanup
            if (textFields)
            {
                for (var st in textFields)
                {
                    for (var i in textFields[st])
                    {
                        var tf = textFields[st][i];
                        tf.field.removeTextField();
                        tf.field = null;
                        delete tf;
                    }
                }
            }

            textFields = { };
            var allStates = vehicleState.getAllStates();
            for (var stid in allStates)
            {
                var st = allStates[stid];
                var cfg = vehicleState.getConfig(st);

                // create text fields
                var fields: Array = [];
                for (var i in cfg.textFields)
                {
                    if (cfg.textFields[i].visible)
                    {
                        //if (m_team == "ally")
                        //    Logger.addObject(cfg.textFields[i], m_vname + " " + m_playerFullName + " " + st);
                        //if (m_team == "enemy")
                        //    Logger.addObject(cfg.textFields[i], m_vname + " " + m_playerFullName + " " + st);
                        fields.push(createTextField(cfg.textFields[i]));
                    }
                }
                textFields[st] = fields;
            }
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: initializeTextFields():" + String(e));
        }
    }

    function XVMUpdateStyle()
    {
        //trace("XVMUpdateStyle: " + m_playerFullName + m_vname + " " + " scale=" + proxy.marker._xscale);
        try
        {
            //var start = new Date(); // for debug

            var cfg = vehicleState.getCurrentConfig();

            // Vehicle Type Marker
            vehicleTypeComponent.updateState(cfg);

            // Contour Icon
            contourIconComponent.updateState(cfg);

            // Level Icon
            levelIconComponent.updateState(cfg);

            // Action Marker
            actionMarkerComponent.updateState(cfg);

            // Clan Icon
            clanIconComponent.updateState(cfg);

            // Damage Text
            damageTextComponent.updateState(cfg);

            // Health Bar
            healthBarComponent.updateState(cfg);

            // Text fields
            if (textFields)
            {
                var st = vehicleState.getCurrentState();
                for (var i in textFields)
                {
                    for (var j in textFields[i])
                        textFields[i][j].field._visible = (i == st);
                }
            }

            // Update Colors and Values
            XVMUpdateDynamicTextFields();
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMUpdateStyle():" + String(e));
        }
    }
}
