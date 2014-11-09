/**
 * ...
 * @author sirmax2
 */
class com.xvm.Strings
{
    public static function startsWith(substr:String, str:String):Boolean
    {
        return str.indexOf(substr, 0) == 0;
    }

    public static function endsWith(substr:String, str:String):Boolean
    {
        var i = str.lastIndexOf(substr);
        return i >= 0 && i == (str.length - substr.length);
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
    public static function substitute(str:String, args:Array):String
    {
        if (str == null)
            return '';

        var len = args.length;
        for (var i = 0; i < len; i++)
            str = str.split("{" + i + "}").join(args[i]);

        return str;
    }
}
