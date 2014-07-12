package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IColorSchemeManagerMeta extends IEventDispatcher
   {
      
      function getColorSchemeS(param1:String) : Object;
      
      function as_update() : void;
   }
}
