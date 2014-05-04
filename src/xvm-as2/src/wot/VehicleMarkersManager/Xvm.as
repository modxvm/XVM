/**
 * Main XVM class, implements workflow logic.
 */
import com.greensock.OverwriteManager;
import com.greensock.plugins.*;
import com.xvm.*;
import wot.VehicleMarkersManager.components.*;
import wot.VehicleMarkersManager.components.damage.*;
import wot.VehicleMarkersManager.*;

/*
 * XVM() instance creates corresponding marker
 * each time some player gets in line of sight.
 * Instantiated 14 times at normal round start.
 * Destructed when player get out of sight.
 * Thus may be instantiated ~50 times and more.
 */

class wot.VehicleMarkersManager.Xvm extends XvmBase implements wot.VehicleMarkersManager.IVehicleMarker
{
    //private function trace(str:String):Void
    //{
        //if (m_playerFullName == "...")
        //Logger.add(m_playerFullName + "> " + str);
    //}

    /**
     * .ctor()
     * @param	proxy Parent proxy class (for placing UI Controls)
     */
    function Xvm(proxy:VehicleMarkerProxy)
    {
        _proxy = proxy;
        initializeStaticEnvironment();

        vehicleState = new VehicleState(new VehicleStateProxy(this));
        healthBarComponent = new HealthBarComponent(new HealthBarProxy(this));
        actionMarkerComponent = new ActionMarkerComponent(new ActionMarkerProxy(this));
        clanIconComponent = new ClanIconComponent(new ClanIconProxy(this));
        contourIconComponent = new ContourIconComponent(new ContourIconProxy(this));
        levelIconComponent = new LevelIconComponent(new LevelIconProxy(this));
        turretStatusComponent = new TurretStatusComponent(new TurretStatusProxy(this));
        vehicleTypeComponent = new VehicleTypeComponent(new VehicleTypeProxy(this));
        damageTextComponent = new DamageTextComponent(new DamageTextProxy(this));

        // since 0.8.9.CT1 WG implemented some kind of "optimization", and marker will not be shown when all elements are not in the mc bounds.
        // add empty text field to always be in the bounds
        proxy.wrapper.createTextField("__bounds_stub__", 0, 0, 0, 10, 10);
    }

    /**
     * Called from .ctor()
     */
    private static var s_initialized:Boolean = false;
    private static function initializeStaticEnvironment()
    {
        if (Xvm.s_initialized)
            return;
        Xvm.s_initialized = true;

        Utils.TraceXvmModule("VehicleMarkersManager");

        // initialize TweenLite
        OverwriteManager.init(OverwriteManager.AUTO);
        TweenPlugin.activate([AutoAlphaPlugin, BevelFilterPlugin, BezierPlugin, BezierThroughPlugin, BlurFilterPlugin,
            CacheAsBitmapPlugin, ColorMatrixFilterPlugin, ColorTransformPlugin, DropShadowFilterPlugin, EndArrayPlugin,
            FrameBackwardPlugin, FrameForwardPlugin, FrameLabelPlugin, FramePlugin, GlowFilterPlugin,
            HexColorsPlugin, QuaternionsPlugin, RemoveTintPlugin, RoundPropsPlugin, ScalePlugin, ScrollRectPlugin,
            SetSizePlugin, ShortRotationPlugin, TintPlugin, TransformMatrixPlugin, VisiblePlugin, VolumePlugin]);
    }

    /**
     * IVehicleMarker implementation
     */

    /**
     * @see IVehicleMarker
     */
    function init(vClass:String, vIconSource:String, vType:String, vLevel:Number,
        pFullName:String, pName:String, pClan:String, pRegion:String,
        curHealth:Number, maxHealth:Number, entityName:String, speaking:Boolean, hunt:Boolean, entityType:String)
    {
        m_playerName = pName; // alex
        m_playerClan = pClan; // "" || ALX
        m_playerRegion = pRegion; // null || ?
        m_playerFullName = pFullName; // alex[ALX]

        //trace("Xvm::init(): " + entityName + ", " + entityType);

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
        m_curHealth = curHealth >= 0 ? curHealth : 0;

        healthBarComponent.init();
        contourIconComponent.init(m_entityType);
        levelIconComponent.init();
        turretStatusComponent.init();
        vehicleTypeComponent.init(vClass /*mediumTank*/, hunt);
        damageTextComponent.init();

        Macros.RegisterMarkerData(Utils.GetPlayerName(m_playerFullName),
        {
            turret: turretStatusComponent.getMarker()
        });

        // Create clan icon and place to mc.
        clanIconComponent.initialize(wrapper);

        // Initialize states and creating text fields
        initializeTextFields();

        // Draw marker
        XVMUpdateStyle();

        // Load stat
        if (Config.config.rating.showPlayersStatistics && !Stat.s_loaded)
        {
            GlobalEventDispatcher.addEventListener(Stat.E_STAT_LOADED, this, onStatLoaded);
        }
    }

    public function setupMarkerFrame()
    {
        vehicleTypeComponent.setMarkerLabel();

        // Remove standard fields for XVM
        if (wrapper.pNameField)
        {
            wrapper.pNameField._visible = false;
            wrapper.pNameField.removeTextField();
            delete wrapper.pNameField;
        }

        if (wrapper.vNameField)
        {
            wrapper.vNameField._visible = false;
            wrapper.vNameField.removeTextField();
            delete wrapper.vNameField;
        }

        if (wrapper.healthBar)
        {
            wrapper.healthBar.stop();
            wrapper.healthBar._visible = false;
            wrapper.healthBar.removeMovieClip();
            delete wrapper.healthBar;
        }

        if (wrapper.hp_mc)
        {
            wrapper.hp_mc.stop();
            wrapper.hp_mc._visible = false;
            wrapper.hp_mc.removeMovieClip();
            delete wrapper.hp_mc;
        }

        if (wrapper.hitLbl)
        {
            wrapper.hitLbl.stop();
            wrapper.hitLbl._visible = false;
            wrapper.hitLbl.removeMovieClip();
            delete wrapper.hitLbl;
        }
    }

    /**
     * @see IVehicleMarker
     */
    function update()
    {
        //trace("Xvm::update()");
        // TODO: check // Update Color Blind mode
        // TODO: check vehicleTypeComponent.updateMarkerLabel();
        XVMUpdateStyle();
    }

    /**
     * @see IVehicleMarker
     */
    function updateMarkerSettings()
    {
        // We don't use in-game settings. Yet.
        // do nothing
    }

    /**
     * @see IVehicleMarker
     */
    function setSpeaking(value:Boolean)
    {
        //trace("Xvm::setSpeaking(" + value + ")");
        if (m_speaking == value)
            return;
        m_speaking = value;
        vehicleTypeComponent.setVehicleClass();
        vehicleTypeComponent.updateState(vehicleState.getCurrentConfig());
    }

    /**
     * @see IVehicleMarker
     */
    function setEntityName(value:String)
    {
        //trace("Xvm::setEntityName(" + value + ")");
        if (value == m_entityName)
            return;
        m_entityName = value;
        vehicleTypeComponent.updateMarkerLabel();
        initializeTextFields();
        XVMUpdateStyle();
    }

    /**
     * @see IVehicleMarker
     */
    function updateHealth(newHealth:Number, flag:Number, damageType:String)
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

        //Logger.add("Xvm::updateHealth(" + flag + ", " + damageType + ", " + newHealth +")");

        if (newHealth < 0)
            s_blowedUp[m_playerFullName] = true;

        // can be dead with newHealth > 0 if crew is dead
        if (newHealth <= 0)
            m_isDead = true;

        var delta: Number = newHealth - m_curHealth;
        m_curHealth = m_isDead ? 0 : newHealth; // fixes "-1"

        if (delta < 0) // Damage has been done
        {
            // markers{ally{alive{normal
            var vehicleStateCfg:Object = vehicleState.getCurrentConfig();
            healthBarComponent.updateState(vehicleStateCfg);
            healthBarComponent.showDamage(vehicleStateCfg, newHealth, m_maxHealth, -delta, flag, damageType);
            var cfg = flag == Defines.FROM_PLAYER ? vehicleStateCfg.damageTextPlayer
                : flag == Defines.FROM_SQUAD ? vehicleStateCfg.damageTextSquadman : vehicleStateCfg.damageText;
            //Logger.addObject(cfg, m_playerFullName);
            damageTextComponent.showDamage(cfg, newHealth, -delta, flag, damageType);
        }

        XVMUpdateDynamicTextFields();
    }

    /**
     * @see IVehicleMarker
     */
    function updateState(newState:String, isImmediate:Boolean)
    {
        //trace("Xvm::updateState(" + newState + ", " + isImmediate + "): " + vehicleState.getCurrentState());

//        if (!initialized)
//            ErrorHandler.setText("updateState: !initialized");

        m_isDead = newState == "dead";

        XVMUpdateStyle();
        // setMarkerState after set style!
        vehicleTypeComponent.setMarkerState(isImmediate && m_isDead ? "immediate_dead" : newState);
    }

    /**
     * @see IVehicleMarker
     */
    function showExInfo(show:Boolean)
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
     * Components extension: MovieClip.onEnterFrame translation
     * TODO: Check performance & implementation
     */
    function onEnterFrame():Void
    {
        if (contourIconComponent != null && contourIconComponent.onEnterFrame != null)
            contourIconComponent.onEnterFrame();
    }

    /**
    * MAIN
    */

    /**
     * Second stage of initialization
     * @see init
     * @see StatLoader
     */
    function onStatLoaded(event)
    {
        //trace("Xvm::onStatLoaded()");
        GlobalEventDispatcher.removeEventListener(Stat.E_STAT_LOADED, this, onStatLoaded);

        initializeTextFields();
        vehicleTypeComponent.setVehicleClass();
        XVMUpdateStyle();
    }

    function XVMUpdateDynamicTextFields()
    {
        try
        {
            if (textFields)
            {
                var st = vehicleState.getCurrentState();
                for (var i in textFields[st])
                {
                    var tfi = textFields[st][i];
                    tfi.field.htmlText = "<textformat leading='-2'><p class='xvm_markerText'>" +
                        "<font color='#" + formatDynamicColor(tfi.color, m_curHealth).toString(16) + "'>" +
                        formatDynamicText(tfi.format, m_curHealth) + "</font></p></textformat>";
                    tfi.field._alpha = formatDynamicAlpha(tfi.alpha, m_curHealth);

                    tfi.shadow.color = formatDynamicColor(tfi.sh_color, m_curHealth);
                    tfi.shadow.alpha = formatDynamicAlpha(tfi.sh_alpha, m_curHealth) / 100;
                    tfi.field.filters = [  tfi.shadow ];
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
        //var start = (new Date()).getTime();
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
        //Logger.add(((new Date()).getTime() - start).toString() + " ms");
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
