package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IResearchViewMeta extends flash.events.IEventDispatcher
    {
        function request4UnlockS(arg1:Number, arg2:Number, arg3:Number, arg4:Number):void;

        function request4BuyS(arg1:Number):void;

        function request4SellS(arg1:Number):void;

        function requestVehicleInfoS(arg1:String):void;

        function showSystemMessageS(arg1:String, arg2:String):void;

        function as_setNodesStates(arg1:Number, arg2:Array):void;

        function as_setNext2Unlock(arg1:Array):void;

        function as_setVehicleTypeXP(arg1:Array):void;

        function as_setInventoryItems(arg1:Array):void;

        function as_useXMLDumping():void;
    }
}
