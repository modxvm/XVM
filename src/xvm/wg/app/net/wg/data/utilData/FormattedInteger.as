package net.wg.data.utilData 
{
    import net.wg.infrastructure.interfaces.*;
    
    public class FormattedInteger extends Object implements net.wg.infrastructure.interfaces.IFormattedInt
    {
        public function FormattedInteger(arg1:Number, arg2:String)
        {
            super();
            this._value = arg1;
            this._delimitier = arg2;
            return;
        }

        public function get value():Number
        {
            return this._value;
        }

        public function get delimiter():String
        {
            return this._delimitier;
        }

        internal var _value:Number=0;

        internal var _delimitier:String=null;
    }
}
