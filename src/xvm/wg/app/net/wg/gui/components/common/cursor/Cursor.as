package net.wg.gui.components.common.cursor
{
   import net.wg.gui.components.common.cursor.base.DroppingCursor;
   import net.wg.infrastructure.interfaces.ICursor;
   import flash.utils.Dictionary;
   import net.wg.infrastructure.interfaces.entity.IDragDropHitArea;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   import net.wg.infrastructure.interfaces.entity.IDroppable;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import flash.events.EventDispatcher;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.DragType;
   import flash.events.MouseEvent;
   import net.wg.gui.components.common.cursor.base.BaseInfo;
   import flash.display.InteractiveObject;
   import net.wg.data.constants.Cursors;


   public class Cursor extends DroppingCursor implements ICursor
   {
          
      public function Cursor() {
         this._dragObjects = new Dictionary(true);
         super();
         stop();
      }

      private static const CAST_MSG_ERROR:String = "dragArea for registerDragging must implements IDraggable or IDroppable interfaces.";

      private var _dragObjects:Dictionary;

      private var _isOnDragging:Boolean = false;

      override public function registerDragging(param1:IDragDropHitArea, param2:String=null) : void {
         if(!(param1  is  IDraggable) && !(param1  is  IDroppable))
         {
            DebugUtils.LOG_ERROR(CAST_MSG_ERROR);
         }
         else
         {
            super.registerDragging(param1,param2);
            if(param1  is  IDraggable)
            {
               this.registerDrag(IDraggable(param1),param2);
            }
            if(param1  is  IView)
            {
               IView(param1).addEventListener(LifeCycleEvent.ON_AFTER_DISPOSE,this.onAfterDraggableObjDispose);
            }
         }
      }

      override public function unRegisterDragging(param1:IDragDropHitArea) : void {
         if(!disposed)
         {
            if(!(param1  is  IDraggable) && !(param1  is  IDroppable))
            {
               DebugUtils.LOG_ERROR(CAST_MSG_ERROR);
            }
            else
            {
               super.unRegisterDragging(param1);
               assertNotNull(param1,"container");
               if(param1  is  IDraggable)
               {
                  this.unRegisterDrag(IDraggable(param1));
               }
               if(param1  is  IView)
               {
                  EventDispatcher(param1).removeEventListener(LifeCycleEvent.ON_AFTER_DISPOSE,this.onAfterDraggableObjDispose);
               }
            }
         }
      }

      public function as_setCursor(param1:String) : void {
         setCursor(param1);
      }

      override protected function nextFrameAfterPopulateHandler() : void {
          
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         if(App.instance)
         {
            x = App.appWidth - width >> 1;
            y = App.appHeight - height >> 1;
         }
      }

      override protected function onDispose() : void {
         var _loc1_:DragInfo = null;
         for each (_loc1_ in this._dragObjects)
         {
            DebugUtils.LOG_DEBUG(_loc1_.container + Errors.WASNT_UNREGISTERED);
            this.unRegisterDrag(_loc1_.container);
         }
         this._dragObjects = null;
         super.onDispose();
      }

      override protected function cursorIsFree() : Boolean {
         return (super.cursorIsFree()) && !this._isOnDragging;
      }

      private function registerDrag(param1:IDraggable, param2:String=null) : void {
         var _loc3_:DragInfo = new DragInfo(param1,param2);
         assert(this._dragObjects[_loc3_.hit] == undefined,Errors.ALREADY_REGISTERED);
         this._dragObjects[_loc3_.hit] = _loc3_;
         if(_loc3_.container.getDragType() != DragType.NONE)
         {
            _loc3_.hit.addEventListener(MouseEvent.ROLL_OVER,this.onEnterToDragMode);
            _loc3_.hit.addEventListener(MouseEvent.ROLL_OUT,this.rollOutDragHandler);
            _loc3_.hit.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDnDragHandler);
         }
      }

      private function unRegisterDrag(param1:IDraggable) : void {
         var _loc2_:InteractiveObject = BaseInfo.getHitFromContainer(param1);
         assert(!(this._dragObjects[_loc2_] == undefined),Errors.MUST_REGISTER);
         var _loc3_:DragInfo = this.getDragInfoByHit(_loc2_);
         if(_loc3_.state == BaseInfo.STATE_STARTED || _loc3_.state == BaseInfo.STATE_INITIALIZED)
         {
            _loc2_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,false));
            assert(_loc3_.state == BaseInfo.STATE_NONE,"drag state must be STATE_NONE after dispatching MOUSE_UP");
         }
         _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.onEnterToDragMode);
         _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.rollOutDragHandler);
         _loc2_.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDnDragHandler);
         delete this._dragObjects[[_loc2_]];
         _loc3_.dispose();
      }

      private function getDragInfoByHit(param1:InteractiveObject) : DragInfo {
         return this._dragObjects[param1];
      }

      private function setDragging(param1:Boolean, param2:Boolean=false) : void {
         if(param1 != this._isOnDragging)
         {
            this._isOnDragging = param1;
            if(param2)
            {
               tryToResetCursor();
            }
         }
      }

      private function onEnterToDragMode(param1:MouseEvent) : void {
         if(!this._isOnDragging)
         {
            forceSetCursor(Cursors.DRAG_OPEN);
         }
      }

      private function draggingHandler(param1:MouseEvent) : void {
         assertLifeCycle();
         var _loc2_:DragInfo = this.getDragInfoByHit(InteractiveObject(param1.currentTarget));
         if(_loc2_.state != BaseInfo.STATE_STARTED)
         {
            _loc2_.state = BaseInfo.STATE_STARTED;
            _loc2_.container.onStartDrag();
         }
         var _loc3_:IDraggable = _loc2_.container;
         _loc3_.onDragging(param1.localX,param1.localY);
      }

      private function rollOutDragHandler(param1:MouseEvent) : void {
         assertLifeCycle();
         resetCursor();
      }

      private function mouseDnDragHandler(param1:MouseEvent) : void {
         var dragInfo:DragInfo = null;
         var mouseUpLclHdr:Function = null;
         var mouseReleaseOutsideLclHdr:Function = null;
         var event:MouseEvent = param1;
         if(isLeftButton(event))
         {
            mouseUpLclHdr = function(param1:MouseEvent):void
            {
               assertLifeCycle();
               stage.removeEventListener(MouseEvent.MOUSE_UP,mouseReleaseOutsideLclHdr);
               dragInfo.hit.removeEventListener(MouseEvent.MOUSE_UP,mouseUpLclHdr);
               dragInfo.hit.removeEventListener(MouseEvent.MOUSE_MOVE,draggingHandler);
               if(_isOnDragging)
               {
                  forceSetCursor(Cursors.DRAG_OPEN);
                  setDragging(false);
               }
               dragInfo.container.onEndDrag();
               dragInfo.state = BaseInfo.STATE_NONE;
            };
            mouseReleaseOutsideLclHdr = function(param1:MouseEvent):void
            {
               dragInfo.state = BaseInfo.STATE_NONE;
               setDragging(false,true);
               mouseUpLclHdr(param1);
            };
            assertLifeCycle();
            dragInfo = this.getDragInfoByHit(InteractiveObject(event.currentTarget));
            this.setDragging(true);
            forceSetCursor(dragInfo.cursor);
            dragInfo.state = BaseInfo.STATE_INITIALIZED;
            dragInfo.hit.addEventListener(MouseEvent.MOUSE_MOVE,this.draggingHandler);
            dragInfo.hit.addEventListener(MouseEvent.MOUSE_UP,mouseUpLclHdr,false);
            stage.addEventListener(MouseEvent.MOUSE_UP,mouseReleaseOutsideLclHdr,false);
         }
      }

      private function onAfterDraggableObjDispose(param1:LifeCycleEvent) : void {
         assertLifeCycle();
         var _loc2_:IDraggable = IDraggable(param1.target);
         DebugUtils.LOG_DEBUG(_loc2_ + Errors.WASNT_UNREGISTERED);
         IView(_loc2_).removeEventListener(LifeCycleEvent.ON_AFTER_DISPOSE,this.onAfterDraggableObjDispose);
         var _loc3_:InteractiveObject = BaseInfo.getHitFromContainer(_loc2_);
         if(this._dragObjects[_loc3_] != undefined)
         {
            this.unRegisterDragging(_loc2_);
         }
      }
   }

}   import net.wg.gui.components.common.cursor.base.BaseInfo;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   import net.wg.data.constants.Cursors;


   class DragInfo extends BaseInfo
   {
          
      function DragInfo(param1:IDraggable, param2:String) {
         super(param1,param2,Cursors.DRAG_CLOSE);
      }

      public function get container() : IDraggable {
         return IDraggable(getContainer());
      }
   }
