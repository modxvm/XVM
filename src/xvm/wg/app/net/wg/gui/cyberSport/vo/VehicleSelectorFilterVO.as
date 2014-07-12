package net.wg.gui.cyberSport.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class VehicleSelectorFilterVO extends DAAPIDataClass
    {
        
        public function VehicleSelectorFilterVO(param1:Object) {
            super(param1);
        }
        
        private var _nation:int = -1;
        
        private var _vehicleType:String = "";
        
        private var _isMain:Boolean = false;
        
        private var _level:int = -1;
        
        private var _compatibleOnly:Boolean = true;
        
        private var _vehicleTypesDP:Array = null;
        
        private var _levelsDP:Array = null;
        
        public function get vehicleTypesDP() : Array {
            return this._vehicleTypesDP;
        }
        
        public function set vehicleTypesDP(param1:Array) : void {
            this._vehicleTypesDP = param1;
        }
        
        public function get levelsDP() : Array {
            return this._levelsDP;
        }
        
        public function set levelsDP(param1:Array) : void {
            this._levelsDP = param1;
        }
        
        public function get nation() : int {
            return this._nation;
        }
        
        public function set nation(param1:int) : void {
            this._nation = param1;
        }
        
        public function get vehicleType() : String {
            return this._vehicleType;
        }
        
        public function set vehicleType(param1:String) : void {
            this._vehicleType = param1;
        }
        
        public function get isMain() : Boolean {
            return this._isMain;
        }
        
        public function set isMain(param1:Boolean) : void {
            this._isMain = param1;
        }
        
        public function get level() : int {
            return this._level;
        }
        
        public function set level(param1:int) : void {
            this._level = param1;
        }
        
        public function get compatibleOnly() : Boolean {
            return this._compatibleOnly;
        }
        
        public function set compatibleOnly(param1:Boolean) : void {
            this._compatibleOnly = param1;
        }
    }
}
