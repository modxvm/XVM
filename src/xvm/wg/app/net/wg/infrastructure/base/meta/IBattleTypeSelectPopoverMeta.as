package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleTypeSelectPopoverMeta extends IEventDispatcher
   {
      
      function selectFightS(param1:String) : void;
      
      function as_update(param1:Array) : void;
   }
}
