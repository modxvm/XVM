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

        // markers.ally.alive.normal
        var vehicleStateCfg:Object = vehicleState.getCurrentConfig();
        healthBarComponent.updateState(vehicleStateCfg);
        healthBarComponent.showDamage(vehicleStateCfg, newHealth, m_maxHealth, -delta, flag, damageType);
        var cfg = flag == Defines.FROM_PLAYER ? vehicleStateCfg.damageTextPlayer
            : flag == Defines.FROM_SQUAD ? vehicleStateCfg.damageTextSquadman : vehicleStateCfg.damageText;
        //Logger.addObject(cfg, 1, m_playerName);
        if (delta < 0) // Damage has been done
        {
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
        if (wrapper.marker2 != null)
        {
            wrapper.marker2._visible = m_isFlagbearer;
        }
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
        GlobalEventDispatcher.removeEventListener(Events.E_STAT_LOADED, this, onStatLoaded);

        initializeTextFields();
        vehicleTypeComponent.setVehicleClass();
        XVMUpdateStyle();
    }

    public function as_xvm_setMarkerState(targets:Number, vehicleStatus:Number, frags:Number, my_frags:Number, squad:Number)
    {
        var needUpdate:Boolean = false;

        var prev:Boolean = m_isReady;
        m_isReady = (vehicleStatus & 2) != 0; // 2 - IS_AVATAR_READY
        if (prev != m_isReady)
            needUpdate = true;

        if (m_frags != frags)
        {
            //Logger.add('as_xvm_setMarkerState: ' + m_frags + " => " + frags + " " + m_playerName);
            m_frags = frags;
            needUpdate = true;
        }

        if (Macros.UpdateMyFrags(my_frags))
            needUpdate = true;

        if (m_squad != squad)
        {
            //Logger.add('as_xvm_setMarkerState: ' + m_squad + " => " + squad + " " + m_playerName);
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
            Logger.err(e);
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
            Logger.err(e);
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
    /*
    public static function createCSSFromConfig(config_font:Object, color:Number, className:String):String
    {
        return createCSS(className,
            color,
            config_font && config_font.name ? config_font.name : "$FieldFont",
            config_font && config_font.size ? config_font.size : 13,
            config_font && config_font.align ? config_font.align : "center",
            config_font && config_font.bold ? true : false,
            config_font && config_font.italic ? true : false);
    }
    */

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
            Logger.err(e);
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
            Logger.err(e);
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
            squad:m_squad,
            x_enabled:m_x_enabled,
            x_sense_on: m_x_sense_on,
            x_fire:m_x_fire,
            x_overturned:m_x_overturned,
            x_drowning:m_x_drowning,
            x_spotted:m_x_spotted
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

    // xmqp events

    public function as_xvm_onXmqpEvent(event:String, data_str:String)
    {
        //Logger.add(event + " " + m_playerId + " " + data_str);
        var data:Object = data_str ? JSONx.parse(data_str) : null;
        switch (event)
        {
            case Events.XMQP_HOLA:
                onHolaEvent(data);
                break;
            case Events.XMQP_FIRE:
                onFireEvent(data);
                break;
            case Events.XMQP_VEHICLE_TIMER:
                onVehicleTimerEvent(data);
                break;
            case Events.XMQP_SPOTTED:
                onSpottedEvent();
                break;
            case Events.XMQP_DEATH_ZONE_TIMER:
                // TODO
                break;
            default:
                Logger.add("WARNING: unknown xmqp event: " + event);
                break;
        }
    }

    // {{x-enabled}}
    // {{x-sense-on}}

    private function onHolaEvent(data:Object)
    {
        var needUpdate:Boolean = false;
        if (!m_x_enabled)
        {
            m_x_enabled = true;
            needUpdate = true;
        }

        if (m_x_sense_on != Boolean(data.sixthSense))
        {
            m_x_sense_on = Boolean(data.sixthSense);
            needUpdate = true;
        }

        if (needUpdate)
        {
            XVMUpdateStyle();
        }
    }

    // {{x-fire}}

    private function onFireEvent(data:Object)
    {
        if (m_x_fire != data.enable)
        {
            m_x_fire = data.enable;
            XVMUpdateStyle();
        }
    }

    // {{x-overturned}}
    // {{x-drowning}}

    private function onVehicleTimerEvent(data:Object)
    {
        var updated:Boolean = false;
        switch (data.code)
        {
            case Defines.VEHICLE_MISC_STATUS_VEHICLE_IS_OVERTURNED:
                if (m_x_overturned != data.enable)
                {
                    m_x_overturned = data.enable;
                    updated = true;
                }
                break;

            case Defines.VEHICLE_MISC_STATUS_VEHICLE_DROWN_WARNING:
                if (m_x_drowning != data.enable)
                {
                    m_x_drowning = data.enable;
                    updated = true;
                }
                break;

            case Defines.VEHICLE_MISC_STATUS_ALL:
                if (m_x_drowning != data.enable)
                {
                    m_x_drowning = data.enable;
                    updated = true;
                }
                if (m_x_overturned != data.enable)
                {
                    m_x_overturned = data.enable;
                    updated = true;
                }
                break;

            default:
                Logger.add("WARNING: unknown vehicle timer code: " + data.code);
        }

        if (updated)
            XVMUpdateStyle();
    }

    // {{x-spotted}}

    private var _sixSenseIndicatorTimeoutId = null;

    private function onSpottedEvent()
    {
        if (!m_x_spotted)
        {
            m_x_spotted = true;
            XVMUpdateStyle();
        }
        if (_sixSenseIndicatorTimeoutId)
        {
            _global.clearTimeout(_sixSenseIndicatorTimeoutId);
        }
        var $this = this;
        _sixSenseIndicatorTimeoutId =
            _global.setTimeout(function() { $this.onSpottedEventDone(); }, Config.config.xmqp.spottedTime * 1000);
    }

    private function onSpottedEventDone()
    {
        _sixSenseIndicatorTimeoutId = null;
        if (m_x_spotted)
        {
            m_x_spotted = false;
            XVMUpdateStyle();
        }
    }

}
