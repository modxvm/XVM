/**
 * ...
 * @author sirmax2
 */
import com.xvm.*;
import flash.filters.*;

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

    public static function toBool(value:Object, defaultValue:Boolean):Boolean
    {
        if ((typeof value) == "boolean")
            return Boolean(value);
        if (!value)
            return defaultValue;
        value = String(value).toLowerCase();
        return defaultValue ? value != "false" : value == "true";
    }

    public static function isArenaGuiTypeWithPlayerPanels():Boolean
    {
        // moved to as3
        return false;
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
     * Create Extended CSS
     */
    public static function createCSSExtended(className:String, color:Number, fontName:String,
        fontSize:Number, align:String, bold:Boolean, italic:Boolean, underline:Boolean, display:String, leading:Number,
        marginLeft:Number, marginRight:Number):String
    {
            return "." + className + " {" +
                "color:#" + Strings.padLeft(color.toString(16), 6, '0') + ";" +
                "font-family:\"" + fontName + "\";" +
                "font-size:" + fontSize + ";" +
                "text-align:" + align + ";" +
                "font-weight:" + (bold ? "bold" : "normal") + ";" +
                "font-style:" + (italic ? "italic" : "normal") + ";" +
                "text-decoration:" + (underline ? "underline" : "none") + ";" +
                "display:" + (display ? "display" : "inline") + ";" +
                "leading:" + leading + ";" +
                "margin-left:" + marginLeft + ";" +
                "margin-right:" + marginRight + ";" +
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

    /**
     *   (Get relative to screen resolution x or y coordinates for using when applying horizontal or vertical align to object
     */
     public static function HVAlign(align, WidthOrHeight: Number, isValign: Boolean)
        {
        //'align' allows only 'left', 'right', 'center' values for horizontal alignment and 'top', 'bottom', 'middle' or "center" for vertical
            switch (align) {
                case 'left':
                    return 0;
                case 'right' :
                    return Stage.width - WidthOrHeight;
                case 'center':
                    if (!isValign){
                      return (Stage.width/2) - (WidthOrHeight/2);
                    }
                    else {
                      return (Stage.height/2) - (WidthOrHeight/2);
                    }
                case 'top':
                    return 0;
                case 'bottom':
                    return Stage.height - WidthOrHeight;
                case 'middle':
                    return (Stage.height/2) - (WidthOrHeight/2);
            }

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
}
