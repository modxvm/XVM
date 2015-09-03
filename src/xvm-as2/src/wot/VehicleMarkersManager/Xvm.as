/**
 * Main XVM class, implements workflow logic.
 */
import com.xvm.*;
import flash.filters.*
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
class wot.VehicleMarkersManager.Xvm implements wot.VehicleMarkersManager.IVehicleMarker
{
    // Private static members
    private static var s_showExInfo:Boolean = false; // Saved "Extended Info State" for markers that appeared when Alt pressed.
    private static var s_blowedUp:Object = {}; // List of members that was ammoracked.

    // Wrapper
    public var wrapper:net.wargaming.ingame.VehicleMarker;

    // Public members
    public var m_entityName:String;
    public var m_playerName:String;
    public var m_playerClan:String;
    public var m_playerRegion:String;
    public var m_curHealth:Number;
    public var m_maxHealth:Number;
    public var m_source:String;
    public var m_vname:String;
    public var m_level:Number;
    public var m_speaking:Boolean;
    public var m_entityType:String; // TODO: is the same as proxy.m_team?
    private var m_isFlagbearer:Boolean;
    public var m_playerId:Number;
    public var m_marksOnGun:Number;
    public var m_frags:Number;
    public var m_squad:Number;
    public var m_isReady:Boolean;
    public var m_isDead:Boolean;
    public var m_showExInfo:Boolean;
    public var m_defaultIconSource:String;
    public var m_vid:Number;

    // Vehicle State
    public var vehicleState:VehicleState;

    // UI Controls
    private var actionMarkerComponent:ActionMarkerComponent;
    private var clanIconComponent:ClanIconComponent;
    private var contourIconComponent:ContourIconComponent;
    private var damageTextComponent:DamageTextComponent;
    private var healthBarComponent:HealthBarComponent;
    private var levelIconComponent:LevelIconComponent;
    private var turretStatusComponent:TurretStatusComponent;
    private var vehicleTypeComponent:VehicleTypeComponent;
    private var textFieldsHolder:MovieClip;
    private var textFields:Object;

    // Properties

    public function get isBlowedUp():Boolean
    {
        return s_blowedUp[m_playerName] != undefined;
    }

    /**
     * Trace function for debug purpose. Must be commented on release.
     * TODO: Is AS2/FD have any kind of conditional compilation?
     * @param	str
     */
    //public function trace(str:String):Void
    //{
    //    if (m_playerFullName == "ayne_RU")
    //    Logger.add(m_playerName + "> " + str);
    //}

    /**
     * .ctor()
     * @param	proxy Parent proxy class (for placing UI Controls)
     */
    function Xvm(proxy:VehicleMarkerProxy)
    {
        wrapper = proxy.wrapper;

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
        wrapper.createTextField("__bounds_stub__", 0, 0, 0, 10, 10);
    }

    /**
     * Called from VehicleMarkerProxy on frame change (when gotoAndStop called)
     */
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

        if (wrapper.squadIcon)
        {
            wrapper.squadIcon.stop();
            wrapper.squadIcon._visible = false;
            wrapper.squadIcon.removeMovieClip();
            delete wrapper.squadIcon;
        }
    }

    /**
     * IVehicleMarker implementation
     */

    /**
     * @see IVehicleMarker
     */
    public function init(vClass:String, vIconSource:String, vType:String, vLevel:Number, pFullName:String,
        pName:String, pClan:String, pRegion:String, curHealth:Number, maxHealth:Number, entityName:String,
        speaking:Boolean, hunt:Boolean, entityType:String, isFlagBearer:Boolean, squadIcon)
        /* added by XVM: playerId:Number, vid:Number, marksOnGun:Number, vehicleState:Number, frags:Number, squad:Number*/
    {
        Cmd.profMethodStart("Xvm.init()");

        m_playerName = pName; // alex
        m_playerClan = pClan; // "" || ALX
        m_playerRegion = pRegion; // null || ?
        //m_playerFullName = pFullName; // alex[ALX] (MS-1)

        //Logger.add(m_playerName);
        //Logger.add(m_playerClan);
        //Logger.add(m_playerRegion);
        //Logger.add(m_playerFullName);

        //trace("Xvm::init(): " + entityName + ", " + entityType);

        // Use currently remembered extended / normal status for new markers
        m_showExInfo = s_showExInfo;

        m_defaultIconSource = vIconSource; // ../maps/icons/vehicle/contour/usa-M48A1.png
        m_source = vIconSource;
        m_entityName = entityName; // ally, enemy, squadman, teamKiller
        m_entityType = entityType; // ally, enemy
        m_maxHealth = maxHealth;
        m_isFlagbearer = isFlagBearer;
        wrapper.flagMC._visible = m_isFlagbearer;

        m_vname = vType; // AMX50F155
        m_level = vLevel;
        m_speaking = speaking;

        m_isDead    = curHealth <= 0; // -1 for ammunition storage explosion
        m_curHealth = curHealth >= 0 ? curHealth : 0;

        m_playerId = arguments[VehicleMarkerProxy.INIT_ARGS_COUNT + 0];
        m_vid = arguments[VehicleMarkerProxy.INIT_ARGS_COUNT + 1];
        m_marksOnGun = arguments[VehicleMarkerProxy.INIT_ARGS_COUNT + 2];
        m_isReady = (arguments[VehicleMarkerProxy.INIT_ARGS_COUNT + 3] & 2) != 0; // 2 - IS_AVATAR_READY
        m_frags = arguments[VehicleMarkerProxy.INIT_ARGS_COUNT + 4];
        m_squad = arguments[VehicleMarkerProxy.INIT_ARGS_COUNT + 5];

        healthBarComponent.init();
        contourIconComponent.init(m_entityType);
        levelIconComponent.init();
        turretStatusComponent.init();
        vehicleTypeComponent.init(vClass /*mediumTank*/, hunt);
        textFieldsHolder = wrapper.createEmptyMovieClip("xvm_textFieldsHolder", wrapper.getNextHighestDepth());
        damageTextComponent.init();

        Macros.RegisterMarkerData(m_playerName,
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
        if (!Stat.s_loaded)
        {
            GlobalEventDispatcher.addEventListener(Defines.E_STAT_LOADED, this, onStatLoaded);
        }

        Cmd.profMethodEnd("Xvm.init()");
    }

    /**
     * @see IVehicleMarker
     */
    public function update()
    {
        XVMUpdateStyle();
    }

    /**
     * @see IVehicleMarker
     */
    public function updateMarkerSettings()
    {
        // We don't use in-game settings. Yet.
        // do nothing
    }

    /**
     * @see IVehicleMarker
     */
    public function setSpeaking(value:Boolean)
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
    public function setEntityName(value:String)
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
    public function updateHealth(newHealth:Number, flag:Number, damageType:String)
    {
        /*
         * newHealth:
         *  1497, 499, 0 and -1 in case of ammo blow up
         * flag - int:
         * 0 - "FROM_UNKNOWN", 1 - "FROM_ALLY", 2 - "FROM_ENEMY", 3 - "FROM_SQUAD", 4 - "FROM_PLAYER"
         *
         * damageType - string:
         *  "shot", "fire", "ramming", "world_collision", "death_zone", "drowning"
         */

        //Logger.add("Xvm::updateHealth(" + flag + ", " + damageType + ", " + newHealth +")");

        if (newHealth < 0)
            s_blowedUp[m_playerName] = true;

        // can be dead with newHealth > 0 if crew is dead
        if (newHealth <= 0)
            m_isDead = true;

        var delta: Number = newHealth - m_curHealth;
        m_curHealth = m_isDead ? 0 : newHealth; // fixes "-1"

        if (delta < 0) // Damage has been done
        {
            // markers.ally.alive.normal
            var vehicleStateCfg:Object = vehicleState.getCurrentConfig();
            healthBarComponent.updateState(vehicleStateCfg);
            healthBarComponent.showDamage(vehicleStateCfg, newHealth, m_maxHealth, -delta, flag, damageType);
            var cfg = flag == Defines.FROM_PLAYER ? vehicleStateCfg.damageTextPlayer
                : flag == Defines.FROM_SQUAD ? vehicleStateCfg.damageTextSquadman : vehicleStateCfg.damageText;
            //Logger.addObject(cfg, 1, m_playerName);
            damageTextComponent.showDamage(cfg, newHealth, -delta, flag, damageType);
        }

        XVMUpdateDynamicTextFields();
    }

    /**
     * @see IVehicleMarker
     */
    public function updateState(newState:String, isImmediate:Boolean)
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
    public function showExInfo(show:Boolean)
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
    public function showActionMarker(actionState)
    {
        actionMarkerComponent.showActionMarker(actionState);
    }

    /**
     * @see IVehicleMarker
     */
    public function updateFlagbearerState(isFlagbearer:Boolean)
    {
        m_isFlagbearer = isFlagbearer;
        wrapper.flagMC._visible = m_isFlagbearer;
    }

    /**
     * Components extension: MovieClip.onEnterFrame translation
     * TODO: Check performance & implementation
     */
    public function onEnterFrame():Void
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
    private function onStatLoaded(event)
    {
        //trace("Xvm::onStatLoaded()");
        GlobalEventDispatcher.removeEventListener(Defines.E_STAT_LOADED, this, onStatLoaded);

        initializeTextFields();
        vehicleTypeComponent.setVehicleClass();
        XVMUpdateStyle();
    }

    public function setMarkerStateXvm(targets:Number, vehicleStatus:Number, frags:Number, my_frags:Number, squad:Number)
    {
        var needUpdate:Boolean = false;

        var prev:Boolean = m_isReady;
        m_isReady = (vehicleStatus & 2) != 0; // 2 - IS_AVATAR_READY
        if (prev != m_isReady)
            needUpdate = true;

        if (m_frags != frags)
        {
            //Logger.add('setMarkerStateXvm: ' + m_frags + " => " + frags + " " + m_playerName);
            m_frags = frags;
            needUpdate = true;
        }

        if (Macros.UpdateMyFrags(my_frags))
            needUpdate = true;

        if (m_squad != squad)
        {
            //Logger.add('setMarkerStateXvm: ' + m_squad + " => " + squad + " " + m_playerName);
            m_squad = squad;
            needUpdate = true;
        }

        if (needUpdate)
            XVMUpdateStyle();
    }

    private function XVMUpdateDynamicTextFields()
    {
        try
        {
            if (textFields)
            {
                var st = vehicleState.getCurrentState();
                for (var i in textFields[st])
                {
                    var tfi:TextField = textFields[st][i];
                    tfi.field.htmlText = "<textformat leading='-2'><p class='xvm_markerText'>" +
                        "<font color='#" + formatDynamicColor(tfi.color, m_curHealth).toString(16) + "'>" +
                        formatDynamicText(tfi.format, m_curHealth) + "</font></p></textformat>";

                    if (tfi.x != null)
                        tfi.field._x = parseInt(formatDynamicText(tfi.x, m_curHealth)) - (tfi.field._width / 2.0);
                    if (tfi.y != null)
                        tfi.field._y = parseInt(formatDynamicText(tfi.y, m_curHealth)) - (/*tfi.field._height*/ 31 / 2.0); // FIXIT: 31 is used for compatibility

                    tfi.field._alpha = formatDynamicAlpha(tfi.alpha, m_curHealth);

                    tfi.shadow.color = formatDynamicColor(tfi.sh_color, m_curHealth);
                    tfi.shadow.alpha = formatDynamicAlpha(tfi.sh_alpha, m_curHealth) / 100;
                    tfi.field.filters = [ tfi.shadow ];
                }
            }
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMUpdateDynamicTextFields():" + String(e));
        }
    }

    private function initializeTextFields()
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
                var len = cfg.textFields.length;
                for (var i = 0; i < len; ++i)
                {
                    if (cfg.textFields[i].visible)
                    {
                        //if (m_team == "ally")
                        //    Logger.addObject(cfg.textFields[i], m_vname + " " + m_playerName + " " + st);
                        //if (m_team == "enemy")
                        //    Logger.addObject(cfg.textFields[i], m_vname + " " + m_playerName + " " + st);
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

    /**
     * Create new TextField based on config
     */
    private function createTextField(cfg:Object):Object
    {
        try
        {
            var n = textFieldsHolder.getNextHighestDepth();
            var textField:TextField = textFieldsHolder.createTextField("textField" + n, n, 0, 0, 140, 100);

            //textField._quality = "BEST";
            textField.antiAliasType = "normal";
            //textField.antiAliasType = "advanced";
            //textField.gridFitType = "NONE";

            textField.multiline = true;
            textField.wordWrap = false;
            textField.selectable = false;

            //textField.border = true;
            //textField.borderColor = 0xFFFFFF;
            // http://theolagendijk.com/2006/09/07/aligning-htmltext-inside-flash-textfield/
            textField.autoSize = cfg.font.align || "center";

            var cfg_color_format_static = formatStaticColorText(cfg.color);
            var sh_color_format_static = formatStaticColorText(cfg.shadow.color);

            textField.html = true;
            textField.styleSheet = Utils.createStyleSheet(Utils.createCSSFromConfig(cfg.font,
                formatDynamicColor(cfg_color_format_static, m_curHealth), "xvm_markerText"));

//            Logger.add(XvmHelper.createCSS(cfg.font, formatDynamicColor(formatStaticColorText(cfg.color), m_curHealth), "xvm_markerText"));

            // TODO: replace shadow with TweenLite Shadow/Bevel (performance issue)
            var shadow:DropShadowFilter = null;
            if (cfg.shadow)
            {
                var sh_color:Number = formatDynamicColor(sh_color_format_static, m_curHealth);
                var sh_alpha:Number = formatDynamicAlpha(cfg.shadow.alpha, m_curHealth);
                shadow = GraphicsUtil.createShadowFilter(cfg.shadow.distance,
                    cfg.shadow.angle, sh_color, sh_alpha, cfg.shadow.size, cfg.shadow.strength);
                textField.filters = [ shadow ];
            }

            textField._alpha = formatDynamicAlpha(cfg.alpha, m_curHealth);
            textField._visible = cfg.visible;

            var cfg_x = cfg.x;
            if (isNaN(cfg_x))
                cfg_x = formatStaticText(cfg_x);
            var x:Number = isNaN(cfg_x) ? parseInt(cfg_x) : cfg_x;
            if (!isNaN(x))
                textField._x = x - (textField._width / 2.0);

            var cfg_y = cfg.y;
            if (isNaN(cfg_y))
                cfg_y = formatStaticText(cfg_y);
            var y:Number = isNaN(cfg_y) ? parseInt(cfg_y) : cfg_y;
            if (!isNaN(y))
                textField._y = y - (/*textField._height*/ 31 / 2.0); // FIXIT: 31 is used for compatibility

            return {
                field: textField,
                format: formatStaticText(cfg.format),
                color: cfg_color_format_static,
                x: isNaN(x) ? cfg_x : null,
                y: isNaN(y) ? cfg_y : null,
                alpha: cfg.alpha,
                shadow: shadow,
                sh_color: sh_color_format_static,
                sh_alpha: cfg.shadow.alpha
            };
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: createTextField():" + String(e));
        }

        return null;
    }

    private function XVMUpdateStyle()
    {
        Cmd.profMethodStart("Xvm.XVMUpdateStyle()");

        //Logger.add("XVMUpdateStyle: " + m_playerName + " " + m_vname);
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

        Cmd.profMethodEnd("Xvm.XVMUpdateStyle()");
    }

    // Utils

    public function getCurrentSystemColor():Number
    {
        return ColorsManager.getSystemColor(m_entityName, m_isDead, isBlowedUp);
    }

    /**
     * Text formatting functions
     */
    public function formatStaticText(format:String):String
    {
        return Strings.trim(Macros.Format(m_playerName, format));
    }

    /* Substitutes macroses with values
     *
     * Possible format values with simple config:
     * incoming format -> outcoming format
     * {{hp}} / {{hp-max}} -> 725 / 850
     * Patton -> Patton
     * -{{dmg}} -> -368
     * {{dmg}} -> 622
     *
     * Called by
     * XVMShowDamage(curHealth, delta)
     * XVMUpdateUI(curHealth) with textField aspect
     */
    public function formatDynamicText(format:String, curHealth:Number, delta:Number, damageFlag:Number, damageType:String):String
    {
        var obj:Object = {
            curHealth:curHealth,
            maxHealth:m_maxHealth,
            delta:isBlowedUp ? delta - 1 : delta, // curHealth = -1 for blowedUp
            damageFlag:damageFlag,
            damageType:damageType,
            entityName:m_entityName,
            ready:m_isReady,
            dead:m_isDead,
            blowedUp:isBlowedUp,
            teamKiller:m_entityName == "teamKiller",
            playerId:m_playerId,
            marksOnGun:m_marksOnGun,
            frags:m_frags,
            squad:m_squad
        };
        return Strings.trim(Macros.Format(m_playerName, format, obj));
    }

    public function formatStaticColorText(format:String):String
    {
        format = Strings.trim(Macros.Format(m_playerName, format));
        return format.split("#").join("0x");
    }

    public function formatDynamicColor(format:String, curHealth:Number, delta:Number, damageFlag:Number, damageType:String):Number
    {
        if (!format)
            return getCurrentSystemColor();

        if (!isNaN(format))
            return Number(format);

        format = formatDynamicText(format, curHealth, delta, damageFlag, damageType).split("#").join("0x");

        return !isNaN(format) ? Number(format) : getCurrentSystemColor();
    }

    public function formatDynamicAlpha(format:String, curHealth:Number):Number
    {
        if (format == null)
            return 100;

        if (isFinite(format))
            return Number(format);

        format = formatDynamicText(format, curHealth).split("#").join("0x");

        var n = isFinite(format) ? Number(format) : 100;
        return (n <= 0) ? 0 : (n > 100) ? 100 : n;
    }
}
