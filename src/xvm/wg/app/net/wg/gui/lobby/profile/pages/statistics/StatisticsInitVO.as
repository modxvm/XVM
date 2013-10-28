package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class StatisticsInitVO extends DAAPIDataClass
   {
          
      public function StatisticsInitVO(param1:Object) {
         super(param1);
      }

      public var mainDropDownMenu:Array;

      public var commonScores:Object;

      public var detailedScores:Object;

      public var charts:Array;

      public var battlesOnTech:String = "";

      public var chartsTitles:Array;
   }

}