package net.wg.gui.components.advanced 
{
    import fl.motion.easing.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    import scaleform.clik.motion.*;
    
    public class CounterEx extends scaleform.clik.core.UIComponent
    {
        public function CounterEx()
        {
            this.tfMetrics = {};
            super();
            return;
        }

        public function get color():Number
        {
            return this._color;
        }

        public function set color(arg1:Number):void
        {
            if (arg1 == this._color) 
                return;
            this._color = arg1;
            this.startAnim();
            return;
        }

        public function get letterSpacing():Number
        {
            return this._letterSpacing;
        }

        public function set letterSpacing(arg1:Number):void
        {
            if (arg1 == this._letterSpacing) 
                return;
            this._letterSpacing = arg1;
            this.startAnim();
            return;
        }

        public function get speed():Number
        {
            return this._speed;
        }

        public function set number(arg1:Number):void
        {
            if (arg1 == this._number) 
                return;
            this._number = arg1;
            this.startAnim();
            return;
        }

        public function set speed(arg1:Number):void
        {
            if (arg1 == this._speed) 
                return;
            this._speed = arg1;
            this.startAnim();
            return;
        }

        public function get font():String
        {
            return this._font;
        }

        public function set font(arg1:String):void
        {
            if (arg1 == this._font) 
                return;
            this._font = arg1;
            this.startAnim();
            return;
        }

        public function get localizationSymbol():String
        {
            return this._localizationSymbol;
        }

        public function set localizationSymbol(arg1:String):void
        {
            if (arg1 == this._localizationSymbol) 
                return;
            this._localizationSymbol = arg1;
            return;
        }

        internal function areSpaces(arg1:String):Boolean
        {
            var loc1:*=true;
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                if (arg1.slice(loc2, loc2 + 1) != " ") 
                {
                    loc1 = false;
                    break;
                }
                ++loc2;
            }
            return loc1;
        }

        public function get metricsWidth():Number
        {
            return this.realMetricsWidth;
        }

        public function get formattedNumber():String
        {
            return this._formattedNumber;
        }

        public function set formattedNumber(arg1:String):void
        {
            this._formattedNumber = arg1;
            return;
        }

        internal function startAnim():void
        {
            if (this.number > -1 && !(this.font == "") && this.size > 0 && this.color && this.speed > 0) 
            {
                this.checkTruePosition = [];
                this.tFormat = this.tempTF.getTextFormat();
                this.tFormat.color = this.color;
                this.tFormat.size = this.size;
                this.tFormat.font = this.font;
                this.tFormat.letterSpacing = this.letterSpacing;
                this.tFormat.align = "left";
                this.tempTF.autoSize = "left";
                this.tempTF.text = this.formattedNumber.length > 0 ? this.formattedNumber : "0";
                this.tempTF.setTextFormat(this.tFormat);
                this.tFormat = this.tempTF.getTextFormat(0, 1);
                this.realMetricsWidth = this.tempTF.getLineMetrics(0).width;
                this.tfMetrics.lines = String(this.number).length;
                this.tempTF.text = "";
                this.tempTF.visible = false;
                this.clearLines();
                this.createLines();
                this.animate();
            }
            return;
        }

        internal function clearLines():void
        {
            if (this.tween) 
            {
                this.tween.paused = true;
                this.tween = null;
            }
            while (this.contener_mc.numChildren > 0) 
                this.contener_mc.removeChildAt(0);
            if (this.lines) 
                this.lines = this.lines.splice(0, this.lines.length);
            else 
                this.lines = [];
            return;
        }

        internal function animate():void
        {
            var loc1:*=0;
            if (this.playAnim) 
                this.tween = new scaleform.clik.motion.Tween(this.speed, this, {"tweenNum":this.number}, {"paused":false, "ease":fl.motion.easing.Cubic.easeOut, "onComplete":null});
            else 
            {
                loc1 = 0;
                while (loc1 < this.lines.length) 
                {
                    this.checkTruePosition[loc1].stand = true;
                    this.lines[loc1].gotoAndStop(this.checkTruePosition[loc1].num);
                    ++loc1;
                }
            }
            return;
        }

        internal function setLinesPosition(arg1:Number):void
        {
            var loc1:*=0;
            while (loc1 < this.lines.length) 
            {
                if (!this.checkTruePosition[loc1].stand && this.checkTruePosition[loc1 + 1].stand && this.lines[loc1].currentFrame + START_FRAME > this.checkTruePosition[loc1].num || arg1 == this.number) 
                {
                    this.checkTruePosition[loc1].stand = true;
                    this.lines[loc1].gotoAndStop(this.checkTruePosition[loc1].num);
                }
                else if (!this.checkTruePosition[loc1].stand) 
                    this.lines[loc1].gotoAndStop(Math.floor(START_FRAME + ANIMATE_STEP_FRAMES * arg1 / Math.pow(10, loc1) % 10));
                ++loc1;
            }
            return;
        }

        public function get tweenNum():Number
        {
            return this._tweenNum;
        }

        public function set tweenNum(arg1:Number):void
        {
            if (this._tweenNum == arg1) 
                return;
            this._tweenNum = arg1;
            this.setLinesPosition(this._tweenNum);
            return;
        }

        public function get expectedWidth():Number
        {
            return this._expectedWidth;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.tempTF.visible = false;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.clearLines();
            this.tFormat = null;
            this.tfMetrics = null;
            this.tween = null;
            if (this.checkTruePosition) 
                this.checkTruePosition = this.checkTruePosition.splice(0, this.checkTruePosition.length);
            return;
        }

        public function get number():Number
        {
            return this._number;
        }

        internal function createLines():void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc7:*=NaN;
            var loc1:*=0;
            var loc2:*=null;
            var loc5:*=App.utils.classFactory;
            var loc6:*=0;
            while (loc6 < this.tfMetrics.lines) 
            {
                this.checkTruePosition[loc6] = {};
                this.checkTruePosition[loc6].stand = false;
                this.checkTruePosition[loc6].num = Math.floor(ANIMATE_STEP_FRAMES * Math.floor(this.number / Math.pow(10, loc6) % 10)) + START_FRAME;
                if (loc6 > 0 && loc6 % 3 == 0 && this.localizationSymbol.length > 0) 
                {
                    loc4 = new flash.text.TextField();
                    this.contener_mc.addChild(loc4);
                    loc4.selectable = false;
                    loc4.autoSize = "left";
                    loc4.textColor = this.color;
                    loc4.text = this.localizationSymbol;
                    loc4.setTextFormat(this.tFormat);
                    loc1 = loc1 - Math.round(loc4.textWidth + this.letterSpacing);
                    loc4.x = loc1;
                    if (this.areSpaces(this.localizationSymbol)) 
                        this.contener_mc.removeChild(loc4);
                }
                loc3 = loc5.getComponent("NumberLine", flash.display.MovieClip);
                this.contener_mc.addChild(loc3);
                this.tempTF.autoSize = "left";
                this.tempTF.text = String(Math.floor(this.number / Math.pow(10, loc6) % 10));
                this.tempTF.setTextFormat(this.tFormat);
                loc2 = this.tempTF.getLineMetrics(0);
                this.tempTF.visible = false;
                loc1 = loc1 - Math.round(loc2.width + this.letterSpacing);
                loc3.x = loc1;
                loc3.y = 0;
                loc7 = 0;
                while (loc7 < 10) 
                {
                    loc3["num_" + loc7].textField.autoSize = "left";
                    loc3["num_" + loc7].textField.textColor = this.color;
                    loc3["num_" + loc7].textField.setTextFormat(this.tFormat);
                    ++loc7;
                }
                this.lines[loc6] = loc3;
                ++loc6;
            }
            this._expectedWidth = Math.abs(loc1);
            this.checkTruePosition.push({"stand":true, "num":0});
            return;
        }

        public function get playAnim():Boolean
        {
            return this._playAnim;
        }

        public function set playAnim(arg1:Boolean):void
        {
            if (arg1 == this._playAnim) 
                return;
            this._playAnim = arg1;
            return;
        }

        public function get size():Number
        {
            return this._size;
        }

        public function set size(arg1:Number):void
        {
            if (arg1 == this._size) 
                return;
            this._size = arg1;
            this.startAnim();
            return;
        }

        internal static const ANIMATE_STEP_FRAMES:Number=40;

        internal static const START_FRAME:Number=1;

        internal static const DEF_FONT_WIDTH:Number=21;

        internal static const DEF_FONT_HEIGHT:Number=41;

        internal var _number:Number=-1;

        internal var _font:String="";

        internal var _size:Number;

        internal var _color:Number;

        internal var _letterSpacing:Number;

        internal var _playAnim:Boolean;

        public var contener_mc:flash.display.MovieClip;

        public var tempTF:flash.text.TextField;

        internal var lines:Array;

        internal var tFormat:flash.text.TextFormat;

        internal var tfMetrics:Object;

        internal var realMetricsWidth:Number=0;

        internal var checkTruePosition:Array;

        internal var tween:scaleform.clik.motion.Tween;

        internal var _localizationSymbol:String;

        internal var _tweenNum:Number=0;

        internal var _formattedNumber:String="0";

        internal var _expectedWidth:Number;

        internal var _speed:Number;
    }
}
