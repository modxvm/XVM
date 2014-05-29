package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;


   public interface IFortListMeta extends IEventDispatcher
   {
          
      function changeDivisionIndexS(param1:int) : void;

      function as_getDivisionsDP() : Object;

      function as_setSelectedDivision(param1:int) : void;

      function as_setDetails(param1:Object) : void;

      function as_setCreationEnabled(param1:Boolean) : void;
   }

}