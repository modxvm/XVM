/**
 * ...
 * @author Maxim Schedriviy
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GraphicsUtil;
import wot.utils.Locale;
import wot.utils.StatFormat;
import wot.utils.VehicleInfo;
import wot.utils.Utils;

class wot.utils.TextCache
{
    private static var s_textCache = {};
    private static var s_widthTester: TextField;

    private static var data: Object;
    private static var state: String;
    private static var format: String;
    private static var width: Number;
    private static var tf: TextFormat;

    public static function Get(key: String): String
    {
        return s_textCache[key];
    }

    public static function FormatNoCache(key: String, data: Object, format: String, width: Number, tf: TextFormat, deadState: Number): String
    {
        TextCache.data = data;
        TextCache.state = state;
        TextCache.format = format;
        TextCache.width = width;
        TextCache.tf = tf;

        return FormatText(deadState == Defines.DEADSTATE_DEAD);
    }

    public static function Format(key: String, data: Object, format: String, width: Number, tf: TextFormat, deadState: Number): String
    {
        if (!s_textCache.hasOwnProperty(key))
            s_textCache[key] = FormatNoCache(key, data, format, width, tf, deadState);
        return s_textCache[key];
    }

    private static function FormatText(isDead: Boolean): String
    {
        var name = modXvmDevLabel(data.label + ((data.clanAbbrev == "") ? "" : "[" + data.clanAbbrev + "]"));

        var formatArr:Array;

        formatArr = format.split("{{vehicle}}");
        if (formatArr.length > 1)
            format = formatArr.join(VehicleInfo.mapVehicleName(data.icon, data.vehicle));
        formatArr = format.split("{{vtype}}");
        if (formatArr.length > 1)
            format = formatArr.join(VehicleInfo.GetVTypeValue(data.icon));
        formatArr = format.split("{{c:vtype}}");
        if (formatArr.length > 1)
            format = formatArr.join(GraphicsUtil.GetVTypeColorValue(data.icon));

        format = StatFormat.FormatText(data, format, isDead);

        // cut player name for field width
        if (format.indexOf("{{nick}}") > -1 || format.indexOf("{{name}}") > -1 || format.indexOf("{{clan}}") > -1)
        {
            var pname: String = Utils.GetPlayerName(name);
            var cname: String = Utils.GetClanNameWithBrackets(name);
            if (width >= 0 && tf)
            {
                if (s_widthTester == null)
                    createWidthTester();
                while (pname + cname != "")
                {
                    s_widthTester.htmlText = format
                        .split("{{nick}}").join(pname + cname)
                        .split("{{name}}").join(pname)
                        .split("{{clan}}").join(cname);
                    if (Math.round(s_widthTester.getLineMetrics(0).width) + 4 <= width) // 4 is a size of gutters
                    {
                        //Logger.add("width=" + width + " _width=" + s_widthTester._width + " lineWidth=" + Math.round(s_widthTester.getLineMetrics(0).width) + " " + str);
                        break;
                    }
                    if (cname != "")
                        cname = cname.substr(0, cname.length - 1);
                    else
                        pname = pname.substr(0, pname.length - 1);
                }
            }
            formatArr = format.split("{{nick}}");
            if (formatArr.length > 1)
                format = formatArr.join(pname + cname);
            formatArr = format.split("{{name}}");
            if (formatArr.length > 1)
                format = formatArr.join(pname);
            formatArr = format.split("{{clan}}");
            if (formatArr.length > 1)
                format = formatArr.join(cname);
        }

        return format;
    }

    private static function createWidthTester()
    {
        s_widthTester = _root.createTextField("widthTester", _root.getNextHighestDepth(), 0, 0, 268, 20);
        s_widthTester.autoSize = false;
        s_widthTester.html = true;
        s_widthTester.condenseWhite = true;
        s_widthTester._visible = false;
        s_widthTester.setNewTextFormat(tf);
    }
    
    public static function modXvmDevLabel(nick):String
    {
        var label = Utils.GetPlayerName(nick);
        switch (Config.s_game_region)
        {
            case "RU":
                if (label == "XlebniDizele4ku")
                    return "Хлебни Дизелёчку! (XVM)";
                if (label == "sirmax2" || label == "0x01")
                    return Locale.get("Sir Max") + " (XVM)";
                break;

            case "CT":
                if (label == "XlebniDizele4ku_RU")
                    return "Хлебни Дизелёчку! (XVM";
                if (label == "sirmax2_RU" || label == "0x01_RU")
                    return Locale.get("Sir Max") + " (XVM)";
                break;

            case "EU":
                if (label == "sirmax2" || label == "0x01")
                    return Locale.get("Sir Max") + " (XVM)";
                break;

            case "US":
                if (label == "sirmax" || label == "0x01")
                    return Locale.get("Sir Max") + " (XVM)";
                break;
        }

        return nick;
    }
}