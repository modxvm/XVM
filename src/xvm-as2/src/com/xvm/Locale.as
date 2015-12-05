/**
 * XVM Localization module
 * @author Maxim Schedriviy <max(at)modxvm.com>
 * @author Mikhail Paulyshka <mixail(at)modxvm.com>
 * @author Pavel Máca
 */
import com.xvm.*;

class com.xvm.Locale
{
    private static var MACRO_PREFIX:String = "l10n";
    private static var s_lang:Object = null;

    public static function setupLanguage(lang_data:Object):Void
    {
        s_lang = lang_data.locale;
        if (s_lang == null)
            Logger.add("Locale: \"locale\" section is not found in the file");
    }

    public static function get(format:String):String
    {
        //Logger.add("Locale[get]: string: " + format + " | string: " + s_lang[format]);

        if (!s_lang)
        {
            Logger.add("[ERROR] locale data is not loaded");
            return null;
        }

        if (s_lang[format] != null)
            format = s_lang[format];

        if (format == null)
            return null;

        // each item in array begin with macro
        var formatParts:Array = format.split("{{" + MACRO_PREFIX + ":");

        // begin part until first macro start
        var res:String = String(formatParts.shift());
        var len:Number = formatParts.length;
        for (var i:Number = 0; i < len; ++i)
        {
            // "macro}} rest of text"
            var part:String = formatParts[i];

            // find macro end & make sure it contains at least 1 symbol
            var macroEnd:Number = part.indexOf("}}", 1);
            if (macroEnd == -1) {
                // no end chars => write everythink back
                res += "{{" + MACRO_PREFIX + ":" + part;
                continue;
            }

            var macro:String = part.slice(0, macroEnd);
            //var stringParts:Array = macro.split(":");
            //macro = stringParts[0];
            //stringParts.shift();
            macro = Locale.get(macro);
            //if (stringParts.length > 0)
            //    macro = XfwUtils.substitute(macro, stringParts);
            res += macro;

            // write rest of text after macro, without }}
            res += part.slice(macroEnd + 2, part.length);
        }

        return res;
    }
}
