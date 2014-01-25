package net.wg.gui.lobby.training
{
   import net.wg.infrastructure.helpers.DragDropListDelegateCtrlr;
   import flash.display.InteractiveObject;
   import __AS3__.vec.Vector;
   import net.wg.infrastructure.interfaces.IDragDropListDelegate;
   import net.wg.data.VO.TrainingRoomRendererVO;
   import net.wg.infrastructure.interfaces.entity.IDroppable;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import net.wg.infrastructure.interfaces.IDropList;


   public class TrainingDragController extends DragDropListDelegateCtrlr
   {
          
      public function TrainingDragController(param1:Vector.<InteractiveObject>, param2:Class, param3:String, param4:Function) {
         this._isSlotDroppable = param4;
         super(param1,param2,param3);
      }

      private var _isSlotDroppable:Function = null;

      override protected function onHighlightHitAreas(param1:Boolean, param2:InteractiveObject) : void {
         var _loc3_:Vector.<IDragDropListDelegate> = null;
         var _loc4_:TrainingRoomRendererVO = null;
         var _loc5_:* = 0;
         var _loc6_:IDroppable = null;
         if(param2  is  IDropItem)
         {
            if(param1)
            {
               param2.alpha = 0.3;
               _loc3_ = getDelegates();
               _loc4_ = TrainingRoomRendererVO(IDropItem(param2).data);
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  if(this._isSlotDroppable(_loc4_.accID,_loc5_))
                  {
                     IDropList(_loc3_[_loc5_].getHitArea()).highlightList();
                  }
                  _loc5_++;
               }
            }
            else
            {
               if(param2)
               {
                  param2.alpha = 1;
               }
               for each (_loc6_ in getDelegates())
               {
                  IDropList(_loc6_.getHitArea()).hideHighLight();
               }
            }
         }
      }

      override protected function onDispose() : void {
         this._isSlotDroppable = null;
         super.onDispose();
      }
   }

}