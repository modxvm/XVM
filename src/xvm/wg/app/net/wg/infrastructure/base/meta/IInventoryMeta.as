package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    import net.wg.data.VO.*;
    
    public interface IInventoryMeta extends flash.events.IEventDispatcher
    {
        function sellItemS(arg1:net.wg.data.VO.StoreTableData):void;
    }
}
