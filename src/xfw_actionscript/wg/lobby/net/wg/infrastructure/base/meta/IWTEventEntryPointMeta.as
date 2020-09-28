package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IWTEventEntryPointMeta extends IEventDispatcher
    {

        function onEntryClickS() : void;

        function as_setAnimationEnabled(param1:Boolean) : void;

        function as_setEndDate(param1:String) : void;
    }
}
