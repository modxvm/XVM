package preview
{

public class FormatText {

    public function formatStaticText(format:String):String
    {
        try
        {
            var formatArr:Array;

            formatArr = format.split("{{nick}}");
            if (formatArr.length > 1)
                format = formatArr.join(m_playerFullName);
            formatArr = format.split("{{vehicle}}");
            if (formatArr.length > 1)
                format = formatArr.join(VehicleInfo.mapVehicleName(m_defaultIconSource, m_vname));
            formatArr = format.split("{{level}}");
            if (formatArr.length > 1)
                format = formatArr.join(String(m_level));
            formatArr = format.split("{{rlevel}}");
            if (formatArr.length > 1)
                format = formatArr.join(XvmHelper.rlevel[m_level - 1]);
            formatArr = format.split("{{turret}}");
            if (formatArr.length > 1)
                format = formatArr.join(turretStatusComponent.getMarker());
            format = StatFormat.FormatText({ label: m_playerFullName }, format);
            format = Utils.trim(format);
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: formatStaticText(" + format + "):" + String(e));
        }
        return format;
    }

    public function formatDynamicText(format:String, curHealth:Number, delta:Number, damageType:String):String
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
            var dmgRatio: Number = delta ? Math.ceil(delta / m_maxHealth * 100) : 0;
            var formatArr:Array;

            // Text
            formatArr = format.split("{{hp}}");
            if (formatArr.length > 1)
                format = formatArr.join(String(curHealth));
            formatArr = format.split("{{hp-ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(String(hpRatio));
            formatArr = format.split("{{hp-max}}");
            if (formatArr.length > 1)
                format = formatArr.join(String(m_maxHealth));
            formatArr = format.split("{{dmg}}");
            if (formatArr.length > 1)
                format = formatArr.join(delta ? String(delta) : "");
            formatArr = format.split("{{dmg-ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(delta ? String(dmgRatio) : "");
            formatArr = format.split("{{dmg-kind}}");
            if (formatArr.length > 1)
                format = formatArr.join(delta ? Locale.get(damageType) : "");

            // Colors
            formatArr = format.split("{{c:hp}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, curHealth));
            formatArr = format.split("{{c:hp-ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio));
            formatArr = format.split("{{c:hp_ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio));
            formatArr = format.split("{{c:dmg-kind}}");
            if (formatArr.length > 1)
                format = formatArr.join(delta ? GraphicsUtil.GetDmgKindValue(damageType) : "")
            formatArr = format.split("{{c:dmg_kind}}");
            if (formatArr.length > 1)
                format = formatArr.join(delta ? GraphicsUtil.GetDmgKindValue(damageType) : "")
            formatArr = format.split("{{c:vtype}}");
            if (formatArr.length > 1)
            {
                if (vehicleTypeComponent != null)
                {
                    format = formatArr.join(GraphicsUtil.GetVTypeColorValue(m_defaultIconSource,
                        Utils.vehicleClassToVehicleType(vehicleTypeComponent.getVehicleClass())));
                }
            }

            format = Utils.trim(format);
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: formatDynamicText(" + format + "):" + String(e));
        }

        return format;
    }

    public function formatStaticColorText(format:String):String
    {
        try
        {
            if (!format || isFinite(format))
                return format;

            format = StatFormat.FormatText( { label: m_playerFullName }, format).split("#").join("0x");
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: formatStaticColorText(" + format + "):" + String(e));
        }

        return format;
    }

    public function formatDynamicColor(format:String, curHealth:Number, damageType:String):Number
    {
        var systemColor =  ColorsManager.getSystemColor(m_entityName, m_isDead, isBlowedUp, ColorsManager.isColorBlindMode);
        try
        {
            if (!format)
                return systemColor;

            if (isFinite(format))
                return Number(format);

            var hpRatio: Number = Math.ceil(curHealth / m_maxHealth * 100);
            var formatArr = format.split("{{c:hp}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, curHealth, "0x"));
            formatArr = format.split("{{c:hp-ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio, "0x"));
            formatArr = format.split("{{c:hp_ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio, "0x"));
            formatArr = format.split("{{c:dmg-kind}}");
            if (formatArr.length > 1)
                format = formatArr.join(damageType ? GraphicsUtil.GetDmgKindValue(damageType, "0x") : "");
            formatArr = format.split("{{c:dmg_kind}}");
            if (formatArr.length > 1)
                format = formatArr.join(damageType ? GraphicsUtil.GetDmgKindValue(damageType, "0x") : "");
            formatArr = format.split("{{c:vtype}}");
            if (formatArr.length > 1)
            {
                if (vehicleTypeComponent != null)
                {
                    format = formatArr.join(GraphicsUtil.GetVTypeColorValue(m_defaultIconSource,
                        Utils.vehicleClassToVehicleType(vehicleTypeComponent.getVehicleClass()), "0x"));
                }
            }
            return isFinite(format) ? Number(format) : systemColor;
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: formatDynamicColor(" + format + "):" + String(e));
        }

        return systemColor;
    }

    public function formatDynamicAlpha(format:String, curHealth:Number):Number
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
            ErrorHandler.setText("ERROR: formatDynamicAlpha(" + format + "):" + String(e));
        }

        return 100;
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
     * Create new TextField based on config
     */
    public function createTextField(cfg:Object):Object
    {
        try
        {
            var n = proxy.getNextHighestDepth();
            var textField: TextField = proxy.createTextField("textField" + n, n, 0, 0, 140, 100);

            //textField._quality = "BEST";
            textField.antiAliasType = "normal";
            //textField.antiAliasType = "advanced";
            //textField.gridFitType = "NONE";

            textField.multiline = true;
            textField.wordWrap = false;

            //textField.border = true;
            //textField.borderColor = 0xFFFFFF;
            //textField.autoSize = "center"; // http://theolagendijk.com/2006/09/07/aligning-htmltext-inside-flash-textfield/

            textField.html = true;

            var style:TextField.StyleSheet = new TextField.StyleSheet();
            style.parseCSS(XvmHelper.createCSS(cfg.font,
                formatDynamicColor(formatStaticColorText(cfg.color), m_curHealth), "xvm_markerText"));
            textField.styleSheet = style;

//            Logger.add(XvmHelper.createCSS(cfg.font, formatDynamicColor(formatStaticColorText(cfg.color), m_curHealth), "xvm_markerText"));

            // TODO: replace shadow with TweenLite Shadow/Bevel (performance issue)
            if (cfg.shadow)
            {
                var sh_color:Number = formatDynamicColor(formatStaticColorText(cfg.shadow.color), m_curHealth);
                var sh_alpha:Number = formatDynamicAlpha(cfg.shadow.alpha, m_curHealth);
                textField.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow.distance,
                    cfg.shadow.angle, sh_color, sh_alpha, cfg.shadow.size, cfg.shadow.strength) ];
            }

            textField._alpha = formatDynamicAlpha(cfg.alpha, m_curHealth);
            textField._x = cfg.x - (textField._width / 2.0);
            textField._y = cfg.y - (/*textField._height*/ 31 / 2.0); // FIXIT: 31 is used for compatibility
            textField._visible = cfg.visible;

            return { field: textField, format: formatStaticText(cfg.format), alpha: cfg.alpha };
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: createTextField():" + String(e));
        }

        return null;
    }

}
}
