/**
 * ...
 * @author sirmax2
 */
import com.xvm.*;
import flash.filters.*;
import com.xvm.DataTypes.*;

class com.xvm.Utils
{
    private static var TRACE_XVM_MODULES = true;

    public static function toInt(value:Object, defaultValue:Number):Number
    {
        if (!defaultValue)
            defaultValue = NaN;
        if (!value)
            return defaultValue;
        var n:Number = parseInt(value.toString());
        return isNaN(n) ? defaultValue : n;
    }

    public static function toFloat(value:Object, defaultValue:Number):Number
    {
        if (!defaultValue)
            defaultValue = NaN;
        if (!value)
            return defaultValue;
        var n:Number = parseFloat(value.toString());
        return isNaN(n) ? defaultValue : n;
    }

    public static function toBool(value:Object, defaultValue:Boolean):Boolean
    {
        if ((typeof value) == "boolean")
            return Boolean(value);
        if (!value)
            return defaultValue;
        value = String(value).toLowerCase();
        return defaultValue ? value != "false" : value == "true";
    }

    ////////////////////

    public static function vehicleClassToVehicleType(vclass:String):String
    {
        switch (vclass)
        {
            case "lightTank": return "LT";
            case "mediumTank": return "MT";
            case "heavyTank": return "HT";
            case "SPG": return "SPG";
            case "AT-SPG": return "TD";
            default: return vclass;
        }
    }

    public static function getMarksOnGunText(value:Number):String
    {
        if (value == null || !Config.config.texts.marksOnGun["_" + value])
            return null;
        var v:String = Config.config.texts.marksOnGun["_" + value];
        if (v.indexOf("{{l10n:") >= 0)
            v = Locale.get(v);
        return v;
    }

    public static function getSpottedText(value:String, isArty:Boolean):String
    {
        if (value == null)
            return null;

        if (isArty)
            value += "_arty";

        if (!Config.config.texts.spotted[value])
            return null;

        var v:String = Config.config.texts.spotted[value];
        if (v.indexOf("{{l10n:") >= 0)
            v = Locale.get(v);

        return v;
    }

    public static function getXvmUserText(status:Number):String
    {
        var value:String = isNaN(status) ? 'none' : (status & 0x01) ? 'on' : 'off';

        if (!Config.config.texts.xvmuser[value])
            return null;

        var v:String = Config.config.texts.xvmuser[value];
        if (v.indexOf("{{l10n:") >= 0)
            v = Locale.get(v);

        return v;
    }

    public static function getBattleTypeText(battleType:Number):String
    {
        var value:String = getBattleTypeStr(battleType);

        if (!Config.config.texts.battletype[value])
            return null;

        var v:String = Config.config.texts.battletype[value];
        if (v.indexOf("{{l10n:") >= 0)
            v = Locale.get(v);

        return v;
    }

    public static function getBattleTypeStr(battleType:Number):String
    {
        switch (battleType)
        {
            case 1: return 'regular';
            case 2: return 'training';
            case 3: return 'company';
            case 4: return 'tournament';
            case 5: return 'clan';
            case 6: return 'tutorial';
            case 7: return 'cybersport';
            case 8: return 'historical';
            case 9: return 'event_battles';
            case 10: return 'sortie';
            case 11: return 'fort_battle';
            case 12: return 'rated_cybersport';
            default: return 'unknown';
        }
    }

    public static function getTopClanText(clanInfoRank:Number):String
    {
        var value:String = isNaN(clanInfoRank) ? "regular" : clanInfoRank == 0 ? "persist" :
            clanInfoRank <= Config.networkServicesSettings.topClansCount ? "top" : "regular";

        if (!Config.config.texts.topclan[value])
            return null;

        var v:String = Config.config.texts.topclan[value];
        if (v.indexOf("{{l10n:") >= 0)
            v = Locale.get(v);

        return v;
    }

    //   src: ally, squadman, enemy, unknown, player (allytk, enemytk - how to detect?)
    public static function damageFlagToDamageSource(damageFlag:Number):String
    {
        switch (damageFlag)
        {
            case Defines.FROM_ALLY:
                return "ally";
            case Defines.FROM_ENEMY:
                return "enemy";
            case Defines.FROM_PLAYER:
                return "player";
            case Defines.FROM_SQUAD:
                return "squadman";
            case Defines.FROM_UNKNOWN:
            default:
                return "unknown";
        }
    }

    ////////////////////

    public static function GetPlayerName(fullplayername:String):String
    {
        var pos = fullplayername.indexOf("[");
        return (pos < 0) ? fullplayername : Strings.trim(fullplayername.slice(0, pos));
    }

    public static function GetClanNameWithoutBrackets(fullplayername:String):String
    {
        var pos:Number = fullplayername.indexOf("[");
        if (pos < 0)
            return null;
        var n:String = fullplayername.slice(pos + 1);
        return n.slice(0, n.indexOf("]"));
    }

    public static function GetClanNameWithBrackets(fullplayername:String):String
    {
        var clan:String = GetClanNameWithoutBrackets(fullplayername);
        return clan ? "[" + clan + "]" : null;
    }

    private static var xvmModules: Array = [];
    public static function TraceXvmModule(moduleName:String):Void
    {
        if (!TRACE_XVM_MODULES)
            return;
        if (_global["_xvm__trace_module_" + moduleName] != undefined)
            return;
        _global["_xvm__trace_module_" + moduleName] = 1;
        xvmModules.push(moduleName);
        Logger.add("xvm -> [\"" + xvmModules.join("\", \"") + "\"]");
    }

    ////////////////////

    /**
     * Get children MovieClips of MovieClip
     * FIXIT: skips TextField?
     */
    public static function getChildrenOf(target:MovieClip, recursive:Boolean):Array
    {
        var result:Array = [];
        for (var i in target)
        {
            if (target[i] instanceof MovieClip)
            {
                result.push(target[i]);

                /** Concatenate children of clips at this level,recurse */
                if (recursive)
                    result = result.concat(getChildrenOf(target[i],true));
            }
        }
        return result;
    }

    public static function removeChildren(mc:MovieClip, match:Function):Void
    {
        var children:Array = getChildrenOf(mc, false);
        var len:Number = children.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var child:MovieClip = MovieClip(children[i]);
            if (child == null)
                continue;
            if (match != null && !match(child))
                continue
            child.removeMovieClip();
        }
    }

    // Duplicate text field
    public static function duplicateTextField(mc:MovieClip, name:String, textField:TextField, yOffset:Number, align:String):TextField
    {
        var res:TextField = mc.createTextField(name, mc.getNextHighestDepth(),
            textField._x, textField._y + yOffset, textField._width, textField._height);
        res.antiAliasType = "advanced";
        res.html = true;
        res.selectable = false;
        res.autoSize = align; // http://theolagendijk.com/2006/09/07/aligning-htmltext-inside-flash-textfield/
        var tf: TextFormat = textField.getNewTextFormat();
        res.styleSheet = Utils.createStyleSheet(Utils.createCSS("xvm_" + name,
            tf.color, tf.font, tf.size, align, tf.bold, tf.italic));

        return res;
    }

    ////////////////////

    /**
     * Create CSS
     */
    public static function createCSS(className:String, color:Number,
        fontName:String, fontSize:Number, align:String, bold:Boolean, italic:Boolean):String
    {
        return "." + className + " {" +
            "color:#" + Strings.padLeft(color.toString(16), 6, '0') + ";" +
            "font-family:\"" + fontName + "\";" +
            "font-size:" + fontSize + ";" +
            "text-align:" + align + ";" +
            "font-weight:" + (bold ? "bold" : "normal") + ";" +
            "font-style:" + (italic ? "italic" : "normal") + ";" +
            "}";
    }

    /**
     * Create CSS based on config
     */
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

    public static function createStyleSheet(css:String):TextField.StyleSheet
    {
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(css);
        return style;
    }

    /** Create DropShadowFilter from config section */
    public static function extractShadowFilter(source:Object):DropShadowFilter
    {
        if (!source || !source.alpha || !source.strength || !source.blur)
            return null;
        return new DropShadowFilter(
            source.distance, // distance
            source.angle, // angle
            parseInt(source.color, 16),
            // DropShadowFilter accepts alpha be from 0 to 1.
            // 90 at default config.
            source.alpha * 0.01,
            source.blur,
            source.blur,
            source.strength);
    }

    ////////////////////

    // Fix <img src='xvm://...'> to <img src='img://XVM_IMG_RES_ROOT/...'> (res_mods/mods/shared_resources/xvm/res)
    // Fix <img src='cfg://...'> to <img src='img://XVM_IMG_CFG_ROOT/...'> (res_mods/configs/xvm)
    public static function fixImgTag(str:String):String
    {
        str = str.split("xvm://").join("img://" + Defines.XVM_IMG_RES_ROOT);
        str = str.split("cfg://").join("img://" + Defines.XVM_IMG_CFG_ROOT);
        return str;
    }

    // Fix 'img://...' to '../...'> (res_mods/x.x.x/gui/maps/icons)
    // Fix 'xvm://...' to '../../XVM_IMG_RES_ROOT/...'> (res_mods/mods/shared_resources/xvm/res)
    // Fix 'cfg://...' to '../../XVM_IMG_CFG_ROOT/...'> (res_mods/configs/xvm)
    public static function fixImgTagSrc(str:String):String
    {
        if (Strings.startsWith("img://gui/maps/icons/", str.toLowerCase()))
            return "../" + str.slice(10);
        return "../../" + Utils.fixImgTag(str).split("img://").join("");
    }

    public static function indexOf(array:Array, value:Object):Number
    {
        var i:Number = 0;
        var len:Number = array.length;
        while(i < len)
        {
            if (array[i] === value)
                return i;
            ++i;
        }
        return -1;
    }

    public static function getObjectValueByPath(obj, path:String)
    {
        if (obj === undefined)
            return undefined;

        if (path == "." || path == "")
            return obj;

        var p:Array = path.split("."); // "path.to.value"
        var o = obj;
        var p_len:Number = p.length;
        for (var i:Number = 0; i < p_len; ++i)
        {
            var opi = o[p[i]];
            if (opi === undefined)
                return undefined;
            o = opi;
        }
        return o == null ? null : Utils.clone(o);
    }

    /**
     * Deep copy
     */
    public static function clone(obj:Object):Object
    {
        /*var temp:ByteArray = new ByteArray();
        temp.writeObject(obj);
        temp.position = 0;
        return temp.readObject();*/
        return JSONx.parse(JSONx.stringify(obj, "", true));
    }

    public static function parseError(ex):String
    {
        if (ex.at == null)
            return (ex.name != null ? Strings.trim(ex.name) + ": " : "") + Strings.trim(ex.message);

        var head = ex.at > 0 ? ex.text.substring(0, ex.at) : "";
        head = head.split("\r").join("").split("\n").join("");
        while (head.indexOf("  ") != -1)
            head = head.split("  ").join(" ");
        head = head.substr(head.length - 75, 75);

        var tail = (ex.at + 1 < ex.text.length) ? ex.text.substring(ex.at + 1, ex.text.length) : "";
        tail = tail.split("\r").join("").split("\n").join("");
        while (tail.indexOf("  ") != -1)
        tail = tail.split("  ").join(" ");

        return "[" + ex.at + "] " + Strings.trim(ex.name) + ": " + Strings.trim(ex.message) + "\n  " +
            head + ">>>" + ex.text.charAt(ex.at) + "<<<" + tail;
    }

    // http://www.koreanrandom.com/forum/topic/2625-/
    public static function XEFF(EFF:Number):Number
    {
        return EFF < 350 ? 0 :
            Math.round(Math.max(0, Math.min(100,
                EFF*(EFF*(EFF*(EFF*(EFF*(EFF*
                0.00000000000000003388
                - 0.0000000000002469)
                + 0.00000000069335)
                - 0.00000095342)
                + 0.0006656)
                - 0.1485)
                - 0.85
            )));
    }

    public static function XWN6(WN6:Number):Number
    {
        return WN6 > 2300 ? 100 :
            Math.round(Math.max(0, Math.min(100,
                WN6*(WN6*(WN6*(WN6*(WN6*(WN6*
                0.00000000000000000466
                - 0.000000000000032413)
                + 0.00000000007524)
                - 0.00000006516)
                + 0.00001307)
                + 0.05153)
                - 3.9
            )));
    }

    public static function XWN8(WN8:Number):Number
    {
        return WN8 > 3400 ? 100 :
            Math.round(Math.max(0, Math.min(100,
                WN8*(WN8*(WN8*(WN8*(WN8*(WN8*
                0.00000000000000000009553
                - 0.0000000000000001644)
                - 0.00000000000426)
                + 0.0000000197)
                - 0.00003192)
                + 0.056265)
                - 0.157
            )));
    }

    public static function XWGR(WGR:Number):Number
    {
        return WGR > 11000 ? 100 :
            Math.round(Math.max(0, Math.min(100,
                WGR*(WGR*(WGR*(WGR*(WGR*(-WGR*
                0.0000000000000000000004209
                + 0.000000000000000012477)
                - 0.00000000000014338)
                + 0.0000000008309)
                - 0.000002361)
                + 0.01048)
                + 0.4
            )));
    }
}
