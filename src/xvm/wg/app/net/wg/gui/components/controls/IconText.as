package net.wg.gui.components.controls
{
    import scaleform.clik.core.UIComponent;
    import net.wg.infrastructure.interfaces.ITextContainer;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.text.TextFormat;
    import flash.text.StyleSheet;
    import flash.events.MouseEvent;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import net.wg.data.constants.IconTextPosition;
    import flash.text.TextFormatAlign;
    
    public class IconText extends UIComponent implements ITextContainer
    {
        
        public function IconText() {
            super();
        }
        
        public var textField:TextField;
        
        public var iconClip:MovieClip;
        
        protected var _iconWidth:Number;
        
        protected var _iconPosition:String = "left";
        
        protected var _fitIconPosition:Boolean = false;
        
        protected var _textFormat:TextFormat;
        
        protected var _textAlign:String = "left";
        
        protected var _textFont:String = "$TextFont";
        
        protected var _textSize:Number = 12;
        
        protected var _textColor:Number = 0;
        
        protected var _toolTip:String = "";
        
        protected var _text:String = "";
        
        protected var _icon:String = "";
        
        protected var _antiAliasing:String = "advanced";
        
        protected var _styleSheet:StyleSheet = null;
        
        private var _xCorrect:Number = 0;
        
        private var _enabledTooltip:Boolean = true;
        
        private var _textFieldYOffset:Number = 0;
        
        override protected function onDispose() : void {
            super.onDispose();
            removeEventListener(MouseEvent.ROLL_OVER,this.handleMouseRollOver);
            removeEventListener(MouseEvent.ROLL_OUT,this.handleMouseRollOut);
        }
        
        public function get iconPosition() : String {
            return this._iconPosition;
        }
        
        public function set iconPosition(param1:String) : void {
            if(this._iconPosition == param1)
            {
                return;
            }
            this._iconPosition = param1;
            invalidate();
        }
        
        public function get antiAliasing() : String {
            return this._antiAliasing;
        }
        
        public function set antiAliasing(param1:String) : void {
            if(this._antiAliasing == param1)
            {
                return;
            }
            this._antiAliasing = param1;
            invalidate();
        }
        
        public function get fitIconPosition() : Boolean {
            return this._fitIconPosition;
        }
        
        public function set fitIconPosition(param1:Boolean) : void {
            if(this._fitIconPosition == param1)
            {
                return;
            }
            this._fitIconPosition = param1;
            invalidate();
        }
        
        public function get textAlign() : String {
            return this._textAlign;
        }
        
        public function set textAlign(param1:String) : void {
            if(this._textAlign == param1)
            {
                return;
            }
            this._textAlign = param1;
            invalidate();
        }
        
        public function get textFont() : String {
            return this._textFont;
        }
        
        public function set textFont(param1:String) : void {
            if(this._textFont == param1)
            {
                return;
            }
            this._textFont = param1;
            invalidate();
        }
        
        public function get textSize() : Number {
            return this._textSize;
        }
        
        public function set textSize(param1:Number) : void {
            if(this._textSize == param1)
            {
                return;
            }
            this._textSize = param1;
            invalidate();
        }
        
        public function get textColor() : Number {
            return this._textColor;
        }
        
        public function set textColor(param1:Number) : void {
            if(this._textColor == param1)
            {
                return;
            }
            this._textColor = param1;
            invalidate();
        }
        
        public function get toolTip() : String {
            return this._toolTip;
        }
        
        public function set toolTip(param1:String) : void {
            if(this._toolTip == param1)
            {
                return;
            }
            this._toolTip = param1;
            invalidate();
        }
        
        public function get text() : String {
            return this._text;
        }
        
        public function set text(param1:String) : void {
            if(this._text == param1)
            {
                return;
            }
            this._text = param1;
            if(!(this._text == "") && !(this._text == null) && !(this._text == null))
            {
                this.iconClip.visible = true;
            }
            invalidate();
        }
        
        public function get icon() : String {
            return this._icon;
        }
        
        public function set icon(param1:String) : void {
            if(this._icon == param1)
            {
                return;
            }
            this._icon = param1;
            invalidate();
        }
        
        public function get enabledTooltip() : Boolean {
            return this._enabledTooltip;
        }
        
        public function set enabledTooltip(param1:Boolean) : void {
            if(param1 == this._enabledTooltip)
            {
                return;
            }
            this._enabledTooltip = param1;
        }
        
        public function get textFieldYOffset() : Number {
            return this._textFieldYOffset;
        }
        
        public function set textFieldYOffset(param1:Number) : void {
            if(param1 == this._textFieldYOffset)
            {
                return;
            }
            this._textFieldYOffset = param1;
            invalidate();
        }
        
        public function get css() : StyleSheet {
            return this._styleSheet;
        }
        
        public function set css(param1:StyleSheet) : void {
            this._styleSheet = param1;
            invalidate();
        }
        
        public function get xCorrect() : Number {
            return this._xCorrect;
        }
        
        public function set xCorrect(param1:Number) : void {
            this._xCorrect = param1;
            invalidate();
        }
        
        override protected function configUI() : void {
            super.configUI();
            this._textFormat = this.textField.getTextFormat();
            this._iconWidth = this.iconClip.width;
            this.iconClip.visible = false;
            useHandCursor = false;
            constraints = new Constraints(this,ConstrainMode.COUNTER_SCALE);
            constraints.addElement("iconClip",this.iconClip,Constraints.LEFT);
            constraints.addElement("textField",this.textField,Constraints.ALL);
            addEventListener(MouseEvent.ROLL_OVER,this.handleMouseRollOver,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.handleMouseRollOut,false,0,true);
        }
        
        override protected function draw() : void {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            super.draw();
            constraints.update(_width,_height);
            constraints.update(_width,_height);
            if(this.textField)
            {
                this._textFormat.color = this._textColor;
                this._textFormat.size = this._textSize;
                this._textFormat.font = this._textFont;
                this._textFormat.align = this._textAlign;
                this.textField.antiAliasType = this._antiAliasing;
                this.textField.height = _height;
                if(this._styleSheet)
                {
                    this.textField.styleSheet = this._styleSheet;
                }
                this.textField.text = this.text;
                if(!this._styleSheet)
                {
                    this.textField.setTextFormat(this._textFormat);
                }
                this.textField.y = this.textFieldYOffset;
                if(this.iconClip)
                {
                    if(this._iconPosition == IconTextPosition.LEFT)
                    {
                        this.textField.x = this.iconClip.width + this.xCorrect;
                    }
                    else
                    {
                        this.textField.x = 0;
                    }
                    _loc1_ = Math.round(this.textField.width * scaleX);
                    if(this._fitIconPosition)
                    {
                        _loc1_ = Math.min(this.textField.textWidth,_loc1_);
                    }
                    _loc2_ = 0;
                    if(this._iconPosition == IconTextPosition.LEFT)
                    {
                        if(this._textAlign == TextFormatAlign.LEFT)
                        {
                            _loc2_ = 0;
                        }
                        else if(this._textAlign == TextFormatAlign.RIGHT)
                        {
                            _loc2_ = _width - _loc1_ - this._iconWidth;
                        }
                        else
                        {
                            _loc2_ = (_width - _loc1_ - this._iconWidth) / 2;
                        }
                        
                    }
                    else if(this._textAlign == TextFormatAlign.RIGHT)
                    {
                        _loc2_ = _width - this._iconWidth;
                    }
                    else if(this._textAlign == TextFormatAlign.LEFT)
                    {
                        _loc2_ = _loc1_;
                    }
                    else
                    {
                        _loc2_ = (_width + _loc1_ - this._iconWidth) / 2;
                    }
                    
                    
                    this.iconClip.x = Math.round(_loc2_ * this.iconClip.scaleX);
                    this.iconClip.gotoAndStop(this._icon);
                    this.iconClip.visible = !(this._icon == "empty");
                }
                else
                {
                    this.textField.x = 0;
                    this.textField.width = _width;
                }
            }
            this.alpha = enabled?1:0.3;
        }
        
        protected function handleMouseRollOver(param1:MouseEvent) : void {
            if(!enabled)
            {
                return;
            }
            if((this.toolTip) && (this._enabledTooltip))
            {
                App.toolTipMgr.showComplex(this.toolTip);
            }
        }
        
        protected function handleMouseRollOut(param1:MouseEvent) : void {
            if(!enabled)
            {
                return;
            }
            if(this._enabledTooltip)
            {
                App.toolTipMgr.hide();
            }
        }
    }
}
