package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface ICAPTCHAMeta extends IEventDispatcher
   {
          
      function submitS(param1:String) : void;

      function reloadS() : void;

      function as_setImage(param1:String, param2:Number, param3:Number) : void;

      function as_setErrorMessage(param1:String) : void;
   }

}