package net.wg.infrastructure.interfaces.pool
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.IEventDispatcher;

    public interface IPool extends IDisposable, IEventDispatcher
    {

        function getItem() : IPoolItem;

        function releaseItem(param1:IPoolItem) : void;
    }
}
