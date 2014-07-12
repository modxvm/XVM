package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.base.meta.ICursorMeta;
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.interfaces.entity.IDragDropHitArea;
   import flash.display.Sprite;
   
   public interface ICursor extends ICursorMeta, IView
   {
      
      function useResizeCursor(param1:InteractiveObject) : void;
      
      function unUseResizeCursor(param1:InteractiveObject) : void;
      
      function registerDragging(param1:IDragDropHitArea, param2:String = null) : void;
      
      function unRegisterDragging(param1:IDragDropHitArea) : void;
      
      function attachToCursor(param1:Sprite, param2:Number, param3:Number) : void;
      
      function getAttachedSprite() : Sprite;
      
      function detachFromCursor() : void;
      
      function resetCursor() : void;
      
      function setCursor(param1:String) : void;
      
      function lock() : void;
      
      function unlock() : void;
   }
}
