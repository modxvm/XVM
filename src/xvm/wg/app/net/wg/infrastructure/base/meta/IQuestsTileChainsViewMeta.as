package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IQuestsTileChainsViewMeta extends IEventDispatcher
    {
        
        function getTileDataS(param1:int, param2:String, param3:Boolean) : void;
        
        function getChainProgressS() : void;
        
        function getTaskDetailsS(param1:Number) : void;
        
        function selectTaskS(param1:Number) : void;
        
        function refuseTaskS(param1:Number) : void;
        
        function gotoBackS() : void;
        
        function showAwardVehicleInfoS(param1:Number) : void;
        
        function showAwardVehicleInHangarS(param1:Number) : void;
        
        function as_setHeaderData(param1:Object) : void;
        
        function as_updateTileData(param1:Object) : void;
        
        function as_updateChainProgress(param1:Object) : void;
        
        function as_updateTaskDetails(param1:Object) : void;
        
        function as_setSelectedTask(param1:Number) : void;
    }
}
