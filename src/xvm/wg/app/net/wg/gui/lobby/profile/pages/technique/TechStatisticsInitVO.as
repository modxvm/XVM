package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.gui.lobby.profile.data.ProfileBattleTypeInitVO;
   
   public class TechStatisticsInitVO extends ProfileBattleTypeInitVO
   {
      
      public function TechStatisticsInitVO(param1:Object) {
         super(param1);
      }
      
      public var hangarVehiclesLabel:String = "";
      
      public var isInHangarSelected:Boolean;
   }
}
