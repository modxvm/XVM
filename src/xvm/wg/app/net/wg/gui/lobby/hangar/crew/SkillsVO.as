package net.wg.gui.lobby.hangar.crew 
{
    import net.wg.data.daapi.base.*;
    
    public class SkillsVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function SkillsVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get icon():String
        {
            return this._icon;
        }

        public function set icon(arg1:String):void
        {
            this._icon = arg1;
            return;
        }

        public function get name():String
        {
            return this._name;
        }

        public function set name(arg1:String):void
        {
            this._name = arg1;
            return;
        }

        public function get active():Boolean
        {
            return this._active;
        }

        public function set active(arg1:Boolean):void
        {
            this._active = arg1;
            return;
        }

        public function get selected():Boolean
        {
            return this._selected;
        }

        public function set selected(arg1:Boolean):void
        {
            this._selected = arg1;
            return;
        }

        public function get tankmanID():Number
        {
            return this._tankmanID;
        }

        public function set tankmanID(arg1:Number):void
        {
            this._tankmanID = arg1;
            return;
        }

        public function get buy():Boolean
        {
            return this._buy;
        }

        public function set buy(arg1:Boolean):void
        {
            this._buy = arg1;
            return;
        }

        public function get inprogress():Boolean
        {
            return this._inprogress;
        }

        public function set inprogress(arg1:Boolean):void
        {
            this._inprogress = arg1;
            return;
        }

        public function get desc():String
        {
            return this._desc;
        }

        public function set desc(arg1:String):void
        {
            this._desc = arg1;
            return;
        }

        public function get level():Number
        {
            return this._level;
        }

        public function set level(arg1:Number):void
        {
            this._level = arg1;
            return;
        }

        public function get id():String
        {
            return this._id;
        }

        public function set id(arg1:String):void
        {
            this._id = arg1;
            return;
        }

        internal var _icon:String="";

        internal var _inprogress:Boolean;

        internal var _name:String="";

        internal var _desc:String="";

        internal var _active:Boolean;

        internal var _selected:Boolean;

        internal var _tankmanID:Number;

        internal var _buy:Boolean;

        internal var _level:Number;

        internal var _id:String="";
    }
}
