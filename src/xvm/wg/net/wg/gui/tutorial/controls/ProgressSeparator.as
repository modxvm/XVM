package net.wg.gui.tutorial.controls 
{
    import flash.display.*;
    import flash.text.*;
    
    public class ProgressSeparator extends flash.display.MovieClip
    {
        public function ProgressSeparator()
        {
            super();
            return;
        }

        public function get label():flash.text.TextField
        {
            return this.labelMc.getChildByName("label") as flash.text.TextField;
        }

        public function setup(arg1:int, arg2:Number):void
        {
            this.label.text = String(arg1 + 1);
            this.labelMc.x = arg2 - this.label.textWidth >> 1;
            if (arg1 == 0) 
            {
                this.marker.visible = false;
            }
            return;
        }

        public var labelMc:flash.display.MovieClip;

        public var marker:flash.display.Sprite;
    }
}
