package net.wg.gui.lobby.window
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ExchangeXPVehicleVO extends DAAPIDataClass
   {
          
      public function ExchangeXPVehicleVO(param1:Object) {
         super(param1);
      }

      public var id:Number = NaN;

      public var vehicleType:String = "";

      public var vehicleName:String = "";

      public var xp:Number;

      public var isSelectCandidate:Boolean;

      public var vehicleIco:String = "";

      public var nationIco:String = "";
   }

}