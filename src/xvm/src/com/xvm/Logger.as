/**
 * XVM Logger
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm
{
    import com.xvm.io.*;
    import com.xvm.utils.Sandbox;
    import org.idmedia.as3commons.util.StringUtils;

    public class Logger
    {
        private static var counter:int = 0;

        public static function add(str:String):void
        {
            try
            {
                Cmd.log("[" + Sandbox.GetCurrentSandboxPrefix() + ":" + StringUtils.leftPad(String(counter++), 3, '0') + "] " + str);
            }
            catch(e:Error)
            {
                // quiet
            }
        }

        public static function addObject(obj:Object, depth:Number = 1, name:String = "obj"):void
        {
            if (name == "")
                name = "obj";
            add(name + ": " + JSONx.stringifyDepth(obj, depth));
        }

        public static function err(error:Error):void
        {
            add(error.getStackTrace());
        }
    }
}
