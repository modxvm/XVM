/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw
{
    import com.xfw.*;
    import flash.display.*;
    import flash.utils.*;
    import flash.text.*;
    import mx.utils.*;

    public class XfwUtils
    {
        public static function isPrimitiveType(value:*):Boolean
        {
            return value === null || value is int || value is Number || value is Boolean || value is uint || value is String;
        }

        public static function isPrimitiveTypeAndNotString(value:*):Boolean
        {
            return value === null || value is int || value is Number || value is Boolean || value is uint;
        }

        public static function toInt(value:*, defaultValue:int = 0):int
        {
            if (!value)
                return defaultValue;
            if (value is int || value is uint)
                return value;
            var n:Number = Number(value);
            return isNaN(n) ? defaultValue : int(n);
        }

        public static function toNumber(value:*, defaultValue:Number = 0):Number
        {
            if (!value)
                return defaultValue;
            var n:Number = Number(value);
            return isNaN(n) ? defaultValue : n;
        }

        public static function toBool(value:*, defaultValue:Boolean):Boolean
        {
            if (value is Boolean)
                return value;
            if (!value)
                return defaultValue;
            value = String(value).toLowerCase();
            return defaultValue ? value != "false" : value == "true";
        }

        public static function toHtmlColor(value:Number, prefix:String = '#'):String
        {
            return prefix + XfwUtils.leftPad(value.toString(16), 6, '0');
        }

        public static function leftPad(str:String, n:int, char:String):String
        {
            var r:Array = str.split("");
            var i:int = n - r.length;
            while (--i > -1)
            {
                r.unshift(char);
            }
            return r.join("");
        }

        // From org.idmedia.as3commons.util.StringUtils;

        public static function startsWith(str:String, substr:String) : Boolean
        {
            return testString(str, new RegExp("^" + substr, ""));
        }

        public static function endsWith(str:String, substr:String):Boolean
        {
            return testString(str, new RegExp(substr + "$", ""));
        }

        private static function testString(str:String, substr:RegExp) : Boolean
        {
            return str != null && substr.test(str);
        }

        /**
         * @param format http://php.net/date
         * https://code.google.com/p/as3-php-date/wiki/Documentation
         */
        public static function FormatDate(format:String, date:Date):String
        {
            return new PhpDate(date).format(format);
        }

        public static function fixPath(path:String):String
        {
            if (path == null)
                return null;
            path = path.replace(/\\/g, "/");
            if (!XfwUtils.endsWith(path, "/"))
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

        public static function getObjectValueByPath(obj:*, path:String):*
        {
            if (obj === undefined)
                return undefined;

            if (path == "." || !path.length)
                return obj;

            var p:Array = path.split("."); // "path.to.value"
            var o:* = obj;
            var p_len:int = p.length;
            for (var i:int = 0; i < p_len; ++i)
            {
                var opi:* = o[p[i]];
                if (opi === undefined)
                    return undefined;
                o = opi;
            }
            return o == null ? null : XfwUtils.jsonclone(o);
        }

		public static function getPrivateField(obj:*, field:String):*
		{
			var result:* = null;
			if (obj == null) {
				Logger.add("XfwUtils::getPrivateField -> input object is null");
                return result;
			}
            Logger.add("XfwUtils::getPrivateField -> " + flash.utils.getQualifiedClassName(obj) + ", " + field);

			result = obj[field];

			if (!result){
				Logger.add("    -- FAILED");
			}
			else{
				Logger.add("    -- OK");
			}
			return result;
		}

        /**
         * Deep copy
         */
        public static function jsonclone(obj:Object):Object
        {
            /*var temp:ByteArray = new ByteArray();
            temp.writeObject(obj);
            temp.position = 0;
            return temp.readObject();*/
            return JSONx.parse(JSONx.stringify(obj, "", true));
        }

        public static function GetPlayerName(fullplayername:String):String
        {
            if (fullplayername == null)
                return null;
            var pos:int = fullplayername.indexOf("[");
            return (pos < 0) ? fullplayername : StringUtil.trim(fullplayername.slice(0, pos));
        }

        public static function GetClanNameWithoutBrackets(fullplayername:String):String
        {
            if (fullplayername == null)
                return null;
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

        public static function cloneTextFormat(textFormat:TextFormat):TextFormat
        {
            return new TextFormat(textFormat.font, textFormat.size, textFormat.color, textFormat.bold,
                textFormat.italic, textFormat.underline, textFormat.url, textFormat.target, textFormat.align,
                textFormat.leftMargin, textFormat.rightMargin, textFormat.indent, textFormat.leading);
        }

        public static function createTextStyleSheet(name:String, textFormat:TextFormat):StyleSheet
        {
            return createStyleSheet(createCSS(name, textFormat.color as Number,
                textFormat.font, textFormat.size as Number, textFormat.align, textFormat.bold, textFormat.italic));
        }

        public static function addEventListeners(obj:Object, target:Object, handlers:Object):void
        {
            if (!obj || !target || !handlers)
                return;
            for (var name:* in handlers)
                obj.addEventListener(name, target, handlers[name]);
        }

        public static function createCSS(className:String, color:Number = NaN, fontName:String = null, fontSize:Number = NaN,
            align:String = null, bold:Boolean = false, italic:Boolean = false, underline:Boolean = false,
            display:String = null, leading:Number = NaN, marginLeft:Number = NaN, marginRight:Number = NaN):String
        {
                var css:Array = [
                    "font-weight:" + (bold ? "bold" : "normal") +
                    ";font-style:" + (italic ? "italic" : "normal") +
                    ";text-decoration:" + (underline ? "underline" : "none") ];
                if (!isNaN(color))
                    css.push(";color:" + XfwUtils.toHtmlColor(color));
                if (fontName)
                    css.push(";font-family:\"" + fontName + "\"");
                if (!isNaN(fontSize))
                    css.push(";font-size:" + fontSize);
                if (align)
                    css.push(";text-align:" + align);
                if (display)
                    css.push(";display:" + display);
                if (!isNaN(leading))
                    css.push(";leading:" + leading);
                if (!isNaN(marginLeft))
                    css.push(";margin-left:" + marginLeft);
                if (!isNaN(marginRight))
                    css.push(";margin-right:" + marginRight);
                return "." + className + " {" + css.join("") + "}";
        }

        public static function createStyleSheet(css:String):StyleSheet
        {
            var style:StyleSheet = new StyleSheet();
            style.parseCSS(css);
            return style;
        }

        public static function logChilds(o:DisplayObject):void
        {
            _logChilds(o, "");
        }

        private static function _logChilds(o:DisplayObject, indent:String):void
        {
            if (Logger.counterPrefix != "X")
            {
                Logger.add(indent + getQualifiedClassName(o) + " " + o.name);
            }
            else
            {
                DebugUtils.LOG_ERROR(indent + getQualifiedClassName(o) + " " + o.name);
            }
            var c:DisplayObjectContainer = o as DisplayObjectContainer;
            if (c != null)
            {
                for (var i:int = 0; i < c.numChildren; ++i)
                {
                    _logChilds(c.getChildAt(i), indent + "|   ");
                }
            }
        }

        private static const REMOVE_AT:RegExp = /^\s*at\s*/i;
        private static const MATCH_FILE:RegExp = /[(][)][\[][^:]*?:[0-9]+[\]]\s*$/i;
        private static const TRIM_FILE:RegExp = /[()\[\]\s]*/ig;
        private static const REMOVE_BRACKETS:RegExp = /\(\)\s*$/;

        public static function stack(...params):String
        {
            var e:Error = new Error();
            if (e == null)
            {
                return "WOT_1_9_0_STACK_BROKEN:" + params;
            }

            var s:String = e.getStackTrace();
            var func:String = "<unknown>";
            var file:String = null;
            var args:String = null;
            if (s)
            {
                func = s.split("\n")[2];
                func = func.replace(REMOVE_AT, "");
                var farr:Array  = func.match(MATCH_FILE);
                if (farr != null && farr.length > 0)
                    file = farr[0].replace(TRIM_FILE, "");
                func = func.replace(MATCH_FILE, "");
                func = func.replace(REMOVE_BRACKETS, "");
            }
            for each (var param:* in params)
            {
                args = (args == null ? "" : args.concat(","));
                if (param == undefined)
                    param = "<undefined>";
                else if (param == null)
                    param = "<null>";
                args = args.concat(param.toString());
            }
            return func + "(" + (args == null ? "": args) + ")" + (file == null ? "" : " at " + file);
        }
    }
}
