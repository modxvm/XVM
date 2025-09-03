/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw.infrastructure
{
    public interface IXfwMod
    {
        /**
         * Mod prefix for logging
         */
        function get logPrefix():String;

        /**
         * Mod views implementation configuration
         * key: view name
         * value: IXfwView class
         */
        function get views():Object;

        /**
         * Mod entry point. Calls after adding to the stage
         */
        function entryPoint():void;
    }
}
