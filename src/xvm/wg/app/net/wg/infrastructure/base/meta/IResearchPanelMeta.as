package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IResearchPanelMeta extends IEventDispatcher
   {
      
      function goToResearchS() : void;
      
      function as_setEarnedXP(param1:Number) : void;
      
      function as_setElite(param1:Boolean) : void;
   }
}
