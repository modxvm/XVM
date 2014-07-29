package net.wg.data.gui_items
{
    import net.wg.data.utilData.TankmanRoleLevel;
    import net.wg.data.constants.ItemTypes;
    
    public class Tankman extends GUIItem
    {
        
        public function Tankman(param1:uint)
        {
            super(ItemTypes.TANKMAN,param1);
        }
        
        public function get inventoryID() : uint
        {
            return _id;
        }
        
        public function get nationID() : uint
        {
            return uint(_getAttr("nationID"));
        }
        
        public function get combinedRoles() : Array
        {
            return _getAttr("combinedRoles") as Array;
        }
        
        public function get nativeVehicle() : Vehicle
        {
            return new Vehicle(uint(_getAttr("nativeVehicle")));
        }
        
        public function get currentVehicle() : Vehicle
        {
            var _loc1_:* = _getAttr("currentVehicle");
            if(_loc1_ != null)
            {
                return new Vehicle(uint(_loc1_));
            }
            return null;
        }
        
        public function get isInTank() : Boolean
        {
            return Boolean(_getAttr("isInTank"));
        }
        
        public function get roleLevel() : uint
        {
            return uint(_getAttr("roleLevel"));
        }
        
        public function get icon() : String
        {
            return String(_getAttr("icon"));
        }
        
        public function get iconRank() : String
        {
            return String(_getAttr("iconRank"));
        }
        
        public function get iconRole() : String
        {
            return String(_getAttr("iconRole"));
        }
        
        public function get firstUserName() : String
        {
            return String(_getAttr("firstUserName"));
        }
        
        public function get lastUserName() : String
        {
            return String(_getAttr("lastUserName"));
        }
        
        public function get roleUserName() : String
        {
            return String(_getAttr("roleUserName"));
        }
        
        public function get rankUserName() : String
        {
            return String(_getAttr("rankUserName"));
        }
        
        public function get hasNewSkill() : Boolean
        {
            return Boolean(_getAttr("hasNewSkill"));
        }
        
        public function get newSkillCount() : Boolean
        {
            return (_getAttr("newSkillCount") as Array)[0];
        }
        
        public function get newSkillLastLevel() : Boolean
        {
            return (_getAttr("newSkillCount") as Array)[1];
        }
        
        public function get efficiencyRoleLevel() : Boolean
        {
            return Boolean(_getAttr("efficiencyRoleLevel"));
        }
        
        public function get realRoleLevel() : TankmanRoleLevel
        {
            var _loc1_:Array = _getAttr("realRoleLevel") as Array;
            var _loc2_:Array = _loc1_[1] as Array;
            return new TankmanRoleLevel(_loc1_[0],_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3],_loc2_[4]);
        }
        
        public function get skills() : Vector.<TankmanSkill>
        {
            var _loc3_:String = null;
            var _loc1_:Array = _getAttr("skills") as Array;
            var _loc2_:Vector.<TankmanSkill> = new Vector.<TankmanSkill>();
            for each(_loc3_ in _loc1_)
            {
                _loc2_.push(new TankmanSkill(_loc3_,this.inventoryID));
            }
            return _loc2_;
        }
    }
}
