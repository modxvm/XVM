package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IGFTutorialViewMeta extends IEventDispatcher
    {

        function as_createHintAreaInComponent(param1:String, param2:String, param3:int, param4:int, param5:int, param6:int) : void;

        function as_removeHintArea(param1:String) : void;
    }
}
