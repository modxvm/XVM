package net.wg.data.constants 
{
    import __AS3__.vec.*;
    
    public class ItemTypes extends Object
    {
        public function ItemTypes()
        {
            super();
            return;
        }

        public static function getItemTypeName(arg1:uint):String
        {
            var loc1:*=arg1;
            switch (loc1) 
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
            }
            DebugUtils.LOG_WARNING("Trying to resolve unknown type index", arg1);
            return "";
        }

        public static const VEHICLE:uint=1;

        public static const CHASSIS:uint=2;

        public static const TURRET:uint=3;

        public static const GUN:uint=4;

        public static const ENGINE:uint=5;

        public static const FUEL_TANK:uint=6;

        public static const RADIO:uint=7;

        public static const TANKMAN:uint=8;

        public static const OPT_DEVS:uint=9;

        public static const SHELL:uint=10;

        public static const EQUIPMENT:uint=11;

        public static const SERVER_ITEMS:__AS3__.vec.Vector.<uint>=Vector.<uint>([VEHICLE, CHASSIS, TURRET, GUN, ENGINE, FUEL_TANK, RADIO, TANKMAN, OPT_DEVS, SHELL, EQUIPMENT]);

        public static const ACCOUNT_DOSSIER:uint=16;

        public static const VEHICLE_DOSSIER:uint=17;

        public static const TANKMAN_DOSSIER:uint=18;

        public static const ACHIEVEMENT:uint=19;

        public static const TANKMAN_SKILL:uint=20;

        public static const CLIENT_ITEMS:__AS3__.vec.Vector.<uint>=Vector.<uint>([ACCOUNT_DOSSIER, VEHICLE_DOSSIER, TANKMAN_DOSSIER, ACHIEVEMENT, TANKMAN_SKILL]);
    }
}
