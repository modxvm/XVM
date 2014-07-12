package net.wg.infrastructure.interfaces
{
    import flash.events.IEventDispatcher;
    import net.wg.data.VO.ShopSubFilterData;
    
    public interface IStoreMenuView extends IViewStackContent, IEventDispatcher
    {
        
        function setViewData(param1:Array) : void;
        
        function setSubFilterData(param1:int, param2:ShopSubFilterData) : void;
        
        function updateSubFilter(param1:int) : void;
        
        function getFilter() : Array;
        
        function resetTemporaryHandlers() : void;
        
        function setUIName(param1:String, param2:Function) : void;
        
        function get fittingType() : String;
    }
}
