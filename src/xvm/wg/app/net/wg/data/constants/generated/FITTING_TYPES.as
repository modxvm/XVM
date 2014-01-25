package net.wg.data.constants.generated
{


   public class FITTING_TYPES extends Object
   {
          
      public function FITTING_TYPES() {
         super();
      }

      public static const OPTIONAL_DEVICE:String = "optionalDevice";

      public static const EQUIPMENT:String = "equipment";

      public static const SHELL:String = "shell";

      public static const VEHICLE:String = "vehicle";

      public static const MODULE:String = "module";

      public static const STORE_SLOTS:Array = [VEHICLE,MODULE,SHELL,OPTIONAL_DEVICE,EQUIPMENT];

      public static const ARTEFACT_SLOTS:Array = [OPTIONAL_DEVICE,EQUIPMENT];

      public static const VEHICLE_GUN:String = "vehicleGun";

      public static const VEHICLE_TURRET:String = "vehicleTurret";

      public static const VEHICLE_CHASSIS:String = "vehicleChassis";

      public static const VEHICLE_ENGINE:String = "vehicleEngine";

      public static const VEHICLE_RADIO:String = "vehicleRadio";

      public static const MANDATORY_SLOTS:Array = [VEHICLE_GUN,VEHICLE_TURRET,VEHICLE_CHASSIS,VEHICLE_ENGINE,VEHICLE_RADIO];
   }

}