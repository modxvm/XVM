package net.wg.gui.lobby.battleloading.data
{
   import scaleform.clik.data.DataProvider;
   import net.wg.gui.lobby.battleloading.interfaces.IVehiclesDataProvider;
   import net.wg.gui.lobby.battleloading.vo.VehicleInfoVO;
   
   public class EnemyVehiclesDataProvider extends DataProvider implements IVehiclesDataProvider
   {
      
      public function EnemyVehiclesDataProvider(param1:Array = null) {
         this.vehicleIDs = [];
         super(param1);
      }
      
      private var vehicleIDs:Array;
      
      public function setVehicleStatus(param1:Number, param2:Number) : Boolean {
         var _loc3_:int = this.vehicleIDs.indexOf(param1);
         var _loc4_:VehicleInfoVO = this[_loc3_] as VehicleInfoVO;
         if(!(_loc4_ == null) && !(_loc4_.vehicleStatus == param2))
         {
            _loc4_.vehicleStatus = param2;
            return true;
         }
         return false;
      }
      
      public function setPlayerStatus(param1:Number, param2:Number) : Boolean {
         var _loc3_:int = this.vehicleIDs.indexOf(param1);
         var _loc4_:VehicleInfoVO = this[_loc3_] as VehicleInfoVO;
         if(!(_loc4_ == null) && !(_loc4_.playerStatus == param2))
         {
            _loc4_.playerStatus = param2;
            return true;
         }
         return false;
      }
      
      public function addVehicleInfo(param1:Object, param2:Array) : Boolean {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc3_:VehicleInfoVO = this.makeVO(param1);
         push(_loc3_);
         this.setSorting(param2);
         return true;
      }
      
      public function updateVehicleInfo(param1:Object) : Boolean {
         var _loc2_:VehicleInfoVO = this.makeVO(param1);
         var _loc3_:int = this.vehicleIDs.indexOf(_loc2_.vehicleID);
         if(this[_loc3_])
         {
            this[_loc3_] = _loc2_;
            return true;
         }
         DebugUtils.LOG_ERROR("Vehicle not found in dataProvider",_loc2_);
         return false;
      }
      
      public function setSorting(param1:Array) : Boolean {
         if(param1 == null)
         {
            return false;
         }
         this.vehicleIDs = param1;
         sort(this.compare);
         return true;
      }
      
      override protected function parseSource(param1:Array) : void {
         var _loc3_:VehicleInfoVO = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:uint = param1.length;
         this.splice();
         this.vehicleIDs = [];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this.makeVO(param1[_loc4_]);
            this[_loc4_] = _loc3_;
            this.vehicleIDs.push(_loc3_.vehicleID);
            _loc4_++;
         }
      }
      
      protected function makeVO(param1:Object) : VehicleInfoVO {
         return new VehicleInfoVO(param1);
      }
      
      private function compare(param1:VehicleInfoVO, param2:VehicleInfoVO) : Number {
         var _loc3_:int = this.vehicleIDs.indexOf(param1.vehicleID);
         var _loc4_:int = this.vehicleIDs.indexOf(param2.vehicleID);
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
   }
}
