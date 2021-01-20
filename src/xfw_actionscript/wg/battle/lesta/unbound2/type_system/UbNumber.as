package lesta.unbound2.type_system
{
    public class UbNumber extends Object
    {

        public var value:Number = 0.0;

        public var units:int;

        public function UbNumber()
        {
            this.units = UbUnits.NONE;
            super();
        }
    }
}
