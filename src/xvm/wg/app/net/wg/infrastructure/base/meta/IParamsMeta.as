package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IParamsMeta extends IEventDispatcher
   {
      
      function as_setValues(param1:Array) : void;
      
      function as_highlightParams(param1:String) : void;
   }
}
