/**
 * Main XVM class, implements workflow logic.
 */
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Linear;
import com.greensock.easing.Cubic;
import wot.utils.Config;
import wot.utils.GlobalEventDispatcher;
import wot.utils.GraphicsUtil;
import wot.utils.StatData;
import wot.utils.StatLoader;
import wot.utils.Utils;
import wot.utils.Logger;
import wot.VehicleMarkersManager.ErrorHandler;
import wot.VehicleMarkersManager.VehicleMarkerProxy;
import wot.VehicleMarkersManager.components.ActionMarkerComponent;
import wot.VehicleMarkersManager.components.ActionMarkerProxy;
import wot.VehicleMarkersManager.components.ClanIconComponent;
import wot.VehicleMarkersManager.components.ClanIconProxy;
import wot.VehicleMarkersManager.components.ContourIconComponent;
import wot.VehicleMarkersManager.components.ContourIconProxy;
import wot.VehicleMarkersManager.components.LevelIconComponent;
import wot.VehicleMarkersManager.components.LevelIconProxy;
import wot.VehicleMarkersManager.components.TurretStatusComponent;
import wot.VehicleMarkersManager.components.TurretStatusProxy;
import wot.VehicleMarkersManager.VehicleState;
import wot.VehicleMarkersManager.VehicleStateProxy;
import wot.VehicleMarkersManager.XvmBase;
import wot.VehicleMarkersManager.XvmHelper;

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

    // Healthbar Settings
    var hbCfg: Object;

    /**
     * .ctor()
     * @param	proxy Parent proxy class (for placing UI Components)
     * @param	entityName Marker type (ally, enemy)
     */
    function Xvm(proxy:VehicleMarkerProxy, entityName:String)
    {
        super(); // gfx.core.UIComponent
        _proxy = proxy;
        m_entityName = m_team = entityName;
        Utils.TraceXvmModule("XVM");
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
        m_entityName = entityName; // ally, enemy, squadman, (teamkiller?)
        m_entityType = entityType; // ally, enemy
        m_maxHealth = maxHealth;
        m_vehicleClass = vClass; //mediumTank

        m_vname = vType; // AMX50F155
        m_level = vLevel;
        m_speaking = speaking;
        m_hunt = hunt;

        m_isDead    = curHealth <= 0; // -1 for ammunition storage explosion
        m_curHealth = curHealth >= 0 ? (curHealth) : (0);
        m_currentHealth = m_curHealth;

        // initMarkerLabel() handles color blind mode, squad and team killer.
        initMarkerLabel();

        actionMarkerComponent = new ActionMarkerComponent(new ActionMarkerProxy(this));
        clanIconComponent = new ClanIconComponent(new ClanIconProxy(this));
        contourIconComponent = new ContourIconComponent(new ContourIconProxy(this));
        levelIconComponent = new LevelIconComponent(new LevelIconProxy(this));
        turretStatusComponent = new TurretStatusComponent(new TurretStatusProxy(this));

        vehicleState = new VehicleState(new VehicleStateProxy(this));

        if (m_vehicleClass != null)
            setVehicleClass();

        if (m_markerState != null)
            proxy.marker.gotoAndPlay(m_markerState);

        xvmHB = proxy.createEmptyMovieClip("xvmHB", proxy.marker.getDepth() - 1); // Put health Bar to back.
        xvmHBBorder = xvmHB.createEmptyMovieClip("border", 1);
        xvmHBDamage = xvmHB.createEmptyMovieClip("damage", 2);
        xvmHBFill = xvmHB.createEmptyMovieClip("fill", 3);

        damageHolder = proxy.createEmptyMovieClip("damageHolder", proxy.getNextHighestDepth());

        XVMSetupNewHealth(m_curHealth);
        XVMInit();

        // Load stat
        if (Config.s_config.rating.showPlayersStatistics && !StatData.s_loaded)
        {
            GlobalEventDispatcher.addEventListener("stat_loaded", this, XVMInit);
            StatLoader.LoadLastStat();
        }
    }

    /**
     * @see IVehicleMarker
     */
    function update()
    {
        trace("Xvm::update()");
        this.updateMarkerLabel();
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
        //trace("Xvm::setSpeaking()");
        if (m_speaking == value)
            return;
        m_speaking = value;
        if (initialized)
            this.setVehicleClass();
        if (proxy.marker._visible != m_speaking)
            updateVehicleMarker(vehicleState.getCurrentStateConfigRoot());
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
        this.updateMarkerLabel();
    }

    /**
     * @see IVehicleMarker
     */
    function updateHealth(curHealth, flag, damageType) // TODO: use flag and damageType
    {
        trace("Xvm::updateHealth(" + curHealth + ", " + flag + ", " + damageType +")");
        if (curHealth < 0)
            s_blowedUp.push(m_playerFullName);
        m_isDead = curHealth <= 0;
        m_curHealth = m_isDead ? 0 : curHealth; // fix "-1"
        XVMSetupNewHealth(curHealth);
        XVMUpdateUI(curHealth);
    }

    /**
     * @see IVehicleMarker
     */
    function updateState(newState, isImmediate)
    {
        trace("updateState(" + newState + ", " + isImmediate + "): " + vehicleState.getCurrent() + " markerState=" + m_markerState);
        if (this.vehicleDestroyed)
            return;
        if (isImmediate && newState == "dead")
            newState = "immediate_" + newState;
        this.setMarkerState(newState);
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
    function XVMInit(event)
    {
        //ErrorHandler.setText("XVMInit()" + (event ? ": event=" + event.type : ""));
        //trace("Xvm::XVMInit()" + (event ? ": event=" + event.type : ""));
        if (event)
          GlobalEventDispatcher.removeEventListener("stat_loaded", this, XVMInit);
        XVMPopulateData();
        updateMarkerLabel();
        XVMUpdateStyle();
    }

    // CODE BELOW IS NOT CHECKED



    function setMarkerState(value)
    {
        trace("Xvm::setMarkerState(" + value + ")");
        m_markerState = value;
        if (initialized)
        {
            if (this.vehicleDestroyed)
            {
                if (m_speaking)
                    this.setVehicleClass();
            }
            proxy.marker.gotoAndPlay(m_markerState);
        }
    }

    function setVehicleClass()
    {
        if (proxy.marker.marker.iconHunt != null)
        {
            proxy.marker.marker.icon._visible = !m_hunt;
            proxy.marker.marker.iconHunt._visible = m_hunt;
            if (m_hunt)
                proxy.marker.marker.iconHunt.gotoAndStop(this._getVehicleClassName());
            else
                proxy.marker.marker.icon.gotoAndStop(this._getVehicleClassName());
        }
        else
            proxy.marker.marker.icon.gotoAndStop(this._getVehicleClassName());
    }

    function initMarkerLabel()
    {
        trace("Xvm::initMarkerLabel()");

        m_markerLabel = XvmHelper.getMarkerColorAlias(m_entityName, s_isColorBlindMode);
        proxy.gotoAndStop(m_markerLabel);

        updateColorBlindMode();
        XVMUpdateUI(m_curHealth);
    }

    function updateMarkerLabel()
    {
        trace("Xvm::updateMarkerLabel(): " + vehicleState.getCurrent() + " markerLabel=" + m_markerLabel);

        var aliasColor = XvmHelper.getMarkerColorAlias(m_entityName, s_isColorBlindMode);
        if (m_markerLabel == aliasColor)
            return;

        m_markerLabel = aliasColor;
        proxy.gotoAndStop(m_markerLabel);

        if (m_vehicleClass != null)
            this.setVehicleClass();

        if (m_markerState != null)
        {
            if (this.vehicleDestroyed)
                m_markerState = "immediate_dead";
            proxy.marker.gotoAndPlay(m_markerState);
        }

        updateColorBlindMode();

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
            var n = proxy.getNextHighestDepth();
            var textField: TextField = proxy.createTextField("textField" + n, n, 0, 0, 140, 31);
//            var textField: TextField = proxy.createTextField("textField" + n, n, 0, 0, 140 + 1, cfg.font.size + 4 + 1); // +1 because of ScaleForm bug
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
                var sh_color:Number = formatDynamicColor(formatStaticColorText(cfg.shadow.color), m_curHealth);
                var sh_alpha:Number = formatDynamicAlpha(cfg.shadow.alpha, m_curHealth);
                textField.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow.distance,
                    cfg.shadow.angle, sh_color, sh_alpha, cfg.shadow.size, cfg.shadow.strength) ];
            }

            var staticColor = formatStaticColorText(cfg.color);
            textField.textColor = formatDynamicColor(staticColor, m_curHealth);
            textField._alpha = formatDynamicAlpha(cfg.alpha, m_curHealth);
            textField._x = cfg.x - (textField._width / 2.0);
            textField._y = cfg.y - (textField._height / 2.0);
            textField._visible = cfg.visible;

            return { field: textField, format: formatStaticText(cfg.format), alpha: cfg.alpha, color: staticColor };
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
            var text = formatDynamicText(formatStaticText(msg), curHealth, delta);

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
                var sh_color:Number = formatDynamicColor(formatStaticColorText(cfg.shadow.color), m_curHealth);
                var sh_alpha:Number = formatDynamicAlpha(cfg.shadow.alpha, m_curHealth);
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
                GraphicsUtil.setColor(xvmHBDamage, formatDynamicColor(hbCfg.damage.color, curHealth));
                xvmHBDamage._alpha = formatDynamicAlpha(hbCfg.damage.alpha, curHealth);
                TweenLite.to(xvmHBDamage, hbCfg.damage.fade, {_xscale: 0, ease: Cubic.easeIn });
            }
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMSetupNewHealth():" + String(e));
        }
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
                    tf.field.text = formatDynamicText(tf.format, curHealth);
                    //tf.field.htmlText = "<p align='center'><font face='$FieldFont'>" + formatDynamicText(tf.format, curHealth) + "</font></p>";
                    tf.field.textColor = formatDynamicColor(tf.color, curHealth);
                    tf.field._alpha = formatDynamicAlpha(tf.alpha, curHealth);
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

            xvmHB._alpha = formatDynamicAlpha(cfg.alpha, curHealth);

            var ct = formatStaticColorText(cfg.color);
            var lct = formatStaticColorText(cfg.lcolor);
            var fullColor: Number = formatDynamicColor(ct, curHealth);
            var lowColor: Number = formatDynamicColor(lct || ct, curHealth);

            var percent: Number = curHealth / m_maxHealth;

            // determ current (real-time) color
            var currColor = GraphicsUtil.colorByRatio(percent, lowColor, fullColor);

            GraphicsUtil.setColor(xvmHBFill, currColor); // colorizing health bar
            xvmHBFill._alpha = formatDynamicAlpha(cfg.fill.alpha, curHealth);

            GraphicsUtil.setColor(xvmHBBorder, formatDynamicColor(cfg.border.color, curHealth));
            xvmHBBorder._alpha = formatDynamicAlpha(cfg.border.alpha, curHealth);

            GraphicsUtil.setColor(xvmHBDamage, formatDynamicColor(cfg.damage.color, curHealth));
            xvmHBDamage._alpha = formatDynamicAlpha(cfg.damage.alpha, curHealth);

            //Logger.add("color: " + cfg.color + " => " + currColor);
            //if (cfg.alpha == "{{a:hp-ratio}}")
            //    Logger.add(Math.round(percent * 100) + " => " + Math.round(xvmHB._alpha));
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: updateCurrentColor():" + String(e));
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
        //trace("Xvm::XVMInitializeTextFields()");
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

    function XVMPopulateData()
    {
        try
        {
            //Logger.add("XVMPopulateData: " + m_vname + " " + m_playerFullName);
            var start = new Date();

            var cfg = vehicleState.getCurrentStateConfigRootNormal();

            // Health Bar
            XVMDrawHealthBar(cfg.healthBar);

            // Initialize states and creating text fields
            XVMInitializeTextFields();

            // Create clan icon and place to mc.
            clanIconComponent.initialize(cfg.clanIcon, proxy);
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: XVMPopulateData():" + String(e));
        }
    }

    function updateVehicleMarker(state_cfg)
    {
        var cfg = state_cfg.vehicleIcon;

        visible = cfg.visible || (m_speaking && cfg.showSpeaker);
        if (visible)
        {
            // Vehicle Type Marker
            var x = cfg.scaleX * cfg.maxScale / 100;
            var y = cfg.scaleY * cfg.maxScale / 100;
            for (var childName in proxy.marker.marker)
            {
                //if (childName == "marker_shadow")
                //  return;

                var icon: MovieClip = proxy.marker.marker[childName];
                icon._x = x;
                icon._y = y;
                icon._xscale = icon._yscale = cfg.maxScale;

                //var ms: MovieClip = icon.duplicateMovieClip("marker_shadow", icon.getNextHighestDepth());
                //ms.gotoAndStop(icon._currentframe);
                //ms.filters = [ new DropShadowFilter(0, 0, 0, 1, 1, 1, 10, 1, false, true) ];
                //GraphicsUtil.setColor(icon, systemColor);
            }

            proxy.marker._x = cfg.x;
            proxy.marker._y = cfg.y;
            proxy.marker._alpha = formatDynamicAlpha(cfg.alpha, m_curHealth);
        }
        proxy.marker._visible = visible;

    }

    function XVMUpdateStyle()
    {
        //trace("XVMUpdateStyle: " + m_playerFullName + m_vname + " " + " scale=" + proxy.marker._xscale);
        try
        {
            var start = new Date();

            var cfg = vehicleState.getCurrentStateConfigRoot();

            var visible: Boolean;

            updateVehicleMarker(cfg);

            // Contour Icon
            contourIconComponent.updateState(cfg);

            // Level Icon
            levelIconComponent.updateState(cfg);

            // Action Marker
            actionMarkerComponent.updateState(cfg);

            // Clan Icon
            clanIconComponent.updateState(cfg);

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
                xvmHB._alpha = formatDynamicAlpha(cfg.healthBar.alpha, m_curHealth);
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
