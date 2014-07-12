package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.base.meta.IEventLogManagerMeta;
   import net.wg.infrastructure.interfaces.entity.IIdentifiable;
   import flash.events.Event;
   
   public interface IEventLogManager extends IEventLogManagerMeta
   {
      
      function logSubSystem(param1:uint, param2:String, param3:uint, param4:uint) : void;
      
      function logUIElement(param1:IIdentifiable, param2:String, param3:uint) : void;
      
      function logUIEvent(param1:Event, param2:uint) : void;
   }
}
