package net.wg.data.utilData
{
    import net.wg.infrastructure.interfaces.IFormattedInt;
    
    public class FormattedInteger extends Object implements IFormattedInt
    {
        
        public function FormattedInteger(param1:Number, param2:String) {
            super();
            this._value = param1;
            this._delimitier = param2;
        }
        
        private var _value:Number = 0;
        
        private var _delimitier:String = null;
        
        public function get value() : Number {
            return this._value;
        }
        
        public function get delimiter() : String {
            return this._delimitier;
        }
    }
}
