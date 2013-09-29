package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    import net.wg.data.VO.*;
    
    public interface IShopMeta extends flash.events.IEventDispatcher
    {
        function buyItemS(arg1:net.wg.data.VO.StoreTableData):void;
    }
}
