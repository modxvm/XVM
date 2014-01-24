/**
 * XVM mod interface
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.infrastructure
{
    import net.wg.infrastructure.events.LifeCycleEvent;

    public interface IXvmView
    {
        function onBeforePopulate(e:LifeCycleEvent):void;
        function onAfterPopulate(e:LifeCycleEvent):void;
        function onBeforeDispose(e:LifeCycleEvent):void;
        function onAfterDispose(e:LifeCycleEvent):void;
    }
}
