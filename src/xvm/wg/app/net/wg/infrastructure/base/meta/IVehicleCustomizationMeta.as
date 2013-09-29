package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IVehicleCustomizationMeta extends flash.events.IEventDispatcher
    {
        function dropCurrentItemInSectionS(arg1:String, arg2:Number):void;

        function applyCustomizationS(arg1:Array):void;

        function setNewItemIdS(arg1:String, arg2:Number, arg3:Number, arg4:Number):void;

        function getCurrentItemS(arg1:String):Object;

        function getItemCostS(arg1:String, arg2:Number, arg3:Number):Object;

        function closeWindowS():void;

        function as_onServerResponsesReceived():void;

        function as_onInit(arg1:Array):void;

        function as_setActionsLocked(arg1:Boolean):void;

        function as_onChangeSuccess():void;

        function as_onCurrentChanged(arg1:String):void;

        function as_onDropSuccess():void;

        function as_onResetNewItem():void;

        function as_setCredits(arg1:Number):void;

        function as_setGold(arg1:Number):void;
    }
}
