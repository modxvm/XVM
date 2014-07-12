package net.wg.gui.lobby.profile.pages.summary
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SummaryInitVO extends DAAPIDataClass
   {
      
      public function SummaryInitVO(param1:Object) {
         super(param1);
      }
      
      public var significantAwardsLabel:String = "";
      
      public var significantAwardsErrorText:String = "";
      
      public var commonScores:Object;
   }
}
