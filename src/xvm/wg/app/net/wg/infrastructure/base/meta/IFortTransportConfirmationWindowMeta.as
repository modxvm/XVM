package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IFortTransportConfirmationWindowMeta extends IEventDispatcher
   {
      
      function onCancelS() : void;
      
      function onTransportingS(param1:Number) : void;
      
      function onTransportingLimitS() : void;
      
      function as_setMaxTransportingSize(param1:String) : void;
      
      function as_setFooterText(param1:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_enableForFirstTransporting(param1:Boolean) : void;
   }
}
