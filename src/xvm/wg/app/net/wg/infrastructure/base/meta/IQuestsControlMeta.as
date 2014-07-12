package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IQuestsControlMeta extends IEventDispatcher
   {
      
      function showQuestsWindowS() : void;
      
      function as_highlightControl() : void;
      
      function as_resetControl() : void;
   }
}
