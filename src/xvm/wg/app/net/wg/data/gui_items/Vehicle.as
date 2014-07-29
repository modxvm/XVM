package net.wg.data.gui_items
{
    import net.wg.data.constants.ItemTypes;
    import net.wg.data.utilData.TankmanSlot;
    
    public class Vehicle extends FittingItem
    {
        
        public function Vehicle(param1:int)
        {
            super(ItemTypes.VEHICLE,param1);
        }
        
        private function _createModulesList(param1:uint, param2:String) : Vector.<FittingItem>
        {
            var _loc4_:uint = 0;
            var _loc3_:Vector.<FittingItem> = new Vector.<FittingItem>();
            for each(_loc4_ in _getAttr(param2) as Array)
            {
                _loc3_.push(new FittingItem(param1,_loc4_));
            }
            return _loc3_;
        }
        
        public function get inventoryID() : int
        {
            return uint(_getAttr("invID"));
        }
        
        public function get xp() : uint
        {
            return uint(_getAttr("xp"));
        }
        
        public function get dailyXPFactor() : int
        {
            return uint(_getAttr("dailyXPFactor"));
        }
        
        public function get isElite() : Boolean
        {
            return Boolean(_getAttr("isElite"));
        }
        
        public function get isUnlocked() : Boolean
        {
            return Boolean(_getAttr("isUnlocked"));
        }
        
        public function get isUnique() : Boolean
        {
            return Boolean(_getAttr("isUnique"));
        }
        
        public function get isCrewFull() : Boolean
        {
            return Boolean(_getAttr("isCrewFull"));
        }
        
        public function get isAmmoFull() : Boolean
        {
            return Boolean(_getAttr("isAmmoFull"));
        }
        
        public function get isFavorite() : Boolean
        {
            return Boolean(_getAttr("isFavorite"));
        }
        
        public function get isPremium() : Boolean
        {
            return Boolean(_getAttr("isPremium"));
        }
        
        public function get isLocked() : Boolean
        {
            return Boolean(_getAttr("isLocked"));
        }
        
        public function get isInBattle() : Boolean
        {
            return Boolean(_getAttr("isInBattle"));
        }
        
        public function get isBroken() : Boolean
        {
            return Boolean(_getAttr("isBroken"));
        }
        
        public function get isAlive() : Boolean
        {
            return Boolean(_getAttr("isAlive"));
        }
        
        public function get isReadyToFight() : Boolean
        {
            return Boolean(_getAttr("isReadyToFight"));
        }
        
        public function get isInInventory() : Boolean
        {
            return !(this.inventoryID == -1);
        }
        
        public function get type() : String
        {
            return String(_getAttr("type"));
        }
        
        public function get typeIndex() : int
        {
            return int(_getAttr("typeIndex"));
        }
        
        public function get nationIndex() : int
        {
            return int(_getAttr("nationIndex"));
        }
        
        public function get smallIconPath() : String
        {
            return "../maps/icons/vehicle/small/" + name.replace(":","-") + ".png";
        }
        
        public function get repairCost() : uint
        {
            return uint(_getAttr("repairCost"));
        }
        
        public function get health() : uint
        {
            return uint(_getAttr("health"));
        }
        
        public function get gun() : FittingItem
        {
            return new FittingItem(ItemTypes.GUN,uint(_getAttr("gun")));
        }
        
        public function get turret() : FittingItem
        {
            return new FittingItem(ItemTypes.TURRET,uint(_getAttr("turret")));
        }
        
        public function get engine() : FittingItem
        {
            return new FittingItem(ItemTypes.ENGINE,uint(_getAttr("engine")));
        }
        
        public function get chassis() : FittingItem
        {
            return new FittingItem(ItemTypes.CHASSIS,uint(_getAttr("chassis")));
        }
        
        public function get radio() : FittingItem
        {
            return new FittingItem(ItemTypes.RADIO,uint(_getAttr("radio")));
        }
        
        public function get optDevs() : Vector.<FittingItem>
        {
            return this._createModulesList(ItemTypes.OPT_DEVS,"optDevs");
        }
        
        public function get eqs() : Vector.<FittingItem>
        {
            return this._createModulesList(ItemTypes.EQUIPMENT,"equipment");
        }
        
        public function get shells() : Vector.<FittingItem>
        {
            return this._createModulesList(ItemTypes.SHELL,"shells");
        }
        
        public function get crew() : Vector.<TankmanSlot>
        {
            var _loc2_:* = undefined;
            var _loc3_:Array = null;
            var _loc1_:Vector.<TankmanSlot> = new Vector.<TankmanSlot>();
            for each(_loc2_ in _getAttr("crew") as Array)
            {
                _loc3_ = _loc2_ as Array;
                _loc1_.push(new TankmanSlot(_loc3_[0],_loc3_[1]));
            }
            return _loc1_;
        }
    }
}
