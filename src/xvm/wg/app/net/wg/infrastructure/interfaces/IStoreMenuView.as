package net.wg.infrastructure.interfaces 
{
    import flash.events.*;
    import net.wg.data.VO.*;
    
    public interface IStoreMenuView extends net.wg.infrastructure.interfaces.IViewStackContent, flash.events.IEventDispatcher
    {
        function setViewData(arg1:Array):void;

        function setSubFilterData(arg1:int, arg2:net.wg.data.VO.ShopSubFilterData):void;

        function updateSubFilter(arg1:int):void;

        function getFilter():Array;

        function resetTemporaryHandlers():void;

        function setUIName(arg1:String, arg2:Function):void;

        function get fittingType():String;
    }
}
