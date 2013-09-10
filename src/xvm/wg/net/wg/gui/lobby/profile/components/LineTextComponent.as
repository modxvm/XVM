package net.wg.gui.lobby.profile.components 
{
    import flash.display.*;
    import flash.text.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    
    public class LineTextComponent extends scaleform.clik.core.UIComponent
    {
        public function LineTextComponent()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            super.draw();
            if (isInvalid(TEXT_INV)) 
            {
                this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
                this.textField.text = this._text;
                invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                loc1 = _width - this.textField.width >> 1;
                var loc2:*;
                this.rightLine.width = loc2 = Math.round(loc1);
                this.leftLine.width = loc2;
                this.textField.x = loc1;
                this.rightLine.x = _width - loc1;
            }
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            this._text = arg1;
            invalidate(TEXT_INV);
            return;
        }

        internal static const TEXT_INV:String="textInv";

        public var leftLine:flash.display.MovieClip;

        public var rightLine:flash.display.MovieClip;

        public var textField:flash.text.TextField;

        internal var _text:String="";
    }
}
