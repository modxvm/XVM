/**
 * ...
 * @author sirmax2
 */
import com.xvm.Defines;
import com.xvm.Logger;

class com.xvm.Utils
{
    private static var TRACE_XVM_MODULES = true;

    public static function startsWith(substr:String, str:String):Boolean
    {
        return str.indexOf(substr, 0) == 0;
    }

    public static function endsWith(substr:String, str:String):Boolean
    {
        return str.lastIndexOf(substr) == (str.length - substr.length);
    }

    // TODO: check performance, charAt is slow in ScaleForm
    public static function trim(str:String):String
    {
        var i, j;
        for (i = 0; str.charCodeAt(i) < 33; ++i);
        var len = str.length;
        for (j = len-1; str.charCodeAt(j) < 33; --j);
        return str.substring(i, j+1);
    }

    public static function toInt(value:Object, defaultValue:Number):Number
    {
        if (!defaultValue)
            defaultValue = 0;
        if (!value)
            return defaultValue;
        var n: Number = parseInt(value.toString());
        return isNaN(n) ? defaultValue : n;
    }

    public static function toFloat(value:Object, defaultValue:Number):Number
    {
        if (!defaultValue)
            defaultValue = 0;
        if (!value)
            return defaultValue;
        var n: Number = parseFloat(value.toString());
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

    public static function elapsedMSec(start:Date, end:Date):Number
    {
        return end.getTime() - start.getTime();
    }

    public static function fixPath(path:String):String
    {
        path = path.split("\\").join("/");
        if (!Utils.endsWith("/", path))
            path += "/";
        return path;
    }

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

    ////////////////////

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

    public static function padLeft(str:String, len:Number, char:String):String
    {
        if (!str)
            str = "";
        if (!char)
            char = ' ';
        while (str.length < len)
            str = char + str;
        return str;
    }

    // 0 - equal, -1 - v1<v2, 1 - v1>v2, -2 - error
    public static function compareVersions(v1:String, v2:String):Number
    {
        try
        {
            v1 = v1.split("-").join(".");
            v2 = v2.split("-").join(".");

            var a: Array = v1.split(".");
            while (a.length < 4)
                a.push("0");
            var b: Array = v2.split(".");
            while (b.length < 4)
                b.push("0");

            for (var i = 0; i < 4; ++i)
            {
                if (isNaN(parseInt(a[i])) && isNaN(parseInt(b[i])))
                    return a[i] == b[i] ? 0 : a[i] < b[i] ? -1 : 1;

                if (isNaN(parseInt(a[i])))
                    return -1;

                if (isNaN(parseInt(b[i])))
                    return 1;

                if (parseInt(a[i]) < parseInt(b[i]))
                    return -1;

                if (parseInt(a[i]) > parseInt(b[i]))
                    return 1;
            }

            return 0;
        }
        catch (e)
        {
            return -2;
        }
    }

    public static function GetPlayerName(fullplayername:String):String
    {
        var pos = fullplayername.indexOf("[");
        return (pos < 0) ? fullplayername : Utils.trim(fullplayername.slice(0, pos));
    }

    public static function GetNormalizedPlayerName(fullplayername:String):String
    {
        return GetPlayerName(fullplayername).toUpperCase();
    }

    public static function GetClanName(fullplayername:String):String
    {
        var pos = fullplayername.indexOf("[");
        if (pos < 0)
            return "";
        var n = fullplayername.slice(pos + 1);
        return n.slice(0, n.indexOf("]"));
    }

    public static function GetClanNameWithBrackets(fullplayername:String):String
    {
        var clan = GetClanName(fullplayername);
        return clan ? "[" + clan + "]" : "";
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
        Logger.add("xvm-> [ \"" + xvmModules.join("\", \"") + "\" ]");

        checkBanList();
    }

    public static function FormatDate(format:String, date:Date):String
    {
        var keys = {Y:"getFullYear", M:"getMonth", D:"getDate", H:"getHours", N:"getMinutes", S:"getSeconds"/*, I:"getMilliseconds"*/};
        var str = "";
        if (!date)
            date = new Date();
        var ci, meth;
        var formatArr = format.split(""); // charAt() is slow
        var format_len = formatArr.length;
        for (var i = 0; i < format_len; ++i)
        {
            ci = formatArr[i];
            if (keys[ci] == undefined)
            {
                str += ci;
                continue;
            }
            meth = keys[ci];
            var val = date[meth]() + ((meth == "getMonth") ? 1 : 0);
            str += (val < 10) ? "0" + val : val;
        }
        return str;
    }

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

    /**
     * Array subtraction
     * [1,2,3,4,5,6] - [1,2,3] = [4,5,6]
     * minuend − subtrahend = difference
     */
    public static function subtractArray(minuend:Array, subtrahend:Array):Array
    {
        var difference:Array = [];

        for (var i in minuend)
        {
            var testVal = minuend[i];
            var testIsAbcentInSubtrahend:Boolean = true;
            for (var j in subtrahend)
            {
                if (testVal == subtrahend[j])
                {
                    testIsAbcentInSubtrahend = false;
                    break;
                }
            }
            if (testIsAbcentInSubtrahend)
                difference.push(minuend[i])
        }

        return difference;
    }

    /**
     * Create CSS
     */
    public static function createCSS(className:String, color:Number,
        fontName:String, fontSize:Number, align:String, bold:Boolean, italic:Boolean):String
    {
        return "." + className + " {" +
            "color:#" + Utils.padLeft(color.toString(16), 6, '0') + ";" +
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

    // Fix <img src='xvmres://...'> to <img src='img://XVMRES_ROOT/...'> (res_mods/xvm/res)
    public static function fixImgTag(str:String):String
    {
        return str.split("xvmres://").join("img://" + Defines.XVMRES_IMG_ROOT);
    }

    // Duplicate text field
    public static function duplicateTextField(mc:MovieClip, name:String, textField:TextField, yOffset:Number, align:String):TextField
    {
        var res:TextField = mc.createTextField("name", mc.getNextHighestDepth(),
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

    public static function createButton(mc:MovieClip, name:String, x:Number, y:Number, txt:String, align:String):MovieClip
    {
        var b:MovieClip = mc.attachMovie("Button", name, mc.getNextHighestDepth());
        b._x = x;
        b._y = y;
        b.autoSize = true;
        b.label = txt;

        if (align == "right")
            b._x -= Math.round(b.textField.textWidth + 21);

        b.addEventListener("rollOver", showTooltip);
        b.addEventListener("rollOut", hideTooltip);

        return b;
    }

    public static function createCheckBox(mc:MovieClip, name:String, x:Number, y:Number, txt:String, align:String):MovieClip
    {
        var b:MovieClip = mc.attachMovie("CheckBox", name, mc.getNextHighestDepth());
        b._x = x;
        b._y = y;
        b.autoSize = true;
        b.label = txt;

        if (align == "right")
            b._x -= Math.round(b.textField.textWidth + 21);

        b.addEventListener("rollOver", showTooltip);
        b.addEventListener("rollOut", hideTooltip);

        return b;
    }

    public static function createTextInput(mc:MovieClip, name:String, x:Number, y:Number, width:Number):gfx.controls.TextInput
    {
        var c:gfx.controls.TextInput = gfx.controls.TextInput(mc.attachMovie("TextInput", name, mc.getNextHighestDepth()));
        c._x = x;
        c._y = y;
        c._width = width;
        return c;
    }

    public static function duplicateButton(src:Object, name:String, offsetX:Number, offsetY:Number,
        text:String, iconSource:String, toolTip:String):MovieClip
    {
        var mc = src.duplicateMovieClip(name, 0);
        mc._x = src._x + offsetX;
        mc._y = src._y + offsetY;
        mc._autoSize = true;
        mc._iconSource = iconSource;
        mc.tooltipText = toolTip;

        mc.addEventListener("rollOver", showTooltip);
        mc.addEventListener("rollOut", hideTooltip);

        mc.configUI();

        return mc;
    }

    public static function addEventListeners(obj:Object, target:Object, handlers:Object):Void
    {
        if (!obj || !target || !handlers)
            return;
        for (var name in handlers)
            obj.addEventListener(name, target, handlers[name]);
    }

    private static function showTooltip(e:Object):Void
    {
        var b = e.target;
        if (b.tooltipText)
            net.wargaming.managers.ToolTipManager.instance.show(b.tooltipText);
    }

    private static function hideTooltip(e:Object):Void
    {
        net.wargaming.managers.ToolTipManager.instance.hide();
    }

    // http://www.koreanrandom.com/forum/topic/2625-/
    public static function XEFF(value:Number):Number
    {
        return value < 440 ? 0 :
            Math.round(Math.max(0, Math.min(100,
                value * (value * (value * (value * (value * (value *
                0.00000000000000004787
                - 0.00000000000035544)
                + 0.00000000102606)
                - 0.0000014665)
                + 0.0010827)
                - 0.3133)
                + 20.49
            )));
    }

    public static function XWN(value:Number):Number
    {
        return value > 2140 ? 100 :
            Math.round(Math.max(0, Math.min(100,
                value * (value * (value * (value *
                - 0.00000000001334
                + 0.00000005673)
                - 0.00007575)
                + 0.08392)
                - 9.362
            )));
    }

    /** Restrict XVM mod usage for banned users */
    public static function checkBanList():Void
    {
        /**
         * User IDs to ban.
         * Ban by nickname is unreliable due to nickname change WG service.
         */
        var banlist:Array = [
            234332 /** 26 apr 2013 - XD http://goo.gl/4Kamf */
        ]

        /** Define current user */
        var allies:Array = _root.leftPanel.m_list._dataProvider;
        var user:Number;
        for (var i in allies)
        {
            if (allies[i].himself == true)
            {
                user = allies[i].uid;
                break;
            }
        }

        /** Check if user is banned */
        var banned:Boolean = false;
        for (var i in banlist)
        {
            if (banlist[i] == user)
            {
                banned = true;
                break;
            }
        }

        /** Apply ban */
        if (banned)
        {
            Logger.add("## BANNED");
            _root._alpha = 0;
        }
    }
}
