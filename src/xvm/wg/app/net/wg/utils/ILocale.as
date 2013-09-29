package net.wg.utils 
{
    import net.wg.infrastructure.interfaces.*;
    
    public interface ILocale
    {
        function gold(arg1:Object):String;

        function integer(arg1:Object):String;

        function float(arg1:Object):String;

        function niceNumber(arg1:Object):String;

        function numberWithoutZeros(arg1:Object):String;

        function parseFormattedInteger(arg1:String):net.wg.infrastructure.interfaces.IFormattedInt;

        function shortTime(arg1:Object):String;

        function longTime(arg1:Object):String;

        function shortDate(arg1:Object):String;

        function longDate(arg1:Object):String;

        function htmlTextWithIcon(arg1:String, arg2:String):String;

        function makeString(arg1:String, arg2:Object=null):String;
    }
}
