package net.wg.data.gui_items 
{
    import net.wg.data.utilData.*;
    
    public class FittingItem extends net.wg.data.gui_items.GUIItem
    {
        public function FittingItem(arg1:uint, arg2:uint)
        {
            super(arg1, arg2);
            return;
        }

        public function get buyPrice():net.wg.data.utilData.ItemPrice
        {
            var loc1:*=_getAttr("buyPrice") as Array;
            return new net.wg.data.utilData.ItemPrice(loc1[0], loc1[1]);
        }

        public function get sellPrice():net.wg.data.utilData.ItemPrice
        {
            var loc1:*=_getAttr("sellPrice") as Array;
            return new net.wg.data.utilData.ItemPrice(loc1[0], loc1[1]);
        }

        public function get actionPrice():net.wg.data.utilData.ItemPrice
        {
            var loc1:*=_getAttr("actionPrice") as Array;
            return new net.wg.data.utilData.ItemPrice(loc1[0], loc1[1]);
        }

        public function get isHidden():Boolean
        {
            return Boolean(_getAttr("isHidden"));
        }

        public function get inventoryCount():uint
        {
            return uint(_getAttr("inventoryCount"));
        }

        public function get nationID():int
        {
            return uint(_getAttr("nationID"));
        }

        public function get isRemovable():Boolean
        {
            return Boolean(_getAttr("isRemovable"));
        }

        public function get name():String
        {
            return String(_getAttr("name"));
        }

        public function get userType():String
        {
            return String(_getAttr("userType"));
        }

        public function get userName():String
        {
            return String(_getAttr("userName"));
        }

        public function get longUserName():String
        {
            return String(_getAttr("longUserName"));
        }

        public function get shortUserName():String
        {
            return String(_getAttr("shortUserName"));
        }

        public function get description():String
        {
            return String(_getAttr("fullDescription"));
        }

        public function get shortDescription():String
        {
            return String(_getAttr("shortDescription"));
        }

        public function get icon():String
        {
            return String(_getAttr("icon"));
        }

        public function get level():uint
        {
            return uint(_getAttr("level"));
        }
    }
}
