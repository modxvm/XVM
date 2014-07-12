package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IFortChoiceDivisionWindowMeta extends IEventDispatcher
   {
      
      function selectedDivisionS(param1:int) : void;
      
      function as_setData(param1:Object) : void;
   }
}
