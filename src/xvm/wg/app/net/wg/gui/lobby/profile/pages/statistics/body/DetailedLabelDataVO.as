package net.wg.gui.lobby.profile.pages.statistics.body
{


   public class DetailedLabelDataVO extends StatisticsLabelDataVO
   {
          
      public function DetailedLabelDataVO(param1:Object) {
         super(param1);
      }

      private var _detailedInfoList:Array;

      override protected function parceData(param1:Object) : void {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         this._detailedInfoList = [];
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = [];
            _loc4_ = param1[_loc2_] as Array;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc3_.push(new DetailedStatisticsUnitVO(_loc4_[_loc5_]));
               _loc5_++;
            }
            this._detailedInfoList.push(_loc3_);
            _loc2_++;
         }
      }

      public function get detailedInfoList() : Array {
         return this._detailedInfoList;
      }

      override protected function onDispose() : void {
         super.onDispose();
         this._detailedInfoList = null;
      }
   }

}