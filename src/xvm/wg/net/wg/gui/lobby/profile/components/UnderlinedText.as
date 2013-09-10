package net.wg.gui.lobby.profile.components 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    
    public class UnderlinedText extends flash.display.Sprite
    {
        public function UnderlinedText()
        {
            super();
            this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.bgOriginalWidth = this.background.width;
            this.layoutBg();
            return;
        }

        public function set text(arg1:String):void
        {
            this.textField.htmlText = arg1;
            this.layoutBg();
            return;
        }

        internal function layoutBg():void
        {
            this.background.width = Math.max(this.textField.x + this.textField.width, this.bgOriginalWidth);
            dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE, true));
            return;
        }

        public function set fontSize(arg1:uint):void
        {
            var loc1:*=this.textField.getTextFormat();
            loc1.size = arg1;
            this.textField.setTextFormat(loc1);
            this.textField.defaultTextFormat = loc1;
            return;
        }

        public var textField:flash.text.TextField;

        public var background:flash.display.Sprite;

        internal var bgOriginalWidth:Number;
    }
}
