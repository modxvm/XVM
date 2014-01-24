/**
 * XVM
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.infrastructure
{
    public interface IXvmMod
    {
        /**
         * Mod prefix for logging
         */
        function get logPrefix():String;

        /**
         * Mod views implementation configuration
         * key: view name
         * value: IXvmView class
         */
        function get views():Object;

        /**
         * Mod entry point. Calls after adding to the stage
         */
        function entryPoint():void;
    }
}
