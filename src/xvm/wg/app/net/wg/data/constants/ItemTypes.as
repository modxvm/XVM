package net.wg.data.constants
{
    public class ItemTypes extends Object
    {
        
        public function ItemTypes()
        {
            super();
        }
        
        public static var VEHICLE:uint = 1;
        
        public static var CHASSIS:uint = 2;
        
        public static var TURRET:uint = 3;
        
        public static var GUN:uint = 4;
        
        public static var ENGINE:uint = 5;
        
        public static var FUEL_TANK:uint = 6;
        
        public static var RADIO:uint = 7;
        
        public static var TANKMAN:uint = 8;
        
        public static var OPT_DEVS:uint = 9;
        
        public static var SHELL:uint = 10;
        
        public static var EQUIPMENT:uint = 11;
        
        public static var SERVER_ITEMS:Vector.<uint> = Vector.<uint>([VEHICLE,CHASSIS,TURRET,GUN,ENGINE,FUEL_TANK,RADIO,TANKMAN,OPT_DEVS,SHELL,EQUIPMENT]);
        
        public static var ACCOUNT_DOSSIER:uint = 16;
        
        public static var VEHICLE_DOSSIER:uint = 17;
        
        public static var TANKMAN_DOSSIER:uint = 18;
        
        public static var ACHIEVEMENT:uint = 19;
        
        public static var TANKMAN_SKILL:uint = 20;
        
        public static var CLIENT_ITEMS:Vector.<uint> = Vector.<uint>([ACCOUNT_DOSSIER,VEHICLE_DOSSIER,TANKMAN_DOSSIER,ACHIEVEMENT,TANKMAN_SKILL]);
        
        public static function getItemTypeName(param1:uint) : String
        {
            switch(param1)
            {
                case VEHICLE:
                    return "vehicle";
                case CHASSIS:
                    return "vehicleChassis";
                case TURRET:
                    return "vehicleTurret";
                case GUN:
                    return "vehicleGun";
                case ENGINE:
                    return "vehicleEngine";
                case FUEL_TANK:
                    return "vehicleFuelTank";
                case RADIO:
                    return "vehicleRadio";
                case TANKMAN:
                    return "tankman";
                case OPT_DEVS:
                    return "optionalDevice";
                case SHELL:
                    return "shell";
                case EQUIPMENT:
                    return "equipment";
                case TANKMAN_SKILL:
                    return "tankmanSkill";
                default:
                    DebugUtils.LOG_WARNING("Trying to resolve unknown type index",param1);
                    return "";
            }
        }
    }
}
