package net.wg.data.VO 
{
    import net.wg.data.daapi.base.*;
    
    public class AchievementItemVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function AchievementItemVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        protected override function onDataWrite(arg1:String, arg2:Object):Boolean
        {
            if (arg1 == "icon") 
            {
                this._icon = new net.wg.data.VO.IconVO(arg2);
                return false;
            }
            return this.hasOwnProperty(arg1);
        }

        public function get showSeparator():Boolean
        {
            return this._showSeparator;
        }

        public function set showSeparator(arg1:Boolean):void
        {
            this._showSeparator = arg1;
            return;
        }

        public function get icon():Object
        {
            return this._icon;
        }

        public function set icon(arg1:Object):void
        {
            this._icon = arg1;
            return;
        }

        public function get description():String
        {
            return this._description;
        }

        public function set description(arg1:String):void
        {
            this._description = arg1;
            return;
        }

        public function get isActive():Boolean
        {
            return this._isActive;
        }

        public function set isActive(arg1:Boolean):void
        {
            this._isActive = arg1;
            return;
        }

        public function get levelUpValue():String
        {
            return this._levelUpValue;
        }

        public function set levelUpValue(arg1:String):void
        {
            this._levelUpValue = arg1;
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

        public function get section():String
        {
            return this._section;
        }

        public function set section(arg1:String):void
        {
            this._section = arg1;
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            this._type = arg1;
            return;
        }

        public function get userName():String
        {
            return this._userName;
        }

        public function set userName(arg1:String):void
        {
            this._userName = arg1;
            return;
        }

        public function get value():int
        {
            return this._value;
        }

        public function set value(arg1:int):void
        {
            this._value = arg1;
            return;
        }

        internal var _description:String="";

        internal var _isActive:Boolean=false;

        internal var _levelUpValue:String="";

        internal var _name:String="";

        internal var _section:String="";

        internal var _type:String="";

        internal var _userName:String="";

        internal var _value:Number=-1;

        internal var _icon:Object;

        internal var _showSeparator:Boolean=false;
    }
}
