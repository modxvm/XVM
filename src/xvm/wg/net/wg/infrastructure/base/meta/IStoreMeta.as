package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    import net.wg.data.VO.*;
    
    public interface IStoreMeta extends flash.events.IEventDispatcher
    {
        function requestTableDataS(arg1:Number, arg2:String, arg3:Array):void;

        function requestFilterDataS(arg1:String):void;

        function onCloseButtonClickS():void;

        function onShowInfoS(arg1:net.wg.data.VO.StoreTableData):void;

        function getNameS():String;

        function as_setNations(arg1:Array):void;

        function as_completeInit():void;

        function as_update():void;

        function as_setFilterType(arg1:Object):void;

        function as_setSubFilter(arg1:Object):void;

        function as_setFilterOptions(arg1:Array):void;
    }
}
