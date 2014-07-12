package net.wg.gui.lobby.hangar
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    
    public class ParamsListener extends Object implements IDisposable
    {
        
        public function ParamsListener() {
            this.vehicleGun = [];
            this.vehicleTurret = [];
            this.vehicleEngine = [];
            this.vehicleChassis = [];
            this.vehicleRadio = [];
            this.empty = [];
            super();
            this.vehicleGun = ["weight","damage","piercingPower","reloadTime"];
            this.vehicleTurret = ["maxHealth","weight","turretArmor","turretRotationSpeed","circularVisionRadius"];
            this.vehicleEngine = ["weight","enginePower","speedLimits"];
            this.vehicleChassis = ["weight","speedLimits","chassisRotationSpeed"];
            this.vehicleRadio = ["weight","radioDistance"];
            this.empty = [];
        }
        
        private var vehicleGun:Array;
        
        private var vehicleTurret:Array;
        
        private var vehicleEngine:Array;
        
        private var vehicleChassis:Array;
        
        private var vehicleRadio:Array;
        
        private var empty:Array;
        
        public function getParams(param1:String) : Array {
            switch(param1)
            {
                case "vehicleGun":
                    return this.vehicleGun;
                case "vehicleTurret":
                    return this.vehicleTurret;
                case "vehicleEngine":
                    return this.vehicleEngine;
                case "vehicleChassis":
                    return this.vehicleChassis;
                case "vehicleRadio":
                    return this.vehicleRadio;
                case "empty":
                    return this.empty;
                default:
                    return this.empty;
            }
        }
        
        public function dispose() : void {
            this.vehicleGun.splice(0,this.vehicleGun.length);
            this.vehicleGun = null;
            this.vehicleTurret.splice(0,this.vehicleTurret.length);
            this.vehicleTurret = null;
            this.vehicleEngine.splice(0,this.vehicleEngine.length);
            this.vehicleEngine = null;
            this.vehicleChassis.splice(0,this.vehicleChassis.length);
            this.vehicleChassis = null;
            this.empty.splice(0,this.empty.length);
            this.empty = null;
        }
    }
}
