package net.wg.data.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class AchievementItemVO extends DAAPIDataClass
    {
        
        public function AchievementItemVO(param1:Object)
        {
            super(param1);
        }
        
        private var _name:String = "";
        
        private var _block:String = "";
        
        private var _section:String = "";
        
        private var _type:String = "";
        
        private var _isInDossier:Boolean = false;
        
        private var _localizedValue:String = "0";
        
        private var _icon:Object;
        
        private var _value:Number = -1;
        
        public var iconAlpha:Number;
        
        public var dossierType:int;
        
        public var dossierCompDescr:String = "";
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == "icon")
            {
                this._icon = new IconVO(param2);
                return false;
            }
            return this.hasOwnProperty(param1);
        }
        
        public function get localizedValue() : String
        {
            return this._localizedValue;
        }
        
        public function set localizedValue(param1:String) : void
        {
            this._localizedValue = param1;
        }
        
        public function get block() : String
        {
            return this._block;
        }
        
        public function set block(param1:String) : void
        {
            this._block = param1;
        }
        
        public function get name() : String
        {
            return this._name;
        }
        
        public function set name(param1:String) : void
        {
            this._name = param1;
        }
        
        public function get section() : String
        {
            return this._section;
        }
        
        public function set section(param1:String) : void
        {
            this._section = param1;
        }
        
        public function get icon() : Object
        {
            return this._icon;
        }
        
        public function set icon(param1:Object) : void
        {
            this._icon = param1;
        }
        
        public function get type() : String
        {
            return this._type;
        }
        
        public function set type(param1:String) : void
        {
            this._type = param1;
        }
        
        public function get isInDossier() : Boolean
        {
            return this._isInDossier;
        }
        
        public function set isInDossier(param1:Boolean) : void
        {
            this._isInDossier = param1;
        }
        
        public function get value() : int
        {
            return this._value;
        }
        
        public function set value(param1:int) : void
        {
            this._value = param1;
        }
    }
}
