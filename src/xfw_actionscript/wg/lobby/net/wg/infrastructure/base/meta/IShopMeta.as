package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IShopMeta extends IEventDispatcher
    {

        function buyItemS(param1:String, param2:Boolean) : void;
    }
}
