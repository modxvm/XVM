package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IIconPriceDialogMeta extends IEventDispatcher
   {
          
      function as_setMessagePrice(param1:Number, param2:Number, param3:String, param4:Number) : void;

      function as_setPriceLabel(param1:String) : void;

      function as_setOperationAllowed(param1:Boolean) : void;
   }

}