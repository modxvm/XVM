package net.wg.gui.components.common.markers 
{
    import flash.text.*;
    import scaleform.clik.core.*;
    
    public class DamageLabel extends scaleform.clik.core.UIComponent
    {
        public function DamageLabel()
        {
            super();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATE_COLOR)) 
                gotoAndStop(this._color);
            if (isInvalid(INVALIDATE_TEXT)) 
                this.label.text = this._text;
            return;
        }

        public function get color():String
        {
            return this._color;
        }

        public function set color(arg1:String):void
        {
            this._color = arg1;
            invalidate(INVALIDATE_COLOR);
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            this._text = arg1;
            invalidate(INVALIDATE_TEXT);
            return;
        }

        public function get textWidth():Number
        {
            return this.label.textWidth;
        }

        internal static const INVALIDATE_TEXT:String="invalidateText";

        internal static const INVALIDATE_COLOR:String="invalidateColor";

        public var label:flash.text.TextField;

        internal var _color:String;

        internal var _text:String;
    }
}
