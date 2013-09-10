package scaleform.clik.data 
{
    public class ListData extends Object
    {
        public function ListData(arg1:uint, arg2:String="Empty", arg3:Boolean=false)
        {
            super();
            this.index = arg1;
            this.label = arg2;
            this.selected = arg3;
            return;
        }

        public function toString():String
        {
            return "[ListData " + this.index + ", " + this.label + ", " + this.selected + "]";
        }

        public var index:uint=0;

        public var label:String="Empty";

        public var selected:Boolean=false;
    }
}
