package net.wg.gui.lobby.hangar 
{
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class ParamsListener extends Object implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function ParamsListener()
        {
            this.vehicleGun = [];
            this.vehicleTurret = [];
            this.vehicleEngine = [];
            this.vehicleChassis = [];
            this.vehicleRadio = [];
            this.empty = [];
            super();
            this.vehicleGun = ["weight", "damage", "piercingPower", "reloadTime"];
            this.vehicleTurret = ["maxHealth", "weight", "turretArmor", "turretRotationSpeed", "circularVisionRadius"];
            this.vehicleEngine = ["weight", "enginePower", "speedLimits"];
            this.vehicleChassis = ["weight", "speedLimits", "chassisRotationSpeed"];
            this.vehicleRadio = ["weight", "radioDistance"];
            this.empty = [];
            return;
        }

        public function getParams(arg1:String):Array
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case "vehicleGun":
                {
                    return this.vehicleGun;
                }
                case "vehicleTurret":
                {
                    return this.vehicleTurret;
                }
                case "vehicleEngine":
                {
                    return this.vehicleEngine;
                }
                case "vehicleChassis":
                {
                    return this.vehicleChassis;
                }
                case "vehicleRadio":
                {
                    return this.vehicleRadio;
                }
                case "empty":
                {
                    return this.empty;
                }
                default:
                {
                    return this.empty;
                }
            }
        }

        public function dispose():void
        {
            this.vehicleGun = null;
            this.vehicleTurret = null;
            this.vehicleEngine = null;
            this.vehicleChassis = null;
            this.empty = null;
            return;
        }

        internal var vehicleGun:Array;

        internal var vehicleTurret:Array;

        internal var vehicleEngine:Array;

        internal var vehicleChassis:Array;

        internal var vehicleRadio:Array;

        internal var empty:Array;
    }
}
