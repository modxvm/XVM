package net.wg.gui.components.common.markers
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    
    public class DamageLabel extends UIComponent
    {
        
        public function DamageLabel() {
            super();
        }
        
        private static var INVALIDATE_TEXT:String = "invalidateText";
        
        private static var INVALIDATE_COLOR:String = "invalidateColor";
        
        public var label:TextField;
        
        private var _color:String;
        
        private var _text:String;
        
        override protected function draw() : void {
            super.draw();
            if(isInvalid(INVALIDATE_COLOR))
            {
                gotoAndStop(this._color);
            }
            if(isInvalid(INVALIDATE_TEXT))
            {
                this.label.text = this._text;
            }
        }
        
        public function get color() : String {
            return this._color;
        }
        
        public function set color(param1:String) : void {
            this._color = param1;
            invalidate(INVALIDATE_COLOR);
        }
        
        public function get text() : String {
            return this._text;
        }
        
        public function set text(param1:String) : void {
            this._text = param1;
            invalidate(INVALIDATE_TEXT);
        }
        
        public function get textWidth() : Number {
            return this.label.textWidth;
        }
    }
}
