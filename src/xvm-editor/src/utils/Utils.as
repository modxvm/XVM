/**
 * ...
 * @author sirmax2
 */
package utils
{

public class Utils
{
    public static function startsWith(substr: String, str: String): Boolean
    {
        return str.indexOf(substr, 0) == 0;
    }

    public static function endsWith(substr: String, str: String): Boolean
    {
        return str.lastIndexOf(substr) == (str.length - substr.length);
    }

    public static function trim(str:String):String
    {
        return str ? str.replace(/^\s+|\s+$/gs, '') : "";
    }

    public static function toInt(value: Object, defaultValue: Number): Number
    {
        if (!defaultValue)
            defaultValue = 0;
        if (!value)
            return defaultValue;
        var n: Number = parseInt(value.toString());
        return isNaN(n) ? defaultValue : n;
    }

    public static function toFloat(value: Object, defaultValue: Number): Number
    {
        if (!defaultValue)
            defaultValue = 0;
        if (!value)
            return defaultValue;
        var n: Number = parseFloat(value.toString());
        return isNaN(n) ? defaultValue : n;
    }

    public static function toBool(value: Object, defaultValue: Boolean): Boolean
    {
        if ((typeof value) == "boolean")
            return Boolean(value);
        if (!value)
            return defaultValue;
        value = String(value).toLowerCase();
        return defaultValue ? value != "false" : value == "true";
    }

    public static function toString(value: Object, defaultValue: String): String
    {
        return value ? String(value) : defaultValue;
    }

    public static function elapsedMSec(start:Date, end:Date): Number
    {
        var d1:Number = start.hours * 3600000 + start.minutes * 60000 + start.seconds * 1000 + start.milliseconds;
        var d2:Number = end.hours * 3600000 + end.minutes * 60000 + end.seconds * 1000 + end.milliseconds;
        return d2 - d1;
    }

    public static function fixPath(path: String): String
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

    public static function padLeft(str: String, len: Number, char: String):String
    {
        if (!str)
            str = "";
        if (!char)
            char = ' ';
        while (str.length < len)
            str = char + str;
        return str;
    }

    ///////////////////////

    public static function sortXMLByAttribute($xml:XML, $attribute:String,
        $options:Object = null, $copy:Boolean = false):XML
    {
        //store in array to sort on
        var xmlArray:Array = new Array();
        var item:XML;
        for each (item in $xml.children())
        {
            var object:Object = {
                data: item,
                order: item.attribute($attribute)
            };
            xmlArray.push(object);
        }

        //sort using the power of Array.sortOn()
        xmlArray.sortOn('order',$options);

        //create a new XMLList with sorted XML
        var sortedXmlList:XMLList = new XMLList();
        var xmlObject:Object;
        for each (xmlObject in xmlArray)
        {
            sortedXmlList += xmlObject.data;
        }

        if ($copy)
        {
            //don't modify original
            return $xml.copy().setChildren(sortedXmlList);
        }
        else
        {
            //original modified
            return $xml.setChildren(sortedXmlList);
        }
    }
}

}
