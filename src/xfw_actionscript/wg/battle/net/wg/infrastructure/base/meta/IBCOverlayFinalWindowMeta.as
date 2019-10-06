package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IBCOverlayFinalWindowMeta extends IEventDispatcher
    {

        function animFinishS() : void;

        function as_msgTypeHandler(param1:Number, param2:String) : void;
    }
}
