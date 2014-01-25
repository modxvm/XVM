package net.wg.gui.lobby.retrainCrewWindow
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class RetrainCrewVO extends DAAPIDataClass
   {
          
      public function RetrainCrewVO(param1:Object) {
         super(param1);
      }

      public var vehicle:Object;

      public var crew:Object;

      private var _crewInfoVO:Array;

      private var _vehicleBlockVO:RetrainVehicleBlockVO;

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:* = 0;
         var _loc6_:RetrainTankmanVO = null;
         if(param1 == "vehicle")
         {
            this._vehicleBlockVO = new RetrainVehicleBlockVO(param2);
            return false;
         }
         if(param1 == "crew")
         {
            this._crewInfoVO = [];
            _loc3_ = param2 as Array;
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = new RetrainTankmanVO(_loc3_[_loc5_]);
               this._crewInfoVO.push(_loc6_);
               _loc5_++;
            }
            return false;
         }
         return this.hasOwnProperty(param1);
      }

      public function get vehicleBlockVO() : RetrainVehicleBlockVO {
         return this._vehicleBlockVO;
      }

      public function get crewInfoVO() : Array {
         return this._crewInfoVO;
      }
   }

}