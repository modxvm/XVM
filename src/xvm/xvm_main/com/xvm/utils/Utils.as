/**
 * XVM Utils
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.utils
{
    import com.xfw.*;
    import com.xvm.types.cfg.*;
    import flash.filters.*;
    //import com.xvm.io.*;
    //import flash.utils.*;
    //import org.idmedia.as3commons.util.*;

    public class Utils
    {
        /**
         * Create DropShadowFilter from config section
         */
        public static function createShadowFilterFromConfig(cfg:CShadow):DropShadowFilter
        {
            // NOTE: quality arg is not working with Scaleform 4.2 AS3
            return cfg.enabled == false ? null : new DropShadowFilter(
                cfg.distance, // distance
                cfg.angle, // angle
                parseInt(cfg.color, 16),
                cfg.alpha / 100.0,
                cfg.blur,
                cfg.blur,
                cfg.strength);
        }

        /*
        public static function toInt(value:Object, defaultValue:int = 0):int
        {
            if (!value)
                return defaultValue;
            var n:Number = parseInt(String(value));
            return isNaN(n) ? defaultValue : int(n);
        }

        public static function forceInt(value:String):int
        {
            if (value == null)
                return 0;
            // HINT: string.replace(/[^0-9]/g, '') is broken, use the crutch
            var s:String = "";
            var len:int = value.length;
            for (var i:Number = 0; i < len; ++i)
            {
                var c:String = value.charAt(i);
                if (c >= '0' && c <= '9')
                    s += c;
            }
            return s == "" ? 0 : parseInt(s);
        }

        public static function toFloat(value:Object, defaultValue:Number = 0):Number
        {
            if (!value)
                return defaultValue;
            var n:Number = parseFloat(String(value));
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

        public static function toHtmlColor(value:Number):String
        {
            return "#" + StringUtils.leftPad(value.toString(16), 6, '0');
        }

        /**
         * @param format http://php.net/date
         * https://code.google.com/p/as3-php-date/wiki/Documentation
         */
        /*public static function FormatDate(format:String, date:Date):String
        {
            return new PhpDate(date).format(format);
        }

        /*public static function elapsedMSec(start:Date, end:Date):Number
        {
            return end.getTime() - start.getTime();
        }*/

        /*public static function fixPath(path:String):String
        {
            if (path == null)
                return null;
            path = path.replace(/\\/g, "/");
            if (!StringUtils.endsWith(path, "/"))
                path += "/";
            return path;
        }

        // Strip path and file extendion from icon
        public static function clearIcon(icon:String):String
        {
            if (!icon)
                return null;
            icon = icon.slice(icon.lastIndexOf("/") + 1);
            icon = icon.slice(0, icon.lastIndexOf("."));
            return icon;
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

                for (var i:int = 0; i < 4; ++i)
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
            }
            catch (e:Object)
            {
                return -2;
            }
            return 0;
        }

        /**
         *  from  mx.utils.StringUtil;
         *
         *  Substitutes "{n}" tokens within the specified string
         *  with the respective arguments passed in.
         *
         *  @example
         *
         *  var str:String = "here is some info '{0}' and {1}";
         *  trace(StringUtil.substitute(str, 15.4, true));
         */
        /*public static function substitute(str:String, ... rest):String
        {
            if (str == null)
                return '';

            // Replace all of the parameters in the msg string.
            var len:uint = rest.length;
            var args:Array;
            if (len == 1 && rest[0] is Array)
            {
                args = rest[0] as Array;
                len = args.length;
            }
            else
            {
                args = rest;
            }

            for (var i:int = 0; i < len; i++)
                str = str.split("{" + i + "}").join(args[i]);

            return str;
        }

        public static function encodeHtmlEntities(str:String):String
        {
            var xml:XML = <a/>;
            xml.setChildren(str);
            return xml.toXMLString();
        }

        public static function safeCall(target:Object, func:Function, args:Array):*
        {
            try
            {
                return func.apply(target, args);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // Fix <img src='xvm://...'> to <img src='img://XVM_IMG_RES_ROOT/...'> (res_mods/mods/shared_resources/xvm/res)
        // Fix <img src='cfg://...'> to <img src='img://XVM_IMG_CFG_ROOT/...'> (res_mods/configs/xvm)
        public static function fixImgTag(str:String):String
        {
            str = str.split("xvm://").join("img://" + Defines.XVM_IMG_RES_ROOT);
            str = str.split("cfg://").join("img://" + Defines.XVM_IMG_CFG_ROOT);
            return str;
        }

        public static function getObjectValueByPath(obj:*, path:String):*
        {
            if (obj === undefined)
                return undefined;

            if (path == "." || path == "")
                return obj;

            var p:Array = path.split("."); // "path.to.value"
            var o:* = obj;
            var p_len:Number = p.length;
            for (var i:Number = 0; i < p_len; ++i)
            {
                var opi:* = o[p[i]];
                if (opi === undefined)
                    return undefined;
                o = opi;
            }
            return o == null ? null : Utils.clone(o);
        }

        /**
         * Deep copy
         */
        /*public static function clone(obj:Object):Object
        {
            /*var temp:ByteArray = new ByteArray();
            temp.writeObject(obj);
            temp.position = 0;
            return temp.readObject();*/
          /*  return JSONx.parse(JSONx.stringify(obj, "", true));
        }

        /**
         * Shallow copy
         */
        /*public static function shallowCopy(sourceObj:Object):Object
        {
            var copyObj:Object = new Object();
            for (var i:* in sourceObj)
                copyObj[i] = sourceObj[i];
            return copyObj;
        }

        /**
         * Shallow copy
         */
        /*public static function shallowCopyClass(obj:Object, clazz:Class):*
        {
            var clone:* = new clazz();
            var description:XML = describeType(obj);
            for each (var item:XML in description.accessor) {
                if (item.@access != 'readonly') {
                    try {
                        clone[item.@name] = obj[item.@name];
                    } catch(error:Error) {
                        // N/A yet.
                    }
                }
            }
            return clone;
        }*/
    }
}
