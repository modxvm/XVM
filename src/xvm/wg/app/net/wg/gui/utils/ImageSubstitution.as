package net.wg.gui.utils
{
    import flash.display.BitmapData;
    import flash.utils.getDefinitionByName;
    
    public class ImageSubstitution extends Object
    {
        
        public function ImageSubstitution(param1:String, param2:String, param3:Number = 0, param4:Number = 16, param5:Number = 16, param6:Boolean = false) {
            super();
            this.subString = param1;
            this.source = param2;
            this.baseLineY = param3;
            this.width = param4;
            this.height = param5;
            if(param6)
            {
                this.loadImage();
            }
        }
        
        public var subString:String = "";
        
        public var source:String = "";
        
        public var image:BitmapData = null;
        
        public var baseLineY:Number = 0;
        
        public var width:Number = 16;
        
        public var height:Number = 16;
        
        public function get valid() : Boolean {
            return !(this.image == null);
        }
        
        public function loadImage() : Boolean {
            var BitmapDataClass:Class = null;
            var result:Boolean = true;
            if(!(this.source == null) && this.source.length > 0)
            {
                try
                {
                    BitmapDataClass = getDefinitionByName(this.source) as Class;
                    this.image = new BitmapDataClass() as BitmapData;
                }
                catch(error:ReferenceError)
                {
                    image = null;
                    result = false;
                }
            }
            return result;
        }
        
        public function toString() : String {
            return "[ImageSubstitution subString=" + this.subString + " source=" + this.source + " image=" + this.image + " baseLineY=" + this.baseLineY + " width=" + this.width + " height=" + this.height + "]";
        }
    }
}
