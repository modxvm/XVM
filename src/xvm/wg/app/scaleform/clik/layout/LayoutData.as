package scaleform.clik.layout 
{
    import flash.utils.*;
    
    public class LayoutData extends Object
    {
        public function LayoutData(arg1:String="none", arg2:String="none", arg3:int=-1, arg4:int=-1, arg5:String=null, arg6:String=null, arg7:int=-1, arg8:String=null)
        {
            super();
            this.alignH = arg1;
            this.alignV = arg2;
            this.offsetH = arg3;
            this.offsetV = arg4;
            this.relativeToH = arg5;
            this.relativeToV = arg6;
            this.layoutIndex = arg7;
            this.layoutIdentifier = arg8;
            this.offsetHashH = new flash.utils.Dictionary();
            this.offsetHashV = new flash.utils.Dictionary();
            return;
        }

        public function toString():String
        {
            return "[LayoutData, h: " + this.alignH + ", v: " + this.alignV + ", oh: " + this.offsetH + ", ov: " + this.offsetV + ", relh: " + this.relativeToH + ", relv: " + this.relativeToV + ", idx: " + this.layoutIndex + "]";
        }

        public static const ASPECT_RATIO_4_3:String="4:3";

        public static const ASPECT_RATIO_16_9:String="16:9";

        public static const ASPECT_RATIO_16_10:String="16:10";

        public var alignH:String=null;

        public var alignV:String=null;

        public var offsetH:int=-1;

        public var offsetV:int=-1;

        public var offsetHashH:flash.utils.Dictionary=null;

        public var offsetHashV:flash.utils.Dictionary=null;

        public var relativeToH:String=null;

        public var relativeToV:String=null;

        public var layoutIndex:int=-1;

        public var layoutIdentifier:String=null;
    }
}
