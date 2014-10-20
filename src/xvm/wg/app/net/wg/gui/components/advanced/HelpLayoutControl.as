package net.wg.gui.components.advanced
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.IDynamicContent;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import scaleform.clik.utils.Padding;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.geom.Rectangle;
    import net.wg.data.constants.Directions;
    import flash.text.TextFieldAutoSize;
    
    public class HelpLayoutControl extends UIComponent implements IDynamicContent, IDisposable
    {
        
        public function HelpLayoutControl()
        {
            super();
            this.visible = false;
        }
        
        public static var shadowPaddingOutside:Padding = new Padding(22,22,22,22);
        
        public var textField:TextField;
        
        public var border:MovieClip;
        
        private var _text:String = "";
        
        private var _extensibilityDirection:String = "T";
        
        private var _rect:Rectangle = null;
        
        private var INSIDE_PADDING:Number = 6;
        
        override protected function onDispose() : void
        {
            this.textField = null;
            this.border = null;
            super.onDispose();
        }
        
        public function set rect(param1:Rectangle) : void
        {
            this._rect = param1;
        }
        
        public function set extensibilityDirection(param1:String) : void
        {
            App.utils.asserter.assert(!(Directions.LAYOUT_DIRECTIONS.indexOf(param1) == -1),"invalid direction: " + param1);
            this._extensibilityDirection = param1;
        }
        
        public function set text(param1:String) : void
        {
            this._text = param1;
        }
        
        override protected function draw() : void
        {
            super.draw();
            scaleX = scaleY = 1;
            this.invalidPosition();
            super.draw();
            this.visible = true;
        }
        
        private function invalidPosition() : void
        {
            if(this.textField == null)
            {
                return;
            }
            this.textField.wordWrap = true;
            this.textField.autoSize = TextFieldAutoSize.CENTER;
            this.textField.text = this._text;
            var _loc1_:Number = this.textField.textWidth + this.INSIDE_PADDING * 2;
            var _loc2_:Number = this.textField.textHeight + this.INSIDE_PADDING * 2;
            var _loc3_:Number = Math.max(this._rect.width,_loc1_) ^ 0;
            var _loc4_:Number = Math.max(this._rect.height,_loc2_) ^ 0;
            this.border.width = _loc3_ + shadowPaddingOutside.horizontal;
            this.border.height = _loc4_ + shadowPaddingOutside.vertical;
            var _loc5_:Number = 0;
            var _loc6_:Number = 0;
            switch(this._extensibilityDirection)
            {
                case "T":
                    if(_loc4_ > this._rect.height)
                    {
                        _loc6_ = this._rect.height - _loc4_ ^ 0;
                    }
                    break;
                case "R":
                    break;
                case "B":
                    break;
                case "L":
                    if(_loc3_ > this._rect.width)
                    {
                        _loc5_ = this._rect.width - _loc3_ ^ 0;
                    }
                    break;
            }
            this.border.x = _loc5_ - shadowPaddingOutside.left;
            this.border.y = _loc6_ - shadowPaddingOutside.top;
            this.textField.x = this.border.x + (this.border.width - this.textField.width >> 1);
            this.textField.y = this.border.y + (this.border.height - this.textField.height >> 1);
        }
    }
}
