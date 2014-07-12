package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleSellDialogMeta extends IEventDispatcher
   {
      
      function getDialogSettingsS() : Object;
      
      function setDialogSettingsS(param1:Boolean) : void;
      
      function sellS(param1:Object, param2:Array, param3:Array, param4:Array, param5:Array, param6:Boolean) : void;
      
      function setUserInputS(param1:String) : void;
      
      function setResultCreditS(param1:Boolean, param2:int) : void;
      
      function checkControlQuestionS(param1:Boolean) : void;
      
      function as_setData(param1:Object, param2:Object, param3:Object, param4:Object, param5:Number) : void;
      
      function as_checkGold(param1:Number) : void;
      
      function as_visibleControlBlock(param1:Boolean) : void;
      
      function as_enableButton(param1:Boolean) : void;
      
      function as_setCtrlQuestion(param1:String) : void;
      
      function as_setControlNumber(param1:Boolean, param2:String) : void;
   }
}
