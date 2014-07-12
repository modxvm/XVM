package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IFortFixedPlayersWindowMeta extends IEventDispatcher
   {
      
      function assignToBuildingS() : void;
      
      function as_setWindowTitle(param1:String) : void;
      
      function as_setData(param1:Object) : void;
   }
}
