package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IVehicleCustomizationMeta extends IEventDispatcher
    {
        
        function dropCurrentItemInSectionS(param1:String, param2:Number) : void;
        
        function applyCustomizationS(param1:Array) : void;
        
        function setNewItemIdS(param1:String, param2:Number, param3:Number, param4:Number) : void;
        
        function getCurrentItemS(param1:String) : Object;
        
        function getItemCostS(param1:String, param2:Number, param3:Number) : Object;
        
        function closeWindowS() : void;
        
        function as_onServerResponsesReceived() : void;
        
        function as_onInit(param1:Array) : void;
        
        function as_setActionsLocked(param1:Boolean) : void;
        
        function as_onChangeSuccess() : void;
        
        function as_onCurrentChanged(param1:String) : void;
        
        function as_onDropSuccess() : void;
        
        function as_onResetNewItem() : void;
        
        function as_setCredits(param1:Number) : void;
        
        function as_setGold(param1:Number) : void;
        
        function as_refreshData() : void;
        
        function as_refreshItemsData() : void;
    }
}
