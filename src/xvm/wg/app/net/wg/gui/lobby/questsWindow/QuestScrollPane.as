package net.wg.gui.lobby.questsWindow
{
   import net.wg.gui.lobby.profile.components.ResizableScrollPane;


   public class QuestScrollPane extends ResizableScrollPane
   {
          
      public function QuestScrollPane() {
         super();
      }

      override protected function applyScrollBarUpdating() : void {
         var _loc1_:Number = scrollPageSize;
         var _loc2_:* = 0;
         var _loc3_:int = maxScroll;
         scrollBar.setScrollProperties(_loc1_,_loc2_,_loc3_);
         var _loc4_:Number = (scrollBar.position - _loc2_) / (_loc3_ - _loc2_);
         var _loc5_:* = !((isNaN(_loc4_)) || (isNaN(_loc1_)) || _loc3_ <= 0 || _loc3_ == Infinity);
         if(!_loc5_)
         {
            _scrollPosition = 0;
         }
         if(_target)
         {
            _target.y = -(_scrollStepFactor * _scrollPosition);
         }
         scrollBar.position = _scrollPosition;
         scrollBar.trackScrollPageSize = _loc1_;
      }
   }

}