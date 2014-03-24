package net.wg.gui.lobby.profile.pages.statistics.body
{


   public class DetailedLabelDataVO extends StatisticsLabelDataVO
   {
          
      public function DetailedLabelDataVO(param1:Object) {
         super(param1);
      }

      private var _detailedInfoList:Array;

      override protected function parceData(param1:Object) : void {
         this._detailedInfoList = [];
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            this._detailedInfoList.push(new DetailedStatisticsUnitVO(param1[_loc2_]));
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