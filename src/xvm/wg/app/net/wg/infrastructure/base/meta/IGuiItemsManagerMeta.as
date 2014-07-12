package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IGuiItemsManagerMeta extends IEventDispatcher
   {
      
      function _getItemAttributeS(param1:int, param2:Object, param3:String) : Object;
      
      function _callItemMethodS(param1:int, param2:Object, param3:String, param4:Array) : Object;
   }
}
