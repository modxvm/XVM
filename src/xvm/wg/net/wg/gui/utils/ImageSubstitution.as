package net.wg.gui.utils 
{
    import flash.display.*;
    import flash.utils.*;
    
    public class ImageSubstitution extends Object
    {
        public function ImageSubstitution(arg1:String, arg2:String, arg3:Number=0, arg4:Number=16, arg5:Number=16, arg6:Boolean=false)
        {
            super();
            this.subString = arg1;
            this.source = arg2;
            this.baseLineY = arg3;
            this.width = arg4;
            this.height = arg5;
            if (arg6) 
            {
                this.loadImage();
            }
            return;
        }

        public function get valid():Boolean
        {
            return !(this.image == null);
        }

        public function loadImage():Boolean
        {
            var result:Boolean;
            var BitmapDataClass:Class;

            var loc1:*;
            BitmapDataClass = null;
            result = true;
            if (!(this.source == null) && this.source.length > 0) 
            {
                try 
                {
                    BitmapDataClass = flash.utils.getDefinitionByName(this.source) as Class;
                    this.image = new BitmapDataClass() as flash.display.BitmapData;
                }
                catch (error:ReferenceError)
                {
                    trace("<ReferenceError> " + error.message);
                    image = null;
                    result = false;
                }
            }
            return result;
        }

        public function toString():String
        {
            return "[ImageSubstitution subString=" + this.subString + " source=" + this.source + " image=" + this.image + " baseLineY=" + this.baseLineY + " width=" + this.width + " height=" + this.height + "]";
        }

        public var subString:String="";

        public var source:String="";

        public var image:flash.display.BitmapData=null;

        public var baseLineY:Number=0;

        public var width:Number=16;

        public var height:Number=16;
    }
}
