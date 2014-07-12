package net.wg.gui.lobby.techtree.data.vo
{
    import net.wg.gui.lobby.techtree.interfaces.IValueObject;
    import net.wg.utils.ILocale;
    
    public class PrimaryClass extends Object implements IValueObject
    {
        
        public function PrimaryClass(param1:String = "", param2:String = "") {
            super();
            this._name = param1;
            this._userString = param2;
        }
        
        private var _name:String;
        
        private var _userString:String;
        
        public function get name() : String {
            return this._name;
        }
        
        public function get userString() : String {
            return this._userString;
        }
        
        public function fromArray(param1:Array, param2:ILocale) : void {
            if(param1.length > 1)
            {
                this._name = param1[0];
                this._userString = param1[1];
            }
        }
        
        public function fromObject(param1:Object, param2:ILocale) : void {
            if(param1 == null)
            {
                return;
            }
            if(param1.name != null)
            {
                this._name = param1.name;
            }
            if(param1.userString != null)
            {
                this._userString = param1.userString;
            }
        }
        
        public function toString() : String {
            return "[PrimaryClass: name = " + this._name + ", userString = " + this._userString + " ]";
        }
    }
}
