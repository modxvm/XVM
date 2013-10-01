package xvm.hangar.components.Profile
{
    public final class ProfileUtils
    {
        public static function extractNumber(str:String):Number
        {
            if (!str)
                return NaN;

            str = str.replace(",", ".");

            // String.replace have problems with unicode.
            var res:String = "";
            for (var i:int = 0; i < str.length; ++i)
            {
                var c:String = str.charAt(i);
                if ((c >= "0" && c <= "9") || c == ".")
                    res += c;
            }
            return parseFloat(res);
        }
    }

}
