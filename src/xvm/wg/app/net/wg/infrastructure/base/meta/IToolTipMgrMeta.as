package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IToolTipMgrMeta extends IEventDispatcher
   {
      
      function onCreateComplexTooltipS(param1:String, param2:String) : void;
      
      function onCreateTypedTooltipS(param1:String, param2:Array, param3:String) : void;
      
      function as_show(param1:Object, param2:String) : void;
   }
}
