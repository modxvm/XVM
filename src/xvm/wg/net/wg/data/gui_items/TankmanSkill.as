package net.wg.data.gui_items 
{
    import net.wg.data.constants.*;
    
    public class TankmanSkill extends net.wg.data.gui_items.GUIItem
    {
        public function TankmanSkill(arg1:String, arg2:int=-1)
        {
            super(net.wg.data.constants.ItemTypes.TANKMAN_SKILL, [arg1, arg2]);
            this._skillName = arg1;
            this._tankmanID = arg2;
            return;
        }

        public function get skillName():String
        {
            return this._skillName;
        }

        public function get tankmanID():int
        {
            return this._tankmanID;
        }

        public function get isPerk():Boolean
        {
            return Boolean(_getAttr("isPerk"));
        }

        public function get level():uint
        {
            return uint(_getAttr("level"));
        }

        public function get roleType():String
        {
            return String(_getAttr("roleType"));
        }

        public function get isActive():Boolean
        {
            return Boolean(_getAttr("isActive"));
        }

        public function get userName():String
        {
            return String(_getAttr("userName"));
        }

        public function get description():String
        {
            return String(_getAttr("description"));
        }

        public function get shortDescription():String
        {
            return String(_getAttr("shortDescription"));
        }

        public function get icon():String
        {
            return String(_getAttr("icon"));
        }

        internal var _skillName:String;

        internal var _tankmanID:int;
    }
}
