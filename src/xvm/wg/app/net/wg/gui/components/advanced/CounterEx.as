package net.wg.gui.components.advanced
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import scaleform.clik.motion.Tween;
    import flash.text.TextLineMetrics;
    import net.wg.utils.IClassFactory;
    import fl.motion.easing.Cubic;
    
    public class CounterEx extends UIComponent
    {
        
        public function CounterEx()
        {
            this.tfMetrics = {};
            super();
        }
        
        private static var ANIMATE_STEP_FRAMES:Number = 40;
        
        private static var START_FRAME:Number = 1;
        
        private static var DEF_FONT_WIDTH:Number = 21;
        
        private static var DEF_FONT_HEIGHT:Number = 41;
        
        public var contener_mc:MovieClip;
        
        public var tempTF:TextField;
        
        private var _number:Number = -1;
        
        private var _font:String = "";
        
        private var _size:Number;
        
        private var _color:Number;
        
        private var _letterSpacing:Number;
        
        private var _speed:Number;
        
        private var _playAnim:Boolean;
        
        private var lines:Array;
        
        private var tFormat:TextFormat;
        
        private var tfMetrics:Object;
        
        private var realMetricsWidth:Number = 0;
        
        private var checkTruePosition:Array;
        
        private var tween:Tween;
        
        private var _localizationSymbol:String;
        
        private var _tweenNum:Number = 0;
        
        private var _formattedNumber:String = "0";
        
        private var _expectedWidth:Number;
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.clearLines();
            this.tFormat = null;
            this.tfMetrics = null;
            this.tween = null;
            this.contener_mc = null;
            this.tempTF = null;
            if(this.checkTruePosition)
            {
                this.checkTruePosition = this.checkTruePosition.splice(0,this.checkTruePosition.length);
            }
        }
        
        public function get tweenNum() : Number
        {
            return this._tweenNum;
        }
        
        public function set tweenNum(param1:Number) : void
        {
            if(this._tweenNum == param1)
            {
                return;
            }
            this._tweenNum = param1;
            this.setLinesPosition(this._tweenNum);
        }
        
        public function get expectedWidth() : Number
        {
            return this._expectedWidth;
        }
        
        public function get number() : Number
        {
            return this._number;
        }
        
        public function set number(param1:Number) : void
        {
            if(param1 == this._number)
            {
                return;
            }
            this._number = param1;
            this.startAnim();
        }
        
        public function get playAnim() : Boolean
        {
            return this._playAnim;
        }
        
        public function set playAnim(param1:Boolean) : void
        {
            if(param1 == this._playAnim)
            {
                return;
            }
            this._playAnim = param1;
        }
        
        public function get size() : Number
        {
            return this._size;
        }
        
        public function set size(param1:Number) : void
        {
            if(param1 == this._size)
            {
                return;
            }
            this._size = param1;
            this.startAnim();
        }
        
        public function get color() : Number
        {
            return this._color;
        }
        
        public function set color(param1:Number) : void
        {
            if(param1 == this._color)
            {
                return;
            }
            this._color = param1;
            this.startAnim();
        }
        
        public function get letterSpacing() : Number
        {
            return this._letterSpacing;
        }
        
        public function set letterSpacing(param1:Number) : void
        {
            if(param1 == this._letterSpacing)
            {
                return;
            }
            this._letterSpacing = param1;
            this.startAnim();
        }
        
        public function get speed() : Number
        {
            return this._speed;
        }
        
        public function set speed(param1:Number) : void
        {
            if(param1 == this._speed)
            {
                return;
            }
            this._speed = param1;
            this.startAnim();
        }
        
        public function get font() : String
        {
            return this._font;
        }
        
        public function set font(param1:String) : void
        {
            if(param1 == this._font)
            {
                return;
            }
            this._font = param1;
            this.startAnim();
        }
        
        public function get localizationSymbol() : String
        {
            return this._localizationSymbol;
        }
        
        public function set localizationSymbol(param1:String) : void
        {
            if(param1 == this._localizationSymbol)
            {
                return;
            }
            this._localizationSymbol = param1;
        }
        
        public function get metricsWidth() : Number
        {
            return this.realMetricsWidth;
        }
        
        public function get formattedNumber() : String
        {
            return this._formattedNumber;
        }
        
        public function set formattedNumber(param1:String) : void
        {
            this._formattedNumber = param1;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.tempTF.visible = false;
        }
        
        override protected function draw() : void
        {
            super.draw();
        }
        
        private function areSpaces(param1:String) : Boolean
        {
            var _loc2_:* = true;
            var _loc3_:Number = 0;
            while(_loc3_ < param1.length)
            {
                if(param1.slice(_loc3_,_loc3_ + 1) != " ")
                {
                    _loc2_ = false;
                    break;
                }
                _loc3_++;
            }
            return _loc2_;
        }
        
        private function startAnim() : void
        {
            if((!(this.font == "") && this.size > 0) && (this.color) && this.speed > 0)
            {
                this.checkTruePosition = [];
                this.tFormat = this.tempTF.getTextFormat();
                this.tFormat.color = this.color;
                this.tFormat.size = this.size;
                this.tFormat.font = this.font;
                this.tFormat.letterSpacing = this.letterSpacing;
                this.tFormat.align = "left";
                this.tempTF.autoSize = "left";
                this.tempTF.text = this.formattedNumber.length > 0?this.formattedNumber:"0";
                this.tempTF.setTextFormat(this.tFormat);
                this.tFormat = this.tempTF.getTextFormat(0,1);
                this.realMetricsWidth = this.tempTF.getLineMetrics(0).width;
                this.tfMetrics.lines = String(Math.abs(this.number)).length;
                this.tempTF.text = "";
                this.tempTF.visible = false;
                this.clearLines();
                this.createLines();
                this.animate();
            }
        }
        
        private function clearLines() : void
        {
            if(this.tween)
            {
                this.tween.paused = true;
                this.tween = null;
            }
            while(this.contener_mc.numChildren > 0)
            {
                this.contener_mc.removeChildAt(0);
            }
            if(this.lines)
            {
                this.lines = this.lines.splice(0,this.lines.length);
            }
            else
            {
                this.lines = [];
            }
        }
        
        private function createLines() : void
        {
            var _loc3_:MovieClip = null;
            var _loc4_:TextField = null;
            var _loc7_:* = NaN;
            var _loc1_:Number = 0;
            var _loc2_:TextLineMetrics = null;
            var _loc5_:IClassFactory = App.utils.classFactory;
            var _loc6_:Number = 0;
            while(_loc6_ < this.tfMetrics.lines)
            {
                this.checkTruePosition[_loc6_] = {};
                this.checkTruePosition[_loc6_].stand = false;
                this.checkTruePosition[_loc6_].num = Math.floor(ANIMATE_STEP_FRAMES * Math.floor(Math.abs(this.number) / Math.pow(10,_loc6_) % 10)) + START_FRAME;
                if(_loc6_ > 0 && _loc6_ % 3 == 0 && this.localizationSymbol.length > 0)
                {
                    _loc4_ = new TextField();
                    this.contener_mc.addChild(_loc4_);
                    _loc4_.selectable = false;
                    _loc4_.autoSize = "left";
                    _loc4_.textColor = this.color;
                    _loc4_.text = this.localizationSymbol;
                    _loc4_.setTextFormat(this.tFormat);
                    _loc1_ = _loc1_ - Math.round(_loc4_.textWidth + this.letterSpacing);
                    _loc4_.x = _loc1_;
                    if(this.areSpaces(this.localizationSymbol))
                    {
                        this.contener_mc.removeChild(_loc4_);
                    }
                }
                _loc3_ = _loc5_.getComponent("NumberLine",MovieClip);
                this.contener_mc.addChild(_loc3_);
                this.tempTF.autoSize = "left";
                this.tempTF.text = String(Math.floor(Math.abs(this.number) / Math.pow(10,_loc6_) % 10));
                this.tempTF.setTextFormat(this.tFormat);
                _loc2_ = this.tempTF.getLineMetrics(0);
                this.tempTF.visible = false;
                _loc1_ = _loc1_ - Math.round(_loc2_.width + this.letterSpacing);
                _loc3_.x = _loc1_;
                _loc3_.y = 0;
                _loc7_ = 0;
                while(_loc7_ < 10)
                {
                    _loc3_["num_" + _loc7_].textField.autoSize = "left";
                    _loc3_["num_" + _loc7_].textField.textColor = this.color;
                    _loc3_["num_" + _loc7_].textField.setTextFormat(this.tFormat);
                    _loc7_++;
                }
                this.lines[_loc6_] = _loc3_;
                _loc6_++;
            }
            if(this.number < 0)
            {
                _loc4_ = new TextField();
                this.contener_mc.addChild(_loc4_);
                _loc4_.selectable = false;
                _loc4_.autoSize = "left";
                _loc4_.textColor = this.color;
                _loc4_.text = "-";
                _loc4_.setTextFormat(this.tFormat);
                _loc1_ = _loc1_ - Math.round(_loc4_.textWidth + this.letterSpacing);
                _loc4_.x = _loc1_;
            }
            this._expectedWidth = Math.abs(_loc1_);
            this.checkTruePosition.push({"stand":true,
            "num":0
        });
    }
    
    private function animate() : void
    {
        var _loc1_:* = 0;
        if(this.playAnim)
        {
            this.tween = new Tween(this.speed,this,{"tweenNum":Math.abs(this.number)},{"paused":false,
            "ease":Cubic.easeOut,
            "onComplete":null
        });
    }
    else
    {
        _loc1_ = 0;
        while(_loc1_ < this.lines.length)
        {
            this.checkTruePosition[_loc1_].stand = true;
            this.lines[_loc1_].gotoAndStop(this.checkTruePosition[_loc1_].num);
            _loc1_++;
        }
    }
}

private function setLinesPosition(param1:Number) : void
{
    var _loc2_:* = 0;
    while(_loc2_ < this.lines.length)
    {
        if((!this.checkTruePosition[_loc2_].stand && this.checkTruePosition[_loc2_ + 1].stand) && (this.lines[_loc2_].currentFrame + START_FRAME > this.checkTruePosition[_loc2_].num) || param1 == Math.abs(this.number))
        {
            this.checkTruePosition[_loc2_].stand = true;
            this.lines[_loc2_].gotoAndStop(this.checkTruePosition[_loc2_].num);
        }
        else if(!this.checkTruePosition[_loc2_].stand)
        {
            this.lines[_loc2_].gotoAndStop(Math.floor(START_FRAME + ANIMATE_STEP_FRAMES * (param1 / Math.pow(10,_loc2_) % 10)));
        }
        
        _loc2_++;
    }
}
}
}
