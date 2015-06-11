/**
 * Base xvm class with varous basic functions (like macros substitutions).
 * Class don't contain any workflow logic.
 */
import com.xvm.*;
import flash.filters.*
import wot.VehicleMarkersManager.*;
import wot.VehicleMarkersManager.components.*;
import wot.VehicleMarkersManager.components.damage.*;

class wot.VehicleMarkersManager.XvmBase
{
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

    // Public members
    public var m_entityName:String;
    public var m_playerName:String;
    public var m_playerClan:String;
    public var m_playerRegion:String;
    //public var m_playerFullName:String;
    public var m_curHealth:Number;
    public var m_maxHealth:Number;
    public var m_source:String;
    public var m_vname:String;
    public var m_level:Number;
    public var m_speaking:Boolean;
    public var m_entityType:String; // TODO: is the same as proxy.m_team?
    private var m_isFlagbearer:Boolean;

    // Public members
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

    // Private members

    // UI Controls
    private var actionMarkerComponent:ActionMarkerComponent;
    private var clanIconComponent:ClanIconComponent;
    private var contourIconComponent:ContourIconComponent;
    private var damageTextComponent:DamageTextComponent;
    private var healthBarComponent:HealthBarComponent;
    private var levelIconComponent:LevelIconComponent;
    private var turretStatusComponent:TurretStatusComponent;
    private var vehicleTypeComponent:VehicleTypeComponent;
    private var textFields:Object;

    // Parent proxy instance (assigned from proxy)
    private var _proxy:VehicleMarkerProxy;
    public function get proxy():VehicleMarkerProxy { return _proxy; }

    public function get wrapper():net.wargaming.ingame.VehicleMarker { return proxy.wrapper; }

    public function get isBlowedUp():Boolean { return s_blowedUp[m_playerName] != undefined; }

    private function getCurrentSystemColor():Number
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

    /**
     * Create new TextField based on config
     */
    public function createTextField(cfg:Object):Object
    {
        try
        {
            var n = wrapper.getNextHighestDepth();
            var textField: TextField = wrapper.createTextField("textField" + n, n, 0, 0, 140, 100);

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
}
