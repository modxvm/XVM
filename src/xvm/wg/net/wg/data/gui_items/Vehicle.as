package net.wg.data.gui_items 
{
    import __AS3__.vec.*;
    import net.wg.data.constants.*;
    import net.wg.data.utilData.*;
    
    public class Vehicle extends net.wg.data.gui_items.FittingItem
    {
        public function Vehicle(arg1:int)
        {
            super(net.wg.data.constants.ItemTypes.VEHICLE, arg1);
            return;
        }

        internal function _createModulesList(arg1:uint, arg2:String):__AS3__.vec.Vector.<net.wg.data.gui_items.FittingItem>
        {
            var loc2:*=0;
            var loc1:*=new Vector.<net.wg.data.gui_items.FittingItem>();
            var loc3:*=0;
            var loc4:*=_getAttr(arg2) as Array;
            for each (loc2 in loc4) 
            {
                loc1.push(new net.wg.data.gui_items.FittingItem(arg1, loc2));
            }
            return loc1;
        }

        public function get inventoryID():int
        {
            return uint(_getAttr("invID"));
        }

        public function get xp():uint
        {
            return uint(_getAttr("xp"));
        }

        public function get dailyXPFactor():int
        {
            return uint(_getAttr("dailyXPFactor"));
        }

        public function get isElite():Boolean
        {
            return Boolean(_getAttr("isElite"));
        }

        public function get isUnlocked():Boolean
        {
            return Boolean(_getAttr("isUnlocked"));
        }

        public function get isUnique():Boolean
        {
            return Boolean(_getAttr("isUnique"));
        }

        public function get isCrewFull():Boolean
        {
            return Boolean(_getAttr("isCrewFull"));
        }

        public function get isAmmoFull():Boolean
        {
            return Boolean(_getAttr("isAmmoFull"));
        }

        public function get isFavorite():Boolean
        {
            return Boolean(_getAttr("isFavorite"));
        }

        public function get isPremium():Boolean
        {
            return Boolean(_getAttr("isPremium"));
        }

        public function get isLocked():Boolean
        {
            return Boolean(_getAttr("isLocked"));
        }

        public function get isInBattle():Boolean
        {
            return Boolean(_getAttr("isInBattle"));
        }

        public function get isBroken():Boolean
        {
            return Boolean(_getAttr("isBroken"));
        }

        public function get isAlive():Boolean
        {
            return Boolean(_getAttr("isAlive"));
        }

        public function get isInInventory():Boolean
        {
            return !(this.inventoryID == -1);
        }

        public function get type():String
        {
            return String(_getAttr("type"));
        }

        public function get typeIndex():int
        {
            return int(_getAttr("typeIndex"));
        }

        public function get nationIndex():int
        {
            return int(_getAttr("nationIndex"));
        }

        public function get smallIconPath():String
        {
            return "../maps/icons/vehicle/small/" + name.replace(":", "-") + ".png";
        }

        public function get repairCost():uint
        {
            return uint(_getAttr("repairCost"));
        }

        public function get health():uint
        {
            return uint(_getAttr("health"));
        }

        public function get gun():net.wg.data.gui_items.FittingItem
        {
            return new net.wg.data.gui_items.FittingItem(net.wg.data.constants.ItemTypes.GUN, uint(_getAttr("gun")));
        }

        public function get turret():net.wg.data.gui_items.FittingItem
        {
            return new net.wg.data.gui_items.FittingItem(net.wg.data.constants.ItemTypes.TURRET, uint(_getAttr("turret")));
        }

        public function get engine():net.wg.data.gui_items.FittingItem
        {
            return new net.wg.data.gui_items.FittingItem(net.wg.data.constants.ItemTypes.ENGINE, uint(_getAttr("engine")));
        }

        public function get chassis():net.wg.data.gui_items.FittingItem
        {
            return new net.wg.data.gui_items.FittingItem(net.wg.data.constants.ItemTypes.CHASSIS, uint(_getAttr("chassis")));
        }

        public function get radio():net.wg.data.gui_items.FittingItem
        {
            return new net.wg.data.gui_items.FittingItem(net.wg.data.constants.ItemTypes.RADIO, uint(_getAttr("radio")));
        }

        public function get optDevs():__AS3__.vec.Vector.<net.wg.data.gui_items.FittingItem>
        {
            return this._createModulesList(net.wg.data.constants.ItemTypes.OPT_DEVS, "optDevs");
        }

        public function get eqs():__AS3__.vec.Vector.<net.wg.data.gui_items.FittingItem>
        {
            return this._createModulesList(net.wg.data.constants.ItemTypes.EQUIPMENT, "equipment");
        }

        public function get shells():__AS3__.vec.Vector.<net.wg.data.gui_items.FittingItem>
        {
            return this._createModulesList(net.wg.data.constants.ItemTypes.SHELL, "shells");
        }

        public function get crew():__AS3__.vec.Vector.<net.wg.data.utilData.TankmanSlot>
        {
            var loc2:*=undefined;
            var loc3:*=null;
            var loc1:*=new Vector.<net.wg.data.utilData.TankmanSlot>();
            var loc4:*=0;
            var loc5:*=_getAttr("crew") as Array;
            for each (loc2 in loc5) 
            {
                loc3 = loc2 as Array;
                loc1.push(new net.wg.data.utilData.TankmanSlot(loc3[0], loc3[1]));
            }
            return loc1;
        }
    }
}
