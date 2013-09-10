package scaleform.clik.ui 
{
    public class InputDetails extends Object
    {
        public function InputDetails(arg1:String, arg2:Number, arg3:*, arg4:String=null, arg5:uint=0, arg6:Boolean=false, arg7:Boolean=false, arg8:Boolean=false)
        {
            super();
            this.type = arg1;
            this.code = arg2;
            this.value = arg3;
            this.navEquivalent = arg4;
            this.controllerIndex = arg5;
            this.ctrlKey = arg6;
            this.altKey = arg7;
            this.shiftKey = arg8;
            return;
        }

        public function toString():String
        {
            return "[InputDetails code=" + this.code + ", type=" + this.type + " value=" + this.value + ", navEquivalent=" + this.navEquivalent + ", controllerIndex=" + this.controllerIndex + ", ctrlKey=" + this.ctrlKey + ", altKey=" + this.altKey + ", shiftKey=" + this.shiftKey + "]";
        }

        public var type:String;

        public var code:Number;

        public var value:*;

        public var navEquivalent:String;

        public var controllerIndex:uint;

        public var ctrlKey:Boolean;

        public var altKey:Boolean;

        public var shiftKey:Boolean;
    }
}
