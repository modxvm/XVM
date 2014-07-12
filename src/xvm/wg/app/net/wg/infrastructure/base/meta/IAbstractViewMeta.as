package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   
   public interface IAbstractViewMeta extends IEventDispatcher
   {
      
      function registerFlashComponentS(param1:IDAAPIModule, param2:String) : void;
      
      function unregisterFlashComponentS(param1:String) : void;
      
      function as_populate() : void;
      
      function as_dispose() : void;
   }
}
