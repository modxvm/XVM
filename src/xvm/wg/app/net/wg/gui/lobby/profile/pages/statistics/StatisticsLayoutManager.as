package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.gui.lobby.profile.data.SectionLayoutManager;
   import net.wg.gui.lobby.profile.ProfileConstants;
   import flash.display.DisplayObject;
   import net.wg.gui.lobby.profile.components.LineDescrIconText;


   public class StatisticsLayoutManager extends SectionLayoutManager
   {
          
      public function StatisticsLayoutManager(param1:Number, param2:Number) {
         super(param1,param2);
      }

      private var stepW:int;

      override public function setDimension(param1:Number, param2:Number) : void {
         super.setDimension(param1,param2);
         var _loc3_:uint = store.length;
         this.stepW = ProfileConstants.WINDOW_CENTER_OFFSET / _loc3_ / (_loc3_ + 1);
      }

      override protected function applyDimensionToItem(param1:int) : void {
         var _loc2_:DisplayObject = null;
         super.applyDimensionToItem(param1);
         if(!isInitialized)
         {
            _loc2_ = store[param1].item;
            if(_loc2_  is  LineDescrIconText)
            {
               _loc2_.x = this.stepW + param1 * (_loc2_.width + this.stepW);
            }
         }
      }
   }

}