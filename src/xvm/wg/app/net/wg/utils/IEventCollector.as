package net.wg.utils
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import flash.display.DisplayObject;
   
   public interface IEventCollector extends IDisposable
   {
      
      function setEnabled(param1:Boolean) : void;
      
      function addEvent(param1:IEventDispatcher, param2:String, param3:Function, param4:Boolean = false, param5:int = 0, param6:Boolean = false) : void;
      
      function removeEvent(param1:Object, param2:String, param3:Function, param4:Boolean = false) : void;
      
      function removeAllEvents() : void;
      
      function removeModuleEvents(param1:IDAAPIModule) : void;
      
      function removeObjectEvents(param1:Object, param2:Boolean = true) : void;
      
      function enableDisposingForObj(param1:DisplayObject) : void;
      
      function disableDisposingForObj(param1:DisplayObject) : void;
      
      function hasRegisteredEvent(param1:Object, param2:String, param3:Function, param4:Boolean) : Boolean;
      
      function objectIsRegistered(param1:Object) : Boolean;
      
      function logState() : void;
   }
}
