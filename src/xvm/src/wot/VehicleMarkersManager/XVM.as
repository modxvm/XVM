/**
 * ...
 * @author Nicolas Siver
 * @author bkon
 * @author sirmax2
 * @author STL1te
 */
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Linear;
import com.greensock.easing.Cubic;
import net.wargaming.controls.UILoaderAlt
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.GraphicsUtil;
import wot.utils.IconLoader;
import wot.utils.StatData;
import wot.utils.StatFormat;
import wot.utils.StatLoader;
import wot.utils.Utils;
import wot.utils.Logger;
import wot.utils.PlayerInfo;
import wot.utils.VehicleInfo;
import wot.VehicleMarkersManager.ErrorHandler;
import wot.VehicleMarkersManager.VehicleMarkerProxy;
import wot.VehicleMarkersManager.components.LevelIconComponent;
import wot.VehicleMarkersManager.components.LevelIconProxy;
import wot.VehicleMarkersManager.components.TurretStatusComponent;
import wot.VehicleMarkersManager.components.TurretStatusProxy;
import wot.VehicleMarkersManager.VehicleState;
import wot.VehicleMarkersManager.VehicleStateProxy;

/*
 * XVM() instance creates corresponding marker
 * each time some player gets in line of sight.
 * Instantiated 14 times at normal round start.
 * Destructed when player get out of sight.
 * Thus may be instantiated ~50 times and more.
 */

class wot.VehicleMarkersManager.XVM extends gfx.core.UIComponent implements wot.VehicleMarkersManager.IVehicleMarker
{
    var _proxy:VehicleMarkerProxy;

    static var s_showExInfo;
    var m_entityName;
    var m_playerFullName;
    var m_curHealth;
    var m_maxHealth;
    var m_vehicleClass;
    var m_source;
    var m_vname;
    var m_level;
    var m_speaking;
    var m_hunt;
    var m_markerState;
    var m_markerLabel;

    // UI Elements
    var damageHolder: MovieClip;
    var xvmHB: MovieClip;
    var xvmHBBorder: MovieClip;
    var xvmHBFill: MovieClip;
    var xvmHBDamage: MovieClip;

    // Private static members
    static var s_blowedUp: Array = [];
    static var s_isColorBlindMode = false;

    // Private members
    var m_showExInfo: Boolean;
    var m_currentHealth: Number;
    var m_showMaxHealth: Boolean;
    var m_team: String;
    var m_isDead: Boolean;
    var m_clanIcon: UILoaderAlt;
    var m_iconset: IconLoader;
    var m_defaultIconSource: String;

    // TextFields
    var textFields: Object;

    var levelIconComponent: LevelIconComponent;
    var turretStatusComponent: TurretStatusComponent;

    var vehicleState: VehicleState;

    // Healthbar Settings
    var hbCfg: Object;

    // Level in roman numerals
    private static var rlevel: Array = [ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" ];

    function XVM(proxy:VehicleMarkerProxy, entityName:String)
    {
        super(); // gfx.core.UIComponent
        _proxy = proxy;
        m_entityName = m_team = entityName;
        Utils.TraceXvmModule("XVM");
    }

    // override
    function gotoAndStop(frame:Object)
    {
        //Logger.add(this["m_playerFullName"] + ": gotoAndStop(" + frame + ")");
        _proxy.gotoAndStop(frame);
    }

    function init(vClass, vIconSource, vType, vLevel, pFullName,
                  curHealth, maxHealth, entityName, speaking, hunt)
    {
        Logger.add("init for " + entityName + " " + pFullName);

        // Use currently remembered extended / normal status for new markers
        m_showExInfo = s_showExInfo;
        m_defaultIconSource = vIconSource;
        m_entityName = entityName;
        m_playerFullName = pFullName;
        m_maxHealth = maxHealth;
        m_vehicleClass = vClass;
        m_source = vIconSource;
        m_vname = vType;
        m_level = vLevel;
        m_speaking = speaking;
        m_hunt = hunt;
        
        m_isDead = curHealth <= 0;
        m_curHealth = curHealth >= 0 ? (curHealth) : (0);
        m_currentHealth = m_curHealth;
        
        // initMarkerLabel() handles color blind mode, squad and team killer.
        initMarkerLabel();

        setupIconLoader();

        levelIconComponent = new LevelIconComponent(new LevelIconProxy(this));
        turretStatusComponent = new TurretStatusComponent(new TurretStatusProxy(this));

        vehicleState = new VehicleState(new VehicleStateProxy(this));

        if (m_vehicleClass != null)
            setVehicleClass();

        if (m_markerState != null)
            _proxy.marker.gotoAndPlay(m_markerState);

        XVMPopulateData();
        XVMSetupNewHealth(m_curHealth);
        
        xvmHB = _proxy.createEmptyMovieClip("xvmHB", _proxy.marker.getDepth() - 1); // Put health Bar to back.
        xvmHBBorder = xvmHB.createEmptyMovieClip("border", 1);
        xvmHBDamage = xvmHB.createEmptyMovieClip("damage", 2);
        xvmHBFill = xvmHB.createEmptyMovieClip("fill", 3);

        damageHolder = _proxy.createEmptyMovieClip("damageHolder", _proxy.getNextHighestDepth());

        // Load stat
        XVMInit2();
        if (Config.s_config.rating.showPlayersStatistics && !StatData.s_loaded)
        {
            GlobalEventDispatcher.addEventListener("stat_loaded", this, XVMInit2);
            StatLoader.LoadLastStat();
        }
    }
    
    function XVMInit2(event)
    {
        //ErrorHandler.setText("XVMStatLoaded()" + (event ? ": event=" + event.type : ""));
        trace("XVM::XVMInit2()" + (event ? ": event=" + event.type : ""));
        if (event)
          GlobalEventDispatcher.removeEventListener("stat_loaded", this, XVMInit2);
        XVMPopulateData();
        updateMarkerLabel();
        XVMUpdateStyle();
    }

    function update()
    {
        this.updateMarkerLabel();
    }

    function updateMarkerSettings()
    {
        trace("XVM::updateMarkerSettings()");
        // do nothing
        // We don't use in-game settings. Yet.
    }

    function get vehicleDestroyed()
    {
        return (m_markerState == "dead" || m_markerState == "immediate_dead");
    }

    function setSpeaking(value)
    {
        trace("XVM::setSpeaking()");
        if (m_speaking == value)
            return;
        m_speaking = value;
        if (initialized)
            this.setVehicleClass();
        if (_proxy.marker._visible != m_speaking)
            XVMUpdateStyle();
    }

    function setMarkerState(value)
    {
        m_markerState = value;
        if (initialized)
        {
            if (this.vehicleDestroyed)
            {
                if (m_speaking)
                    this.setVehicleClass();
            }
            this.updateMarkerSettings();
            _proxy.marker.gotoAndPlay(m_markerState);
        }
    }

    function setEntityName(value)
    {
        if (value == m_entityName)
            return;
        m_entityName = value;
        this.updateMarkerLabel();
    }

    function updateHealth(curHealth)
    {
        trace("XVM::updateHealth()");
        if (curHealth < 0)
            s_blowedUp.push(m_playerFullName);
        m_isDead = curHealth <= 0;
        m_curHealth = m_isDead ? 0 : curHealth; // fix "-1"
        XVMSetupNewHealth(curHealth);
        XVMUpdateUI(curHealth);
    }

    // override
    function updateState(newState, isImmediate)
    {
        trace("XVM::updateState()");
        //Logger.add("updateState(): " + vehicleState.getCurrent() + " markerState=" + m_markerState + " pname=" + m_playerFullName);
        if (this.vehicleDestroyed)
            return;
        if (isImmediate && newState == "dead")
            newState = "immediate_" + newState;
        this.setMarkerState(newState);
        XVMUpdateStyle();
    }

    // override
    function showExInfo(show)
    {
        //trace("XVM::showExInfo()");
        if (m_showExInfo == show)
            return;
        m_showExInfo = show;

        // Save current extended / normal state flag to static variable, so
        // new markers can refer to it when rendered initially
        s_showExInfo = show;

        XVMUpdateStyle();
    }

    function showActionMarker(actionState)
    {
        _proxy.actionMarker.showAction(actionState);
    }

    /**
     * VehicleMarker overrides
     */
    function setupIconLoader()
    {
       /* Called by
        * populateData()
        * XVMpopulateData()
        */
        trace("XVM::setupIconLoader()");

        // Alternative icon set
        if (!m_iconset)
            m_iconset = new IconLoader(this, completeLoad);
        m_iconset.init(_proxy.iconLoader,
            [ m_source.split(Defines.CONTOUR_ICON_PATH).join(Config.s_config.iconset.vehicleMarker), m_source ]);
        _proxy.iconLoader.source = m_iconset.currentIcon;
    }

    function setVehicleClass()
    {
        if (_proxy.marker.marker.iconHunt != null)
        {
            _proxy.marker.marker.icon._visible = !m_hunt;
            _proxy.marker.marker.iconHunt._visible = m_hunt;
            if (m_hunt)
                _proxy.marker.marker.iconHunt.gotoAndStop(this._getVehicleClassName());
            else
                _proxy.marker.marker.icon.gotoAndStop(this._getVehicleClassName());
        }
        else
            _proxy.marker.marker.icon.gotoAndStop(this._getVehicleClassName());
    }

    function initMarkerLabel()
    {
        trace("XVM::initMarkerLabel()");

        m_markerLabel = XVMGetMarkerColorAlias();
        this.gotoAndStop(m_markerLabel);

        XVMUpdateMarkerLabel();
        XVMUpdateUI(m_curHealth);
    }

    function updateMarkerLabel()
    {
        trace("XVM::updateMarkerLabel()");
        //Logger.add("updateMarkerLabel(): " + vehicleState.getCurrent() + " markerLabel=" + m_markerLabel + " pname=" + m_playerFullName);

        var aliasColor = XVMGetMarkerColorAlias();
        if (m_markerLabel == aliasColor)
            return;

        m_markerLabel = aliasColor;
        this.gotoAndStop(m_markerLabel);

        if (m_vehicleClass != null)
            this.setVehicleClass();

        if (m_markerState != null)
        {
            if (this.vehicleDestroyed)
                m_markerState = "immediate_dead";
            _proxy.marker.gotoAndPlay(m_markerState);
        }
        this.updateMarkerSettings();

        XVMUpdateMarkerLabel();

        XVMIconCompleteLoad();

        // Update layout for the current marker state
        XVMUpdateStyle();
    }

    function _getVehicleClassName()
    {
        return (m_speaking && !this.vehicleDestroyed()) ? "dynamic" : m_vehicleClass;
    }

    /**
    * MAIN
    */

    function completeLoad()
    {
        _proxy.iconLoader._visible = false;
        onEnterFrame = function()
        {
            delete this.onEnterFrame;
            this.XVMIconCompleteLoad();
        };
    }

    // VehicleMarkerAlly should contain 4 named frames:
    // - green - normal ally
    // - gold - squad mate
    // - blue - teamkiller
    // - yellow - squad mate in color blind mode
    // VehicleMarkerEnemy should contain 2 named frames:
    // - red - normal enemy
    // - purple - enemy in color blind mode
    function XVMGetMarkerColorAlias()
    {
        //if (m_entityName != "ally" && m_entityName != "enemy" && m_entityName != "squadman" && m_entityName != "teamKiller")
        //  Logger.add("m_entityName=" + m_entityName);
        if (m_entityName == "ally")
            return "green";
        if (m_entityName == "squadman")
            return s_isColorBlindMode ? "yellow" : "gold";
        if (m_entityName == "teamKiller")
            return "blue";
        if (m_entityName == "enemy")
            return s_isColorBlindMode ? "purple" : "red";

        // if not found (node is not implemented), return inverted enemy color (for debug only)
        return s_isColorBlindMode ? "red" : "purple";
    }

    function XVMGetSystemColor()
    {
        var systemColorName: String = m_entityName + "_";
        systemColorName += (!vehicleDestroyed && !m_isDead) ? "alive_" : (Utils.indexOf(s_blowedUp, m_playerFullName) >= 0) ? "blowedup_" : "dead_";
        systemColorName += s_isColorBlindMode ? "blind" : "normal";
        return Config.s_config.colors.system[systemColorName];
    }

    function XVMFormatStaticText(format: String): String
    {
        try
        {
            // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
            format = format.split("{{nick}}").join(m_playerFullName);
            format = format.split("{{vehicle}}").join(VehicleInfo.mapVehicleName(m_defaultIconSource, m_vname));
            format = format.split("{{level}}").join(String(m_level));
            format = format.split("{{rlevel}}").join(String(rlevel[m_level - 1]));
            format = StatFormat.FormatText({ label: m_playerFullName }, format);
            format = Utils.trim(format);
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMFormatStaticText(" + format + "):" + String(e));
        }
        return format;
    }

    function XVMFormatDynamicText(format: String, curHealth: Number, delta: Number): String
    {
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

        try
        {
            // skip strings without macroses
            if (format.indexOf("{{") == -1)
                return format;

            var hpRatio: Number = Math.ceil(curHealth / m_maxHealth * 100);
            format = format.split("{{hp-ratio}}").join(String(hpRatio));
            format = format.split("{{hp}}").join(String(curHealth));
            format = format.split("{{hp-max}}").join(String(m_maxHealth));

            var dmgRatio: Number = delta ? Math.ceil(delta / m_maxHealth * 100) : 0;
            format = format.split("{{dmg-ratio}}").join(delta ? String(dmgRatio) : "");
            format = format.split("{{dmg}}").join(delta ? String(delta) : "");

            format = format.split("{{turret}}").join(turretStatusComponent.getMarker());

            format = Utils.trim(format);
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMFormatDynamicText(" + format + "):" + String(e));
        }

        return format;
    }

    function XVMFormatStaticColorText(format: String): String
    {
        try
        {
            if (!format || isFinite(format))
                return format;

            format = StatFormat.FormatText( { label: m_playerFullName }, format).split("#").join("0x");
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMFormatStaticColorText(" + format + "):" + String(e));
        }

        return format;
    }

    function XVMFormatDynamicColor(format: String, curHealth: Number): Number
    {
        var systemColor = XVMGetSystemColor();
        try
        {
            if (!format)
                return systemColor;

            if (isFinite(format))
                return Number(format);

            var hpRatio: Number = Math.ceil(curHealth / m_maxHealth * 100);
            var formatArr = format.split("{{c:hp}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, curHealth, "0x"))
            formatArr = format.split("{{c:hp-ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio, "0x"))
            formatArr = format.split("{{c:hp_ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio, "0x"))
            formatArr = format.split("{{c:vtype}}");
            if (formatArr.length > 1)
            {
                format = formatArr.join(GraphicsUtil.GetVTypeColorValue(m_defaultIconSource,
                    Utils.vehicleClassToVehicleType(m_vehicleClass), "0x"));
            }
            return isFinite(format) ? Number(format) : systemColor;
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMFormatDynamicColor(" + format + "):" + String(e));
        }

        return systemColor;
    }

    function XVMFormatDynamicAlpha(format: String, curHealth: Number): Number
    {
        try
        {
            if (!format)
                return 100;

            if (isFinite(format))
                return Number(format);

            var hpRatio: Number = Math.ceil(curHealth / m_maxHealth * 100);
            var formatArr = format.split("{{a:hp}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, curHealth).toString());
            formatArr = format.split("{{a:hp-ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO, hpRatio).toString());
            formatArr = format.split("{{a:hp_ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO, hpRatio).toString());

            var n = isFinite(format) ? Number(format) : 100;
            return (n <= 0) ? 1 : (n > 100) ? 100 : n;
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMFormatDynamicAlpha(" + format + "):" + String(e));
        }

        return 100;
    }

    function XVMCreateNewTextFormat(config_font: Object): TextFormat
    {
        try
        {
            if (!config_font)
                return null;

            return new TextFormat(
                config_font.name || "$FieldFont",
                config_font.size || 13,
                0x000000,
                config_font.bold,
                config_font.italic,
                false, null, null,
                config_font.align || "center",
                0, 0, 0, 0);
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMCreateNewTextFormat():" + String(e));
        }

        return null;
    }

    function XVMCreateTextField(cfg)
    {
        try
        {
            var n = _proxy.getNextHighestDepth();
            var textField: TextField = _proxy.createTextField("textField" + n, n, 0, 0, 140, 31);
//            var textField: TextField = _proxy.createTextField("textField" + n, n, 0, 0, 140 + 1, cfg.font.size + 4 + 1); // +1 because of ScaleForm bug
            textField.html = false; // FIXIT: in html mode Font and Position are wrong.
            textField.embedFonts = false;
            textField.selectable = false;
            textField.multiline = false;
            textField.wordWrap = false;
            textField.antiAliasType = "normal";
            //textField.antiAliasType = "advanced";
            //textField.gridFitType = "NONE";
            textField._quality = "BEST";
            //textField.border = true;
            //textField.borderColor = 0xFFFFFF;
            //textField.autoSize = "center"; // http://theolagendijk.com/2006/09/07/aligning-htmltext-inside-flash-textfield/
            var textFormat: TextFormat = XVMCreateNewTextFormat(cfg.font);
            textField.setNewTextFormat(textFormat);

            if (cfg.shadow)
            {
                var sh_color:Number = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.shadow.color), m_curHealth);
                var sh_alpha:Number = XVMFormatDynamicAlpha(cfg.shadow.alpha, m_curHealth);
                textField.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow.distance,
                    cfg.shadow.angle, sh_color, sh_alpha, cfg.shadow.size, cfg.shadow.strength) ];
            }

            var staticColor = XVMFormatStaticColorText(cfg.color);
            textField.textColor = XVMFormatDynamicColor(staticColor, m_curHealth);
            textField._alpha = XVMFormatDynamicAlpha(cfg.alpha, m_curHealth);
            textField._x = cfg.x - (textField._width / 2.0);
            textField._y = cfg.y - (textField._height / 2.0);
            textField._visible = cfg.visible;

            return { field: textField, format: XVMFormatStaticText(cfg.format), alpha: cfg.alpha, color: staticColor };
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMCreateTextField():" + String(e));
        }

        return null;
    }

    // Damage Visualization
    function removeTextField(f: TextField)
    {
        f.removeTextField();
        f = null;
    }

    function XVMShowDamage(curHealth, delta)
    {
        try
        {
            var cfg = vehicleState.getCurrentStateConfigRoot().damageText;

            if (!cfg.visible)
                return;

            var msg = (curHealth < 0) ? cfg.blowupMessage : cfg.damageMessage;
            var text = XVMFormatDynamicText(XVMFormatStaticText(msg), curHealth, delta);

            var n = damageHolder.getNextHighestDepth();
            var damageField: TextField = damageHolder.createTextField("damageField" + n, n, 0, 0, 140, 20);
            var animation: TimelineLite = new TimelineLite({ onComplete:removeTextField, onCompleteParams:[damageField] });

            // For some reason, DropShadowFilter is not rendered when textfield contains only one character,
            // so we're appending empty prefix and suffix to bypass this unexpected behavior
            damageField.text = " " + text + " ";
            damageField.antiAliasType = "advanced";
            damageField.autoSize = "left";
            damageField.border = false;
            damageField.embedFonts = true;
            damageField.setTextFormat(XVMCreateNewTextFormat(cfg.font));
            damageField.textColor = isFinite(cfg.color) ? Number(cfg.color)
                : Config.s_config.colors.system[m_entityName + "_alive_" + (s_isColorBlindMode ? "blind" : "normal")];
            damageField._x = -(damageField._width / 2.0);

            if (cfg.shadow)
            {
                var sh_color:Number = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.shadow.color), m_curHealth);
                var sh_alpha:Number = XVMFormatDynamicAlpha(cfg.shadow.alpha, m_curHealth);
                damageField.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow.distance,
                    cfg.shadow.angle, sh_color, sh_alpha, cfg.shadow.size, cfg.shadow.strength) ];
            }

            animation.insert(new TweenLite(damageField, cfg.speed, { _y: -cfg.maxRange, ease: Linear.easeOut } ), 0);
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: showDamage():" + String(e));
        }
    }

    // Health Visualization
    function XVMSetupNewHealth(curHealth)
    {
        try
        {
            var delta: Number = curHealth - m_currentHealth;
            if (delta < 0)
            {
                XVMUpdateHealthBar(curHealth, m_maxHealth); // colorizing health bar after taking damage

                XVMShowDamage(curHealth, -delta);

                m_currentHealth = curHealth;

                //Flow bar animation
                TweenLite.killTweensOf(xvmHBDamage);
                xvmHBDamage._x = hbCfg.border.size + hbCfg.width * (curHealth / m_maxHealth) - 1;
                xvmHBDamage._xscale = xvmHBDamage._xscale + 100 * (-delta / m_maxHealth);
                GraphicsUtil.setColor(xvmHBDamage, XVMFormatDynamicColor(hbCfg.damage.color, curHealth));
                xvmHBDamage._alpha = XVMFormatDynamicAlpha(hbCfg.damage.alpha, curHealth);
                TweenLite.to(xvmHBDamage, hbCfg.damage.fade, {_xscale: 0, ease: Cubic.easeIn });
            }
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMSetupNewHealth():" + String(e));
        }
    }

    function XVMUpdateMarkerLabel()
    {
        // Guess color blind mode
        if (m_markerLabel == "yellow" || m_markerLabel == "purple")
            s_isColorBlindMode = true;
        else if (m_markerLabel == "gold" || m_markerLabel == "red")
            s_isColorBlindMode = false;
    }

    function XVMUpdateUI(curHealth)
    {
        try
        {
            xvmHBFill._xscale = Math.min(curHealth / m_maxHealth * 100, 100);

            if (textFields)
            {
                var st = vehicleState.getCurrent();
                for (var i in textFields[st])
                {
                    var tf = textFields[st][i];
                    tf.field.text = XVMFormatDynamicText(tf.format, curHealth);
                    //tf.field.htmlText = "<p align='center'><font face='$FieldFont'>" + XVMFormatDynamicText(tf.format, curHealth) + "</font></p>";
                    tf.field.textColor = XVMFormatDynamicColor(tf.color, curHealth);
                    tf.field._alpha = XVMFormatDynamicAlpha(tf.alpha, curHealth);
                }
            }
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMUpdateUI():" + String(e));
        }
    }

    function XVMUpdateHealthBar(curHealth)
    {
        try
        {
            var cfg = vehicleState.getCurrentStateConfigRoot().healthBar;

            xvmHB._alpha = XVMFormatDynamicAlpha(cfg.alpha, curHealth);

            var ct = XVMFormatStaticColorText(cfg.color);
            var lct = XVMFormatStaticColorText(cfg.lcolor);
            var fullColor: Number = XVMFormatDynamicColor(ct, curHealth);
            var lowColor: Number = XVMFormatDynamicColor(lct || ct, curHealth);

            var percent: Number = curHealth / m_maxHealth;

            // determ current (real-time) color
            var currColor = GraphicsUtil.colorByRatio(percent, lowColor, fullColor);

            GraphicsUtil.setColor(xvmHBFill, currColor); // colorizing health bar
            xvmHBFill._alpha = XVMFormatDynamicAlpha(cfg.fill.alpha, curHealth);

            GraphicsUtil.setColor(xvmHBBorder, XVMFormatDynamicColor(cfg.border.color, curHealth));
            xvmHBBorder._alpha = XVMFormatDynamicAlpha(cfg.border.alpha, curHealth);

            GraphicsUtil.setColor(xvmHBDamage, XVMFormatDynamicColor(cfg.damage.color, curHealth));
            xvmHBDamage._alpha = XVMFormatDynamicAlpha(cfg.damage.alpha, curHealth);

            //Logger.add("color: " + cfg.color + " => " + currColor);
            //if (cfg.alpha == "{{a:hp-ratio}}")
            //    Logger.add(Math.round(percent * 100) + " => " + Math.round(xvmHB._alpha));
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: updateCurrentColor():" + String(e));
        }
    }

    function XVMIconCompleteLoad(event)
    {
        try
        {
            // Vehicle Icon
            var cfg = vehicleState.getCurrentStateConfigRootNormal().contourIcon;

            if (cfg.amount >= 0)
            {
                var tintColor: Number = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.color), m_curHealth);
                var tintAmount: Number = Math.min(100, Math.max(0, cfg.amount)) * 0.01;
                GraphicsUtil.setColor(_proxy.iconLoader, tintColor, tintAmount);
            }

            XVMUpdateStyle();
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMIconCompleteLoad():" + String(e));
        }
    }

    function XVMDrawHealthBar(cfg)
    {
        xvmHB.clear();
        xvmHBBorder.clear();
        xvmHBFill.clear();
        xvmHBDamage.clear();

        hbCfg = cfg;

        //GraphicsUtil.fillRect(xvmHB, 0, 0, hbCfg.width + 2 * hbCfg.border, hb.height + 2 * hb.border,
        //    cfg.healthBar.border.color, cfg.healthBar.border.alpha);
        GraphicsUtil.fillRect(xvmHBBorder, 0, 0, cfg.width + cfg.border.size * 2, cfg.height + cfg.border.size * 2);
        GraphicsUtil.fillRect(xvmHBFill, cfg.border.size, cfg.border.size, cfg.width, cfg.height);
        GraphicsUtil.fillRect(xvmHBDamage, cfg.border.size, cfg.border.size, cfg.width, cfg.height);

        xvmHBDamage._xscale = 0;

        XVMUpdateHealthBar(m_curHealth);
    }

    function XVMInitializeTextFields()
    {
        trace("XVM::XVMInitializeTextFields()");
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
                var cfg = vehicleState.getConfigRoot(st);

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
                        fields.push(XVMCreateTextField(cfg.textFields[i]));
                    }
                }
                textFields[st] = fields;
            }
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMInitializeTextFields():" + String(e));
        }
    }

    function XVMInitializeClanIcon(cfg)
    {
        if (m_clanIcon == null)
            m_clanIcon = PlayerInfo.createIcon(_proxy, cfg, cfg.x - (cfg.w / 2.0), cfg.y - (cfg.h / 2.0), Defines.TEAM_ALLY);
        PlayerInfo.setSource(m_clanIcon, Utils.GetPlayerName(m_playerFullName), Utils.GetClanName(m_playerFullName));
    }

    function XVMPopulateData()
    {
        try
        {
            //Logger.add("XVMPopulateData: " + m_vname + " " + m_playerFullName);
            var start = new Date();

            var cfg = vehicleState.getCurrentStateConfigRootNormal();

            // Vehicle Type Icon
            if (_proxy.iconLoader != null && _proxy.iconLoader.initialized)
                setupIconLoader();

            // Health Bar
            XVMDrawHealthBar(cfg.healthBar);

            // Initialize states and creating text fields
            XVMInitializeTextFields();

            // Initialize clan icons
            XVMInitializeClanIcon(cfg.clanIcon);
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMPopulateData():" + String(e));
        }
    }

    function XVMUpdateStyle()
    {
        try
        {
            trace("XVMUpdateStyle: " + m_playerFullName + m_vname + " " + " scale=" + _proxy.marker._xscale);
            var start = new Date();

            var cfg = vehicleState.getCurrentStateConfigRoot();

            var visible: Boolean;

            // Vehicle Type Marker
            visible = cfg.vehicleIcon.visible || (m_speaking && cfg.vehicleIcon.showSpeaker);
            if (visible)
            {
                // Vehicle Type Marker
                //var systemColor = XVMGetSystemColor();
                var x = cfg.vehicleIcon.scaleX * cfg.vehicleIcon.maxScale / 100;
                var y = cfg.vehicleIcon.scaleY * cfg.vehicleIcon.maxScale / 100;
                for (var childName in _proxy.marker.marker)
                {
                    //if (childName == "marker_shadow")
                    //  return;

                    var icon: MovieClip = _proxy.marker.marker[childName];
                    icon._x = x;
                    icon._y = y;
                    icon._xscale = icon._yscale = cfg.vehicleIcon.maxScale;

                    //var ms: MovieClip = icon.duplicateMovieClip("marker_shadow", icon.getNextHighestDepth());
                    //ms.gotoAndStop(icon._currentframe);
                    //ms.filters = [ new DropShadowFilter(0, 0, 0, 1, 1, 1, 10, 1, false, true) ];
                    //GraphicsUtil.setColor(icon, systemColor);
                }

                _proxy.marker._x = cfg.vehicleIcon.x;
                _proxy.marker._y = cfg.vehicleIcon.y;
                _proxy.marker._alpha = XVMFormatDynamicAlpha(cfg.vehicleIcon.alpha, m_curHealth);
            }
            _proxy.marker._visible = visible;

            // Level Icon
            levelIconComponent.updateState(cfg);

            // Action Marker
            visible = cfg.actionMarker.visible;
            if (visible)
            {
                _proxy.actionMarker._x = cfg.actionMarker.x;
                _proxy.actionMarker._y = cfg.actionMarker.y;
            }
            _proxy.actionMarker._visible = visible;

            // Vehicle Icon
            if (_proxy.iconLoader != null && _proxy.iconLoader.initialized)
            {
                visible = cfg.contourIcon.visible;
                if (visible)
                {
                    _proxy.iconLoader._x = cfg.contourIcon.x - (_proxy.iconLoader.contentHolder._width / 2.0);
                    _proxy.iconLoader._y = cfg.contourIcon.y - (_proxy.iconLoader.contentHolder._height / 2.0);
                    _proxy.iconLoader._alpha = XVMFormatDynamicAlpha(cfg.contourIcon.alpha, m_curHealth);
                }
                _proxy.iconLoader._visible = visible;
            }

            // Clan Icon
            if (m_clanIcon != null && m_clanIcon.source != "")
            {
                visible = cfg.clanIcon.visible;
                if (visible)
                {
                    var holder = m_clanIcon["holder"];
                    holder._x = cfg.clanIcon.x - (cfg.clanIcon.w / 2.0);
                    holder._y = cfg.clanIcon.y - (cfg.clanIcon.h / 2.0);
                    m_clanIcon.setSize(cfg.clanIcon.w, cfg.clanIcon.h);
                    holder._alpha = XVMFormatDynamicAlpha(cfg.clanIcon.alpha, m_curHealth);
                }
                m_clanIcon._visible = visible;
            }

            // Damage Text
            visible = cfg.damageText.visible;
            if (visible)
            {
                damageHolder._x = cfg.damageText.x;
                damageHolder._y = cfg.damageText.y;
            }
            damageHolder._visible = visible;

            // Health Bar
            visible = cfg.healthBar.visible;
            if (visible)
            {
                xvmHB._x = cfg.healthBar.x;
                xvmHB._y = cfg.healthBar.y;
                xvmHB._alpha = XVMFormatDynamicAlpha(cfg.healthBar.alpha, m_curHealth);
            }
            xvmHB._visible = visible;

            // Text fields
            if (textFields)
            {
                var st = vehicleState.getCurrent();
                for (var i in textFields)
                {
                    for (var j in textFields[i])
                        textFields[i][j].field._visible = (i == st);
                }
            }

            // Update Colors and Values
            XVMUpdateHealthBar(m_curHealth);
            XVMUpdateUI(m_curHealth);
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMUpdateStyle():" + String(e));
        }
    }
}
