package scaleform.clik.utils 
{
    import flash.display.*;
    
    public class ConstrainedElement extends Object
    {
        public function ConstrainedElement(arg1:flash.display.DisplayObject, arg2:uint, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number)
        {
            super();
            this.clip = arg1;
            this.edges = arg2;
            this.left = arg3;
            this.top = arg4;
            this.right = arg5;
            this.bottom = arg6;
            this.scaleX = arg7;
            this.scaleY = arg8;
            return;
        }

        public function toString():String
        {
            return "[ConstrainedElement " + this.clip + ", edges=" + this.edges + ", left=" + this.left + ", right=" + this.right + ", top=" + this.top + ", bottom=" + this.bottom + ", scaleX=" + this.scaleX + ", scaleY=" + this.scaleY + "]";
        }

        public var clip:flash.display.DisplayObject;

        public var edges:uint;

        public var left:Number;

        public var top:Number;

        public var right:Number;

        public var bottom:Number;

        public var scaleX:Number;

        public var scaleY:Number;
    }
}
