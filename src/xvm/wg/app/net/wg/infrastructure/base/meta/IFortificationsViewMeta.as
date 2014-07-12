package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IFortificationsViewMeta extends IEventDispatcher
   {
      
      function onFortCreateClickS() : void;
      
      function onDirectionCreateClickS() : void;
      
      function onEscapePressS() : void;
      
      function as_loadView(param1:String, param2:String) : void;
      
      function as_setCommonData(param1:Object) : void;
   }
}
