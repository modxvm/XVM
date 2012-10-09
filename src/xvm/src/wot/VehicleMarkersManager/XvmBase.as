/**
 * Base xvm class with varous basic functions (like macros substitutions).
 * Class don't contain any workflow logic.
 */
import wot.utils.Defines;
import wot.utils.GraphicsUtil;
import wot.utils.Logger;
import wot.utils.StatFormat;
import wot.utils.Utils;
import wot.utils.VehicleInfo;
import wot.VehicleMarkersManager.ColorsManager;
import wot.VehicleMarkersManager.ErrorHandler;
import wot.VehicleMarkersManager.VehicleMarkerProxy;
import wot.VehicleMarkersManager.VehicleState;
import wot.VehicleMarkersManager.XvmHelper;
import wot.VehicleMarkersManager.components.ActionMarkerComponent;
import wot.VehicleMarkersManager.components.ClanIconComponent;
import wot.VehicleMarkersManager.components.ContourIconComponent;
import wot.VehicleMarkersManager.components.damage.DamageTextComponent;
import wot.VehicleMarkersManager.components.HealthBarComponent;
import wot.VehicleMarkersManager.components.LevelIconComponent;
import wot.VehicleMarkersManager.components.TurretStatusComponent;
import wot.VehicleMarkersManager.components.VehicleTypeComponent;

class wot.VehicleMarkersManager.XvmBase extends gfx.core.UIComponent
{
    // dummy var to avoid import warning
    private static var __dummy = Logger.dummy;

    /**
     * Trace function for debug purpose. Must be commented on release.
     * TODO: Is AS2/FD have any kind of conditional compilation?
     * @param	str
     */
    public function trace(str:String):Void
    {
        //if (m_playerFullName == "ayne_RU")
        //Logger.add(m_playerFullName + "> " + str);
    }

    // Private static members
    private static var s_showExInfo:Boolean = false; // Saved "Extended Info State" for markers that appeared when Alt pressed.
    private static var s_blowedUp:Object = {}; // List of members that was ammoracked.

    // Private members
    var m_entityName;
    var m_playerFullName;
    var m_curHealth;
    var m_maxHealth;
    var m_source;
    var m_vname;
    var m_level;
    var m_speaking;
    var m_entityType; // TODO: is the same as proxy.m_team?

    // Private members
    var m_showExInfo: Boolean;
    var m_isDead: Boolean;
    var m_defaultIconSource: String;

    // TextFields
    var textFields: Object;

    // Vehicle State
    var vehicleState: VehicleState;

    // UI Components
    var actionMarkerComponent: ActionMarkerComponent;
    var clanIconComponent:ClanIconComponent;
    var contourIconComponent: ContourIconComponent;
    var damageTextComponent: DamageTextComponent;
    var healthBarComponent: HealthBarComponent;
    var levelIconComponent: LevelIconComponent;
    var turretStatusComponent: TurretStatusComponent;
    var vehicleTypeComponent: VehicleTypeComponent;

    // Parent proxy instance (assigned from proxy)
    private var _proxy:VehicleMarkerProxy;
    public function get proxy() { return _proxy; }

    /**
     * Text formatting functions
     */

    public function formatStaticText(format:String):String
    {
        try
        {
            // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
            format = format.split("{{nick}}").join(m_playerFullName);
            format = format.split("{{vehicle}}").join(VehicleInfo.mapVehicleName(m_defaultIconSource, m_vname));
            format = format.split("{{level}}").join(String(m_level));
            format = format.split("{{rlevel}}").join(XvmHelper.rlevel[m_level - 1]);
            format = StatFormat.FormatText({ label: m_playerFullName }, format);
            format = Utils.trim(format);
        }
        catch (e)
        {
            ErrorHandler.setText("ERROR: formatStaticText(" + format + "):" + String(e));
        }
        return format;
    }

    public function formatDynamicText(format:String, curHealth:Number, delta:Number):String
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

    public function formatDynamicColor(format:String, curHealth:Number):Number
    {
        var systemColor =  ColorsManager.getSystemColor(m_entityName, m_isDead,
            s_blowedUp[m_playerFullName] != undefined, ColorsManager.isColorBlindMode);
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
            var textFormat: TextFormat = XvmHelper.createNewTextFormat(cfg.font);
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
            ErrorHandler.setText("ERROR: createTextField():" + String(e));
        }

        return null;
    }
}
