package net.wg.gui.lobby.demonstration.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class MapItemVO extends DAAPIDataClass
    {
        
        public function MapItemVO(param1:Object) {
            super(param1);
        }
        
        private var _id:Number = NaN;
        
        private var _name:String = "";
        
        private var _type:String = "";
        
        public function get id() : Number {
            return this._id;
        }
        
        public function set id(param1:Number) : void {
            this._id = param1;
        }
        
        public function get name() : String {
            return this._name;
        }
        
        public function set name(param1:String) : void {
            this._name = param1;
        }
        
        public function get type() : String {
            return this._type;
        }
        
        public function set type(param1:String) : void {
            this._type = param1;
        }
    }
}
