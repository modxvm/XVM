/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw.infrastructure
{
    import net.wg.infrastructure.events.*;

    public interface IXfwView
    {
        /**
         * Mod populated and not disposed
         */
        function get isActive():Boolean;

        /**
         * Mod populated
         */
        function get isPopulated():Boolean;

        /**
         * Mod disposed
         */
        function get isDisposed():Boolean;

        /**
         * Called before populate view
         */
        function onBeforePopulate(e:LifeCycleEvent):void;

        /**
         * Called after populate view
         */
        function onAfterPopulate(e:LifeCycleEvent):void;

        /**
         * Called before dispose view
         */
        function onBeforeDispose(e:LifeCycleEvent):void;

        /**
         * Called after dispose view
         */
        function onAfterDispose(e:LifeCycleEvent):void;
    }
}
