package net.wg.gui.lobby.training
{
   import net.wg.infrastructure.helpers.DragDropListDelegateCtrlr;
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.interfaces.entity.IDroppable;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import net.wg.infrastructure.interfaces.IDropList;
   import __AS3__.vec.Vector;


   public class TrainingDragController extends DragDropListDelegateCtrlr
   {
          
      public function TrainingDragController(param1:Vector.<InteractiveObject>, param2:Class, param3:String) {
         super(param1,param2,param3);
      }

      override protected function onHighlightHitAreas(param1:Boolean, param2:InteractiveObject) : void {
         var _loc3_:IDroppable = null;
         if(param2  is  IDropItem)
         {
            if(param1)
            {
               param2.alpha = 0.3;
               for each (_loc3_ in getDelegates())
               {
                  IDropList(_loc3_.getHitArea()).highlightList();
               }
            }
            else
            {
               if(param2)
               {
                  param2.alpha = 1;
               }
               for each (_loc3_ in getDelegates())
               {
                  IDropList(_loc3_.getHitArea()).hideHighLight();
               }
            }
         }
      }
   }

}