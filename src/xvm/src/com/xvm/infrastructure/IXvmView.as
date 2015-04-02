/**
 * XVM mod interface
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.infrastructure
{
    import flash.events.Event;
    import net.wg.infrastructure.events.LifeCycleEvent;

    public interface IXvmView
    {
        function onBeforePopulate(e:LifeCycleEvent):void;
        function onAfterPopulate(e:LifeCycleEvent):void;
        function onBeforeDispose(e:LifeCycleEvent):void;
        function onAfterDispose(e:LifeCycleEvent):void;
        function onConfigLoaded(e:Event):void;
    }
}
