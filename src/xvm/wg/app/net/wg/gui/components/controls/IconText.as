package net.wg.gui.components.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.utils.*;
    
    public class IconText extends scaleform.clik.core.UIComponent
    {
        public function IconText()
        {
            super();
            return;
        }

        public function get textColor():Number
        {
            return this._textColor;
        }

        public function set textColor(arg1:Number):void
        {
            if (this._textColor == arg1) 
            {
                return;
            }
            this._textColor = arg1;
            invalidate();
            return;
        }

        public function get toolTip():String
        {
            return this._toolTip;
        }

        protected function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            if (!enabled) 
            {
                return;
            }
            App.toolTipMgr.hide();
            return;
        }

        protected function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            if (!enabled) 
            {
                return;
            }
            if (this.toolTip) 
            {
                App.toolTipMgr.showComplex(this.toolTip);
            }
            return;
        }

        public function set xCorrect(arg1:Number):void
        {
            this._xCorrect = arg1;
            invalidate();
            return;
        }

        public function get xCorrect():Number
        {
            return this._xCorrect;
        }

        public function set toolTip(arg1:String):void
        {
            if (this._toolTip == arg1) 
            {
                return;
            }
            this._toolTip = arg1;
            invalidate();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            super.draw();
            constraints.update(_width, _height);
            constraints.update(_width, _height);
            if (this.textField) 
            {
                this._textFormat.color = this._textColor;
                this._textFormat.size = this._textSize;
                this._textFormat.font = this._textFont;
                this._textFormat.align = this._textAlign;
                this.textField.antiAliasType = this._antiAliasing;
                this.textField.height = _height;
                if (this._styleSheet) 
                {
                    this.textField.styleSheet = this._styleSheet;
                }
                this.textField.text = this.text;
                if (!this._styleSheet) 
                {
                    this.textField.setTextFormat(this._textFormat);
                }
                this.textField.y = this.textFieldYOffset;
                if (this.iconClip) 
                {
                    if (this._iconPosition != net.wg.data.constants.IconTextPosition.LEFT) 
                    {
                        this.textField.x = 0;
                    }
                    else 
                    {
                        this.textField.x = this.iconClip.width + this.xCorrect;
                    }
                    loc1 = Math.round(this.textField.width * scaleX);
                    if (this._fitIconPosition) 
                    {
                        loc1 = Math.min(this.textField.textWidth, loc1);
                    }
                    loc2 = 0;
                    if (this._iconPosition != net.wg.data.constants.IconTextPosition.LEFT) 
                    {
                        if (this._textAlign != flash.text.TextFormatAlign.RIGHT) 
                        {
                            if (this._textAlign != flash.text.TextFormatAlign.LEFT) 
                            {
                                loc2 = (_width + loc1 - this._iconWidth) / 2;
                            }
                            else 
                            {
                                loc2 = loc1;
                            }
                        }
                        else 
                        {
                            loc2 = _width - this._iconWidth;
                        }
                    }
                    else if (this._textAlign != flash.text.TextFormatAlign.LEFT) 
                    {
                        if (this._textAlign != flash.text.TextFormatAlign.RIGHT) 
                        {
                            loc2 = (_width - loc1 - this._iconWidth) / 2;
                        }
                        else 
                        {
                            loc2 = _width - loc1 - this._iconWidth;
                        }
                    }
                    else 
                    {
                        loc2 = 0;
                    }
                    this.iconClip.x = Math.round(loc2 * this.iconClip.scaleX);
                    this.iconClip.gotoAndStop(this._icon);
                    this.iconClip.visible = !(this._icon == "empty");
                }
                else 
                {
                    this.textField.x = 0;
                    this.textField.width = _width;
                }
            }
            this.alpha = enabled ? 1 : 0.3;
            return;
        }

        public function set css(arg1:flash.text.StyleSheet):void
        {
            this._styleSheet = arg1;
            invalidate();
            return;
        }

        public function get css():flash.text.StyleSheet
        {
            return this._styleSheet;
        }

        public function set textFieldYOffset(arg1:Number):void
        {
            if (arg1 == this._textFieldYOffset) 
            {
                return;
            }
            this._textFieldYOffset = arg1;
            invalidate();
            return;
        }

        public function get textFieldYOffset():Number
        {
            return this._textFieldYOffset;
        }

        public function set icon(arg1:String):void
        {
            if (this._icon == arg1) 
            {
                return;
            }
            this._icon = arg1;
            invalidate();
            return;
        }

        public function get icon():String
        {
            return this._icon;
        }

        public function set text(arg1:String):void
        {
            if (this._text == arg1) 
            {
                return;
            }
            this._text = arg1;
            if (!(this._text == "") && !(this._text == null) && !(this._text == null)) 
            {
                this.iconClip.visible = true;
            }
            invalidate();
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public override function dispose():void
        {
            super.dispose();
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.handleMouseRollOver);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.handleMouseRollOut);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this._textFormat = this.textField.getTextFormat();
            this._iconWidth = this.iconClip.width;
            this.iconClip.visible = false;
            useHandCursor = false;
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.COUNTER_SCALE);
            constraints.addElement("iconClip", this.iconClip, scaleform.clik.utils.Constraints.LEFT);
            constraints.addElement("textField", this.textField, scaleform.clik.utils.Constraints.ALL);
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.handleMouseRollOver, false, 0, true);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, this.handleMouseRollOut, false, 0, true);
            return;
        }

        public function get iconPosition():String
        {
            return this._iconPosition;
        }

        public function set iconPosition(arg1:String):void
        {
            if (this._iconPosition == arg1) 
            {
                return;
            }
            this._iconPosition = arg1;
            invalidate();
            return;
        }

        public function get antiAliasing():String
        {
            return this._antiAliasing;
        }

        public function set antiAliasing(arg1:String):void
        {
            if (this._antiAliasing == arg1) 
            {
                return;
            }
            this._antiAliasing = arg1;
            invalidate();
            return;
        }

        public function get fitIconPosition():Boolean
        {
            return this._fitIconPosition;
        }

        public function set fitIconPosition(arg1:Boolean):void
        {
            if (this._fitIconPosition == arg1) 
            {
                return;
            }
            this._fitIconPosition = arg1;
            invalidate();
            return;
        }

        public function get textAlign():String
        {
            return this._textAlign;
        }

        public function set textAlign(arg1:String):void
        {
            if (this._textAlign == arg1) 
            {
                return;
            }
            this._textAlign = arg1;
            invalidate();
            return;
        }

        public function get textFont():String
        {
            return this._textFont;
        }

        public function set textFont(arg1:String):void
        {
            if (this._textFont == arg1) 
            {
                return;
            }
            this._textFont = arg1;
            invalidate();
            return;
        }

        public function get textSize():Number
        {
            return this._textSize;
        }

        public function set textSize(arg1:Number):void
        {
            if (this._textSize == arg1) 
            {
                return;
            }
            this._textSize = arg1;
            invalidate();
            return;
        }

        public static const CLASS3:String="class3";

        public static const CLASS4:String="class4";

        public static const XP_PRICE:String="xp_price";

        public static const TANK_UNLOCK_PRICE:String="tank_unlock_price";

        public static const EMPTY:String="empty";

        public static const CREDITS:String="credits";

        public static const GOLD:String="gold";

        public static const GOLD_DISCOUNT:String="goldDiscount";

        public static const XP:String="xp";

        public static const ELITE_XP:String="eliteXp";

        public static const elite:String="elite";

        public static const ARROW_DOWN:String="arrowDown";

        public static const ARROW_UP:String="arrowUp";

        public static const ARROW_DOWN_DISABLED:String="arrowDownDisabled";

        public static const ELITE_TANK_XP:String="elite_tank_xp";

        public static const FREE_XP:String="freeXp";

        public static const TANK_DAILYXPFACTOR:String="tank_dailyXPFactor";

        public static const DOUBLE_XP_FACTOR:String="doubleXPFactor";

        public static const ACTION_XP_FACTOR:String="actionXPFactor";

        public static const VCOIN:String="vcoin";

        public static const CLASS1:String="class1";

        public static const CLASS2:String="class2";

        public var textField:flash.text.TextField;

        public var iconClip:flash.display.MovieClip;

        protected var _iconWidth:Number;

        protected var _textSize:Number=12;

        protected var _textAlign:String="left";

        protected var _textFormat:flash.text.TextFormat;

        protected var _fitIconPosition:Boolean=false;

        protected var _iconPosition:String="left";

        protected var _textFont:String="$TextFont";

        internal var _textFieldYOffset:Number=0;

        internal var _xCorrect:Number=0;

        protected var _styleSheet:flash.text.StyleSheet=null;

        protected var _antiAliasing:String="advanced";

        protected var _icon:String="";

        protected var _text:String="";

        protected var _toolTip:String="";

        protected var _textColor:Number=0;
    }
}
