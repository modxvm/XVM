package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IVehicleSellDialogMeta extends flash.events.IEventDispatcher
    {
        function getDialogSettingsS():Object;

        function setDialogSettingsS(arg1:Boolean):void;

        function sellS(arg1:Object, arg2:Array, arg3:Array, arg4:Array, arg5:Array, arg6:Boolean):void;

        function setUserInputS(arg1:String):void;

        function setResultCreditS(arg1:int):void;

        function as_setData(arg1:Object, arg2:Object, arg3:Object, arg4:Number, arg5:Number):void;

        function as_checkGold(arg1:Number):void;

        function as_visibleControlBlock(arg1:Boolean):void;

        function as_enableButton(arg1:Boolean):void;

        function as_setCtrlQuestion(arg1:String):void;

        function as_setControlNumber(arg1:String):void;
    }
}
