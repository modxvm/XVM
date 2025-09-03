/**
 * XFW Shared Library
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw
{
    import com.xfw.*;
    import com.xfw.events.*;
    import flash.utils.*;

    /**
     *  Link additional classes into xfw_shared.swc
     */
    GraphicsUtil;
    ICloneable;
    JSONx;
    JSONxError;
    Logger;
    ObjectConverter;
    PhpDate;
    Sprintf;
    XfwConst;
    XfwUtils;
    // events
    BooleanEvent;
    IntEvent;
    ObjectEvent;
    StringEvent;

    public class Xfw
    {
        // static methods for Python-Flash communication

        public static function cmd(command:String, ...rest):*
        {
            if (commandProvider != null)
            {
                rest.unshift(command);
                return commandProvider.apply(null, rest);
            }
            return null;
        }

        public static function addCommandListener(command:String, listener:Function):void
        {
            if (!(command in commandListeners))
                commandListeners[command] = new Vector.<Function>();
            var listeners:Vector.<Function> = commandListeners[command];
            if (listeners.indexOf(listener) < 0)
                listeners.push(listener);
        }

        public static function removeCommandListener(command:String, listener:Function):void
        {
            if (!(command in commandListeners))
                return;
            var listeners:Vector.<Function> = commandListeners[command];
            var idx:int = listeners.indexOf(listener);
            if (idx >= 0)
                listeners.splice(idx, 1);
        }

        public static function registerCommandProvider(outFunc:Function):void
        {
            commandProvider = outFunc;
        }

        public static function unregisterCommandProvider():void
        {
            commandProvider = null;
        }

        // PRIVATE

        private static var commandProvider:Function = null;
        private static var commandListeners:Dictionary = new Dictionary();

        // Handle XFW command (must be public to be accessible from Python)
        public static function as_xfw_cmd(command:String, ...rest):*
        {
            //Logger.add("as_xfw_cmd: " + command + " " + rest.join(", "));
            var res:* = null;
            try
            {
                if (!(command in commandListeners))
                    commandListeners[command] = new Vector.<Function>();
                var listeners:Vector.<Function> = commandListeners[command];
                for each (var listener:Function in listeners)
                {
                    var resp:* = listener.apply(null, rest);
                    if (resp != null)
                    {
                        if (res == null)
                            res = new Vector.<*>();
                        res.push(resp);
                    }
                }
                if (res != null)
                {
                    if (res.length > 1)
                        Logger.add("WARNING: multiple results for command '" + command + "'. Only first result was returned.");
                    res = res[0];
                }
            }
            catch (ex:Error)
            {
                Logger.add("as_xfw_cmd: " + command + " " + rest.join(", ") + "\n" + ex.getStackTrace());
                res = null;
            }
            return res;
        }
    }
}
