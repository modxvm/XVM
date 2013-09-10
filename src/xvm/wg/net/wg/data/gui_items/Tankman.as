package net.wg.data.gui_items 
{
    import __AS3__.vec.*;
    import net.wg.data.constants.*;
    import net.wg.data.utilData.*;
    
    public class Tankman extends net.wg.data.gui_items.GUIItem
    {
        public function Tankman(arg1:uint)
        {
            super(net.wg.data.constants.ItemTypes.TANKMAN, arg1);
            return;
        }

        public function get inventoryID():uint
        {
            return _id;
        }

        public function get nationID():uint
        {
            return uint(_getAttr("nationID"));
        }

        public function get combinedRoles():Array
        {
            return _getAttr("combinedRoles") as Array;
        }

        public function get nativeVehicle():net.wg.data.gui_items.Vehicle
        {
            return new net.wg.data.gui_items.Vehicle(uint(_getAttr("nativeVehicle")));
        }

        public function get currentVehicle():net.wg.data.gui_items.Vehicle
        {
            var loc1:*=_getAttr("currentVehicle");
            if (loc1 != null) 
                return new net.wg.data.gui_items.Vehicle(uint(loc1));
            return null;
        }

        public function get isInTank():Boolean
        {
            return Boolean(_getAttr("isInTank"));
        }

        public function get roleLevel():uint
        {
            return uint(_getAttr("roleLevel"));
        }

        public function get icon():String
        {
            return String(_getAttr("icon"));
        }

        public function get iconRank():String
        {
            return String(_getAttr("iconRank"));
        }

        public function get iconRole():String
        {
            return String(_getAttr("iconRole"));
        }

        public function get firstUserName():String
        {
            return String(_getAttr("firstUserName"));
        }

        public function get lastUserName():String
        {
            return String(_getAttr("lastUserName"));
        }

        public function get roleUserName():String
        {
            return String(_getAttr("roleUserName"));
        }

        public function get rankUserName():String
        {
            return String(_getAttr("rankUserName"));
        }

        public function get hasNewSkill():Boolean
        {
            return Boolean(_getAttr("hasNewSkill"));
        }

        public function get newSkillCount():Boolean
        {
            return (_getAttr("newSkillCount") as Array)[0];
        }

        public function get newSkillLastLevel():Boolean
        {
            return (_getAttr("newSkillCount") as Array)[1];
        }

        public function get efficiencyRoleLevel():Boolean
        {
            return Boolean(_getAttr("efficiencyRoleLevel"));
        }

        public function get realRoleLevel():net.wg.data.utilData.TankmanRoleLevel
        {
            var loc1:*=_getAttr("realRoleLevel") as Array;
            var loc2:*=loc1[1] as Array;
            return new net.wg.data.utilData.TankmanRoleLevel(loc1[0], loc2[0], loc2[1], loc2[2], loc2[3], loc2[4]);
        }

        public function get skills():__AS3__.vec.Vector.<net.wg.data.gui_items.TankmanSkill>
        {
            var loc3:*=null;
            var loc1:*=_getAttr("skills") as Array;
            var loc2:*=new Vector.<net.wg.data.gui_items.TankmanSkill>();
            var loc4:*=0;
            var loc5:*=loc1;
            for each (loc3 in loc5) 
                loc2.push(new net.wg.data.gui_items.TankmanSkill(loc3, this.inventoryID));
            return loc2;
        }
    }
}
