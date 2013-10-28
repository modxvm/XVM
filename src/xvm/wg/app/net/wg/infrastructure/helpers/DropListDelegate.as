package net.wg.infrastructure.helpers
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.IDragDropListDelegate;
   import __AS3__.vec.Vector;
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.events.DragDropEvent;
   import flash.display.Sprite;


   public class DropListDelegate extends MovieClip implements IDragDropListDelegate
   {
          
      public function DropListDelegate(param1:InteractiveObject, param2:String) {
         super();
         this._hitArea = param1;
         this._dropElementLinkage = param2;
      }

      private var _pairedScrollLists:Vector.<InteractiveObject> = null;

      private var _hitArea:InteractiveObject = null;

      private var _dropElementLinkage:String = null;

      public function dispose() : void {
         if(App.cursor.getAttachedSprite() != null)
         {
            if(App.cursor.getAttachedSprite()  is  IDisposable)
            {
               IDisposable(App.cursor.getAttachedSprite()).dispose();
            }
            App.cursor.detachFromCursor();
         }
         this._pairedScrollLists.splice(0,this._pairedScrollLists.length);
         this._pairedScrollLists = null;
         this._hitArea = null;
         this._dropElementLinkage = null;
      }

      public function onBeforeDrop(param1:InteractiveObject, param2:InteractiveObject) : Boolean {
         this.dispatchDragEvent(DragDropEvent.BEFORE_DROP,param1,null,param2);
         return true;
      }

      public function onAfterDrop(param1:InteractiveObject, param2:InteractiveObject) : void {
         this.dispatchDragEvent(DragDropEvent.AFTER_DROP,param1,null,param2);
         if(App.cursor.getAttachedSprite() != null)
         {
            if(App.cursor.getAttachedSprite()  is  IDisposable)
            {
               IDisposable(App.cursor.getAttachedSprite()).dispose();
            }
            App.cursor.detachFromCursor();
         }
      }

      public function onStartDrop(param1:InteractiveObject, param2:InteractiveObject, param3:Number, param4:Number) : Boolean {
         var _loc5_:Sprite = null;
         if(App.instance)
         {
            _loc5_ = App.utils.classFactory.getComponent(this._dropElementLinkage,Sprite);
            App.cursor.attachToCursor(_loc5_,-param3,-param4);
         }
         this.dispatchDragEvent(DragDropEvent.START_DROP,param1,null,param2);
         return true;
      }

      public function onEndDrop(param1:InteractiveObject, param2:InteractiveObject, param3:InteractiveObject, param4:InteractiveObject) : void {
         this.dispatchDragEvent(DragDropEvent.END_DROP,param1,param2,param3);
      }

      public function getDropGroup() : Vector.<InteractiveObject> {
         return Vector.<InteractiveObject>(this._pairedScrollLists);
      }

      public function getHitArea() : InteractiveObject {
         return this._hitArea;
      }

      public function setPairedDropLists(param1:Vector.<InteractiveObject>) : void {
         this._pairedScrollLists = param1;
      }

      private function dispatchDragEvent(param1:String, param2:InteractiveObject, param3:InteractiveObject, param4:InteractiveObject) : void {
         this._hitArea.dispatchEvent(new DragDropEvent(param1,param2,param3,param4));
      }
   }

}