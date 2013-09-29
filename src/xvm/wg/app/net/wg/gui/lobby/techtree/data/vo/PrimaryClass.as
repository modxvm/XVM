package net.wg.gui.lobby.techtree.data.vo 
{
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.utils.*;
    
    public class PrimaryClass extends Object implements net.wg.gui.lobby.techtree.interfaces.IValueObject
    {
        public function PrimaryClass(arg1:String="", arg2:String="")
        {
            super();
            this._name = arg1;
            this._userString = arg2;
            return;
        }

        public function get name():String
        {
            return this._name;
        }

        public function get userString():String
        {
            return this._userString;
        }

        public function fromArray(arg1:Array, arg2:net.wg.utils.ILocale):void
        {
            if (arg1.length > 1) 
            {
                this._name = arg1[0];
                this._userString = arg1[1];
            }
            return;
        }

        public function fromObject(arg1:Object, arg2:net.wg.utils.ILocale):void
        {
            if (arg1 == null) 
            {
                return;
            }
            if (arg1.name != null) 
            {
                this._name = arg1.name;
            }
            if (arg1.userString != null) 
            {
                this._userString = arg1.userString;
            }
            return;
        }

        public function toString():String
        {
            return "[PrimaryClass: name = " + this._name + ", userString = " + this._userString + " ]";
        }

        internal var _name:String;

        internal var _userString:String;
    }
}
