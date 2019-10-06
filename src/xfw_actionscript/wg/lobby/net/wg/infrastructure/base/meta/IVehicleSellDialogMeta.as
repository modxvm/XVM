package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IVehicleSellDialogMeta extends IEventDispatcher
    {

        function setDialogSettingsS(param1:Boolean) : void;

        function sellS(param1:Object, param2:Array, param3:Array, param4:Array, param5:Array, param6:Array, param7:Boolean) : void;

        function setUserInputS(param1:String) : void;

        function setResultCreditS(param1:Boolean, param2:int) : void;

        function checkControlQuestionS(param1:Boolean) : void;

        function onChangeConfigurationS(param1:Array) : void;

        function as_setData(param1:Object) : void;

        function as_checkGold(param1:Number) : void;

        function as_visibleControlBlock(param1:Boolean) : void;

        function as_enableButton(param1:Boolean) : void;

        function as_setControlQuestionData(param1:Boolean, param2:String, param3:String) : void;
    }
}
