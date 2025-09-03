/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw
{
    import com.xfw.*;

    public class Logger
    {
        private static var _counterPrefix:String = "X";
        private static var _counter:int = 0;
        private static var _isDebug:Boolean = false;

        public static function get counterPrefix():String
        {
            return _counterPrefix;
        }

        public static function setCounterPrefix(value:String):void
        {
            _counterPrefix = value;
        }

        public static function get isDebug():Boolean
        {
            return _isDebug;
        }

        public static function setIsDebug(value:Boolean):void
        {
            _isDebug = value;
        }

        public static function add(str:String):void
        {
            try
            {
                Xfw.cmd(XfwConst.XFW_COMMAND_LOG, "[" + counterPrefix + ":" + XfwUtils.leftPad(String(_counter++), 3, '0') + "] " + str);
            }
            catch (ex:Error)
            {
                // quiet
            }
        }

        public static function debug(str:String):void
        {
            if (isDebug)
            {
                add("[DEBUG] " + str);
            }
        }

        public static function addObject(obj:Object, depth:Number = 1, name:String = "obj"):void
        {
            if (!name)
                name = "obj";
            add(name + ": " + JSONx.stringifyDepth(obj, depth));
        }

        public static function err(error:Error):void
        {
            if(error == null){
                add("[ERROR] trying to log error which is null");
            }

            if(error.message){
                add("[ERROR]" + error.message);
            }

            var stackTrace:String = error.getStackTrace();
            if(stackTrace){
                add(stackTrace);
            }
        }
    }
}
