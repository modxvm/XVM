/**
 * ...
 * @author sirmax2
 */
package utils
{
	import mx.messaging.channels.StreamingAMFChannel;
	import flash.filters.*;
	import flash.geom.*;

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

    public static function GetPlayerName(fullplayername: String): String
    {
        var pos:Number = fullplayername.indexOf("[");
        return (pos < 0) ? fullplayername : fullplayername.slice(0, pos);
    }
    public static function GetClanName(fullplayername: String): String
    {
        var pos:Number = fullplayername.indexOf("[");
        if (pos < 0)
            return "";
        var n:String = fullplayername.slice(pos + 1);
        return n.slice(0, n.indexOf("]"));
    }

    public static function GetClanNameWithBrackets(fullplayername: String): String
    {
        var clan:String = GetClanName(fullplayername);
        return clan ? "[" + clan + "]" : "";
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

	public static function createShadowFilter(distance:Number, angle:Number, color:Number,
											  alpha:Number, size:Number, strength:Number):DropShadowFilter
	{
		if (!alpha || !strength || !size)
			return null;
		return new DropShadowFilter(distance, angle, color, alpha * 0.01, size, size, strength * 0.01, 3);
	}
	
	//method to set a specified movieClip(item:movidClip) to a specified color(col:hex value number)
	public static function setColor(item:Object, col:Number, ratio:Number = NaN):void
	{
		if (!isNaN(ratio))
		{
			var tr: ColorTransform = new ColorTransform();
			tr.color = Number(col);
			tr.redMultiplier = 1 - ratio;
			tr.greenMultiplier = 1 - ratio;
			tr.blueMultiplier = 1 - ratio;
			tr.redOffset *= ratio;
			tr.greenOffset *= ratio;
			tr.blueOffset *= ratio;
			item.transform.colorTransform = tr;
		}
	}
	
	public static function colorByRatio($value:Number, $start:Number, $end:Number):Number
	{
		var r: Number = $start >> 16;
		var g: Number = ($start >> 8) & 0xff;
		var b: Number = $start & 0xff;
		var r2: Number = ($end >> 16) - r;
		var g2: Number = (($end >> 8) & 0xff) - g;
		var b2: Number = ($end & 0xff) - b;
		return ((r + ($value * r2)) << 16 | (g + ($value * g2)) << 8 | (b + ($value * b2)));
	}
	
	// require 2-colored black and white source image (mask).
	public static function colorize(item:Object, col:Number, multiplicator:Number = 1):void
	{
		var tr:flash.geom.ColorTransform = new flash.geom.ColorTransform();
		tr.redMultiplier = ((col >> 16) & 0xFF) / 255 * multiplicator;
		tr.greenMultiplier = ((col >> 8) & 0xFF) / 255 * multiplicator;
		tr.blueMultiplier = (col & 0xFF) / 255 * multiplicator;
		tr.redOffset = 0;
		tr.greenOffset = 0;
		tr.blueOffset = 0;
		item.transform.colorTransform = tr;
	}
	
	public static function brightenColor(hexColor: Number, percent: Number): Number
	{
		if (isNaN(percent))
			percent = 0;
		if (percent > 100)
			percent = 100;
		if (percent < 0)
			percent = 0;
		
		var factor: Number = percent / 100;
		var rgb: Object = hexToRgb(hexColor);
		
		rgb.r += (255 - rgb.r) * factor;
		rgb.b += (255 - rgb.b) * factor;
		rgb.g += (255 - rgb.g) * factor;
		
		return rgbToHex(Math.round(rgb.r), Math.round(rgb.g), Math.round(rgb.b));
	}
	
	public static function darkenColor(hexColor:Number, percent:Number): Number
	{
		if (isNaN(percent))
			percent = 0;
		if (percent > 100)
			percent = 100;
		if (percent < 0)
			percent = 0;
		
		var factor: Number = 1 - (percent/100);
		var rgb: Object = hexToRgb(hexColor);
		
		rgb.r *= factor;
		rgb.b *= factor;
		rgb.g *= factor;
		
		return rgbToHex(Math.round(rgb.r), Math.round(rgb.g), Math.round(rgb.b));
	}
	
	public static function rgbToHex(r:Number, g:Number, b:Number): Number
	{
		return (r << 16 | g << 8 | b);
	}
	
	public static function hexToRgb(hex:Number): Object
	{
		return { r: (hex & 0xff0000) >> 16, g: (hex & 0x00ff00) >> 8, b: hex & 0x0000ff };
	}
	
	public static function brightness(hex:Number): Number
	{
		var max: Number = 0;
		var rgb: Object = hexToRgb(hex);
		if(rgb.r > max)
			max = rgb.r;
		if(rgb.g > max)
			max = rgb.g;
		if(rgb.b > max)
			max = rgb.b;
		max /= 255;
		return max;
	}
	
	public static function GetVTypeColorValue(vtype:String,
											  prefix: String = "#", darker: Boolean = false): String
	{
		try
		{
			return prefix + Utils.toInt(Config.s_config.colors.vtype[vtype], 0xFFFFFE).toString(16);
		}
		catch (ex:Error)
		{
			return prefix + "FFFEFE";
		}
		return prefix + "FFFEFE";
	}
	
	public static function GetDynamicColorValueInt(type: Number, value: Number, darker: Boolean): Number
	{
		return Number(GetDynamicColorValue(type, value, "0x", darker));
	}
	
	public static function GetDynamicColorValue(type: Number, value: Number, prefix: String = "#", darker: Boolean = false): String
	{
		if (isNaN(value))
			return prefix + "FFFBFB";
		
		var cfg_root: Object = Config.s_config.colors;
		var cfg: Array;
		switch (type)
		{
			case Defines.DYNAMIC_COLOR_HP:              cfg = cfg_root.hp; break;
			case Defines.DYNAMIC_COLOR_HP_RATIO:        cfg = cfg_root.hp_ratio; break;
			case Defines.DYNAMIC_COLOR_EFF:             cfg = cfg_root.eff; break;
			case Defines.DYNAMIC_COLOR_E:               cfg = cfg_root.e; break;
			case Defines.DYNAMIC_COLOR_WN:              cfg = cfg_root.wn; break;
			case Defines.DYNAMIC_COLOR_X:               cfg = cfg_root.x; break;
			//case Defines.DYNAMIC_COLOR_TWR:             cfg = cfg_root.twr; break;
			case Defines.DYNAMIC_COLOR_RATING:          cfg = cfg_root.rating; break;
			case Defines.DYNAMIC_COLOR_KB:              cfg = cfg_root.kb; break;
			case Defines.DYNAMIC_COLOR_TBATTLES:        cfg = cfg_root.t_battles; break;
			case Defines.DYNAMIC_COLOR_TDB:             cfg = cfg_root.tdb; break;
			case Defines.DYNAMIC_COLOR_TDV:             cfg = cfg_root.tdv; break;
			case Defines.DYNAMIC_COLOR_TFB:             cfg = cfg_root.tfb; break;
			case Defines.DYNAMIC_COLOR_TSB:             cfg = cfg_root.tsb; break;
			default: return prefix + "FFFEFE";
		}
		
		var cfg_len:Number = cfg.length;
		if (value == 0 && (type == Defines.DYNAMIC_COLOR_EFF || type == Defines.DYNAMIC_COLOR_RATING))
		{
			if (cfg_len == 0)
				return "";
			var cvalue: Number = cfg[0].value;
			if (cvalue != 0)
				return "";
			var color: Number = Utils.toInt(cfg[0].color, 0xFFFFFF);
			if (darker)
				color = Utils.darkenColor(color, 50);
			return prefix + color.toString(16);
		}
		
		for (var i:Number = 0; i < cfg_len; ++i)
		{
			var cvalue2: Number = cfg[i].value;
			var color2: Number = Utils.toInt(cfg[i].color, 0xFFFFFF);
			if (value < cvalue2)
			{
				if (darker)
					color2 = Utils.darkenColor(color2, 50);
				return prefix + color2.toString(16);
			}
		}
		
		return prefix + "FFFFFF";
	}
	
	public static function GetDynamicAlphaValue(type: Number, value: Number): Number
	{
		if (!value)
			return 0;
		
		var cfg_root:Object = Config.s_config.alpha;
		var cfg: Array;
		switch (type)
		{
			case Defines.DYNAMIC_ALPHA_HP:              cfg = cfg_root.hp; break;
			case Defines.DYNAMIC_ALPHA_HP_RATIO:        cfg = cfg_root.hp_ratio; break;
			case Defines.DYNAMIC_ALPHA_EFF:             cfg = cfg_root.eff; break;
			case Defines.DYNAMIC_ALPHA_E:               cfg = cfg_root.e; break;
			case Defines.DYNAMIC_ALPHA_WN:              cfg = cfg_root.wn; break;
			case Defines.DYNAMIC_ALPHA_X:               cfg = cfg_root.x; break;
			//case Defines.DYNAMIC_ALPHA_TWR:             cfg = cfg_root.twr; break;
			case Defines.DYNAMIC_ALPHA_RATING:          cfg = cfg_root.rating; break;
			case Defines.DYNAMIC_ALPHA_KB:              cfg = cfg_root.kb; break;
			case Defines.DYNAMIC_ALPHA_TBATTLES:        cfg = cfg_root.t_battles; break;
			case Defines.DYNAMIC_ALPHA_TDB:             cfg = cfg_root.tdb; break;
			case Defines.DYNAMIC_ALPHA_TDV:             cfg = cfg_root.tdv; break;
			case Defines.DYNAMIC_ALPHA_TFB:             cfg = cfg_root.tfb; break;
			case Defines.DYNAMIC_ALPHA_TSB:             cfg = cfg_root.tsb; break;
			default: return 100;
		}
		
		var cfg_len:Number = cfg.length;
		for (var i:Number = 0; i < cfg_len; ++i)
		{
			var avalue: Number = cfg[i].value;
			var alpha: Number = cfg[i].alpha;
			if (value < avalue)
				return alpha;
		}
		
		return 100;
	}
	
	public static function GetDmgKindValue(dmg_kind: String, prefix: String = '#'): String
	{
		try
		{
			if (!dmg_kind || !Config.s_config.colors.dmg_kind[dmg_kind])
				return "";
			return prefix + Utils.toInt(Config.s_config.colors.dmg_kind[dmg_kind], 0xFFFFFE).toString(16);
		}
		catch (ex:Error)
		{
			return prefix + "FFFEFE";
		}
		return prefix + "FFFEFE";
	}
}

}
