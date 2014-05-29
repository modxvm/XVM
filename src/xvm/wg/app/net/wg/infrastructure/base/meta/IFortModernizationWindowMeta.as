package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IFortModernizationWindowMeta extends IEventDispatcher
   {
          
      function applyActionS() : void;

      function as_setData(param1:Object) : void;

      function as_applyButtonLbl(param1:String) : void;

      function as_cancelButton(param1:String) : void;

      function as_windowTitle(param1:String) : void;
   }

}