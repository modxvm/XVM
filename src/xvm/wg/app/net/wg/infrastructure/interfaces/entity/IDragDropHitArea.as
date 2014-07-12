package net.wg.infrastructure.interfaces.entity
{
   import flash.events.IEventDispatcher;
   import flash.display.InteractiveObject;
   
   public interface IDragDropHitArea extends IEventDispatcher
   {
      
      function getHitArea() : InteractiveObject;
   }
}
