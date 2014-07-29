package net.wg.data.constants.generated
{
    public class FITTING_TYPES extends Object
    {
        
        public function FITTING_TYPES()
        {
            super();
        }
        
        public static var OPTIONAL_DEVICE:String = "optionalDevice";
        
        public static var EQUIPMENT:String = "equipment";
        
        public static var SHELL:String = "shell";
        
        public static var VEHICLE:String = "vehicle";
        
        public static var MODULE:String = "module";
        
        public static var STORE_SLOTS:Array = [VEHICLE,MODULE,SHELL,OPTIONAL_DEVICE,EQUIPMENT];
        
        public static var ARTEFACT_SLOTS:Array = [OPTIONAL_DEVICE,EQUIPMENT];
        
        public static var VEHICLE_GUN:String = "vehicleGun";
        
        public static var VEHICLE_TURRET:String = "vehicleTurret";
        
        public static var VEHICLE_CHASSIS:String = "vehicleChassis";
        
        public static var VEHICLE_ENGINE:String = "vehicleEngine";
        
        public static var VEHICLE_RADIO:String = "vehicleRadio";
        
        public static var MANDATORY_SLOTS:Array = [VEHICLE_GUN,VEHICLE_TURRET,VEHICLE_CHASSIS,VEHICLE_ENGINE,VEHICLE_RADIO];
    }
}
