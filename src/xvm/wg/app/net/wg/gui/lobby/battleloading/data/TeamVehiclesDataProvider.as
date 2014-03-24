package net.wg.gui.lobby.battleloading.data
{
   import net.wg.gui.lobby.battleloading.vo.VehicleInfoVO;


   public class TeamVehiclesDataProvider extends EnemyVehiclesDataProvider
   {
          
      public function TeamVehiclesDataProvider(param1:Number=undefined, param2:Number=undefined, param3:Array=null) {
         this.playerVehicleID = param1;
         this.prebattleID = param2;
         super(param3);
      }

      private var playerVehicleID:Number = 0;

      private var prebattleID:Number = 0;

      public function setPlayerVehicleID(param1:Number) : void {
         this.playerVehicleID = param1;
      }

      public function setPrebattleID(param1:Number) : void {
         this.prebattleID = param1;
      }

      override protected function makeVO(param1:Object) : VehicleInfoVO {
         var _loc2_:VehicleInfoVO = super.makeVO(param1);
         _loc2_.isPlayerTeam = true;
         if((this.playerVehicleID) && this.playerVehicleID == _loc2_.vehicleID)
         {
            _loc2_.isCurrentPlayer = true;
         }
         if((this.prebattleID) && this.prebattleID == _loc2_.prebattleID)
         {
            _loc2_.isCurrentSquad = true;
         }
         return _loc2_;
      }
   }

}