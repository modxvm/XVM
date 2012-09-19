/**
 * Base xvm class with varous basic functions (like macros substitutions).
 * Class don't contain any workflow logic.
 */
import net.wargaming.controls.UILoaderAlt;
import wot.utils.Defines;
import wot.utils.GraphicsUtil;
import wot.utils.Logger;
import wot.utils.StatFormat;
import wot.utils.Utils;
import wot.utils.VehicleInfo;
import wot.VehicleMarkersManager.ErrorHandler;
import wot.VehicleMarkersManager.VehicleMarkerProxy;
import wot.VehicleMarkersManager.VehicleState;
import wot.VehicleMarkersManager.XvmHelper;
import wot.VehicleMarkersManager.components.ContourIconComponent;
import wot.VehicleMarkersManager.components.LevelIconComponent;
import wot.VehicleMarkersManager.components.TurretStatusComponent;

class wot.VehicleMarkersManager.XvmBase extends gfx.core.UIComponent
{
    /**
     * Trace function for debug purpose. Must be commented on release.
     * TODO: Is AS2/FD have any kind of conditional compilation?
     * @param	str
     */
    public function trace(str:String):Void
    {
        //if (m_playerFullName == "dosik_dai")
        Logger.add(m_playerFullName + "> " + str);
    }

    // Level in roman numerals
    private static var rlevel: Array = [ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" ];

    // Private static members
    private static var s_showExInfo:Boolean = false; // Saved "Extended Info State" for markers that appeared when Alt pressed.
    private static var s_blowedUp: Array = []; // List of members that was ammoracked.
    private static var s_isColorBlindMode = false;

    // Private members
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
    var m_entityType;

    // Private members
    var m_showExInfo: Boolean;
    var m_currentHealth: Number;
    var m_showMaxHealth: Boolean;
    var m_team: String; // TODO: is the same as m_entityType?
    var m_isDead: Boolean;
    var m_clanIcon: UILoaderAlt;
    var m_defaultIconSource: String;

    // UI Elements
    var damageHolder: MovieClip;
    var xvmHB: MovieClip;
    var xvmHBBorder: MovieClip;
    var xvmHBFill: MovieClip;
    var xvmHBDamage: MovieClip;

    // TextFields
    var textFields: Object;

    // UI Components
    var contourIconComponent: ContourIconComponent;
    var levelIconComponent: LevelIconComponent;
    var turretStatusComponent: TurretStatusComponent;

    // Vehicle State
    var vehicleState: VehicleState;

    // Parent proxy instance (assigned from proxy)
    private var _proxy:VehicleMarkerProxy;
    public function get proxy() { return _proxy; }

    /**
     * Guess color blind mode
     */
    function updateColorBlindMode()
    {
        if (m_markerLabel == "yellow" || m_markerLabel == "purple")
            s_isColorBlindMode = true;
        else if (m_markerLabel == "gold" || m_markerLabel == "red")
            s_isColorBlindMode = false;
    }

    // TODO: Can be replaced with m_isDead?
    function get vehicleDestroyed()
    {
        return (m_markerState == "dead" || m_markerState == "immediate_dead");
    }

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
            ErrorHandler.setText("ERROR: XVMFormatDynamicText(" + format + "):" + String(e));
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
            ErrorHandler.setText("ERROR: XVMFormatStaticColorText(" + format + "):" + String(e));
        }

        return format;
    }

    public function formatDynamicColor(format:String, curHealth:Number):Number
    {
        var systemColor =  XvmHelper.getSystemColor(m_entityName, vehicleDestroyed || m_isDead,
            Utils.indexOf(s_blowedUp, m_playerFullName) >= 0, s_isColorBlindMode);
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
            ErrorHandler.setText("ERROR: XVMFormatDynamicAlpha(" + format + "):" + String(e));
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
}
