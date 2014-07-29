package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class OrderVO extends DAAPIDataClass
    {
        
        public function OrderVO(param1:Object)
        {
            super(param1);
        }
        
        private var _enabled:Boolean = true;
        
        private var _orderID:String = "";
        
        private var _buildingStr:String = "";
        
        private var _orderIcon:String = "";
        
        private var _count:int = -1;
        
        private var _level:int = -1;
        
        private var _inProgress:Boolean = false;
        
        private var _inCooldown:Boolean = false;
        
        private var _cooldownPercent:Number = -1;
        
        private var _leftTime:Number = -1;
        
        private var _isPermanent:Boolean = false;
        
        private var _isRecharged:Boolean = false;
        
        public function get enabled() : Boolean
        {
            return this._enabled;
        }
        
        public function set enabled(param1:Boolean) : void
        {
            this._enabled = param1;
        }
        
        public function get orderIcon() : String
        {
            return this._orderIcon;
        }
        
        public function set orderIcon(param1:String) : void
        {
            this._orderIcon = param1;
        }
        
        public function get count() : int
        {
            return this._count;
        }
        
        public function set count(param1:int) : void
        {
            this._count = param1;
        }
        
        public function get level() : int
        {
            return this._level;
        }
        
        public function set level(param1:int) : void
        {
            this._level = param1;
        }
        
        public function get orderID() : String
        {
            return this._orderID;
        }
        
        public function set orderID(param1:String) : void
        {
            this._orderID = param1;
        }
        
        public function get inProgress() : Boolean
        {
            return this._inProgress;
        }
        
        public function set inProgress(param1:Boolean) : void
        {
            this._inProgress = param1;
        }
        
        public function get buildingStr() : String
        {
            return this._buildingStr;
        }
        
        public function set buildingStr(param1:String) : void
        {
            this._buildingStr = param1;
        }
        
        public function get cooldownPercent() : Number
        {
            return this._cooldownPercent;
        }
        
        public function set cooldownPercent(param1:Number) : void
        {
            this._cooldownPercent = param1;
        }
        
        public function get leftTime() : Number
        {
            return this._leftTime;
        }
        
        public function set leftTime(param1:Number) : void
        {
            this._leftTime = param1;
        }
        
        public function get inCooldown() : Boolean
        {
            return this._inCooldown;
        }
        
        public function set inCooldown(param1:Boolean) : void
        {
            this._inCooldown = param1;
        }
        
        public function get isPermanent() : Boolean
        {
            return this._isPermanent;
        }
        
        public function set isPermanent(param1:Boolean) : void
        {
            this._isPermanent = param1;
        }
        
        public function get isRecharged() : Boolean
        {
            return this._isRecharged;
        }
        
        public function set isRecharged(param1:Boolean) : void
        {
            this._isRecharged = param1;
        }
    }
}
