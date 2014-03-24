package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class StatisticsTooltipDataVO extends DAAPIDataClass
   {
          
      public function StatisticsTooltipDataVO(param1:Object) {
         super(param1);
      }

      public var header:Object;

      public var body:Object;

      public var note:Object;
   }

}