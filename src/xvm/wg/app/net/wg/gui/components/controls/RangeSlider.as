package net.wg.gui.components.controls
{
    import scaleform.clik.controls.Button;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import net.wg.gui.components.controls.events.RangeSliderEvent;
    import scaleform.clik.events.SliderEvent;
    
    public class RangeSlider extends Slider
    {
        
        public function RangeSlider()
        {
            super();
            this.leftProgressMask = track["left_progress_mask"];
        }
        
        private static var INVALID_MODE:String = "invalidMode";
        
        private static var INVALID_RANGE:String = "invalidRange";
        
        private static var INVALID_DIVISION_SCALE:String = "invalidDivisionScale";
        
        private static var INVALID_DIVISION_POINT_RENDERER:String = "invalidDivisionPointRenderer";
        
        public var leftThumb:Button;
        
        public var rightThumb:Button;
        
        public var leftProgressMask:MovieClip;
        
        public var divisionScaleContainer:Sprite;
        
        private var _rangeMode:Boolean = true;
        
        private var _divisionPointRenderer:String = "SliderDivisionPointUI";
        
        private var _divisionStep:Number = 5;
        
        private var _divisionLabelStep:Number = 10;
        
        private var _minRangeDistance:Number = 0;
        
        private var _divisionLabelPostfix:String = "";
        
        private var _draggingThumb:DisplayObject;
        
        private var _leftValue:Number = 0;
        
        private var _rightValue:Number = 10;
        
        public function get divisionPointRenderer() : String
        {
            return this._divisionPointRenderer;
        }
        
        public function set divisionPointRenderer(param1:String) : void
        {
            this._divisionPointRenderer = param1;
            invalidate(INVALID_DIVISION_POINT_RENDERER);
        }
        
        public function get rangeMode() : Boolean
        {
            return this._rangeMode;
        }
        
        public function set rangeMode(param1:Boolean) : void
        {
            this._rangeMode = param1;
            invalidate(INVALID_MODE);
        }
        
        public function get divisionStep() : Number
        {
            return this._divisionStep;
        }
        
        public function set divisionStep(param1:Number) : void
        {
            this._divisionStep = param1;
            invalidate(INVALID_DIVISION_SCALE);
        }
        
        public function get divisionLabelStep() : Number
        {
            return this._divisionLabelStep;
        }
        
        public function set divisionLabelStep(param1:Number) : void
        {
            this._divisionLabelStep = param1;
            invalidate(INVALID_DIVISION_SCALE);
        }
        
        public function get divisionLabelPostfix() : String
        {
            return this._divisionLabelPostfix;
        }
        
        public function set divisionLabelPostfix(param1:String) : void
        {
            this._divisionLabelPostfix = param1;
            invalidate(INVALID_DIVISION_SCALE);
        }
        
        public function get leftValue() : Number
        {
            return this._leftValue;
        }
        
        public function set leftValue(param1:Number) : void
        {
            this._leftValue = param1;
            this.dispatchChangeEvent();
            this.updateRangeThumbs();
        }
        
        public function get rightValue() : Number
        {
            return this._rightValue;
        }
        
        public function set rightValue(param1:Number) : void
        {
            this._rightValue = param1;
            this.dispatchChangeEvent();
            this.updateRangeThumbs();
        }
        
        public function get minRangeDistance() : Number
        {
            return this._minRangeDistance;
        }
        
        public function set minRangeDistance(param1:Number) : void
        {
            this._minRangeDistance = param1;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            track["left_progress_mask"].gotoAndStop(0);
            this.leftThumb.addEventListener(MouseEvent.MOUSE_DOWN,this.beginDrag,false,0,true);
            this.rightThumb.addEventListener(MouseEvent.MOUSE_DOWN,this.beginDrag,false,0,true);
        }
        
        override protected function onDispose() : void
        {
            this.leftThumb.removeEventListener(MouseEvent.MOUSE_DOWN,this.beginDrag,false);
            this.rightThumb.removeEventListener(MouseEvent.MOUSE_DOWN,this.beginDrag,false);
            this.clearDivisionScale();
            this.divisionScaleContainer = null;
            this.leftThumb.dispose();
            this.leftThumb = null;
            this.rightThumb.dispose();
            this.rightThumb = null;
            this.leftProgressMask = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALID_MODE))
            {
                this.updateMode();
            }
            if(isInvalid(INVALID_DIVISION_POINT_RENDERER,INVALID_DIVISION_SCALE,INVALID_RANGE))
            {
                this.updateDivisionScale();
            }
            if(this._rangeMode)
            {
                this.updateRangeThumbs();
            }
        }
        
        override protected function trackPress(param1:MouseEvent) : void
        {
            var _loc2_:* = NaN;
            var _loc3_:* = NaN;
            var _loc4_:* = NaN;
            var _loc5_:* = NaN;
            var _loc6_:MouseEvent = null;
            if((this._rangeMode) && (App.utils.commons.isLeftButton(param1)))
            {
                _trackPressed = true;
                track.focused = _focused;
                _loc2_ = _width - offsetLeft - offsetRight;
                _loc3_ = lockValue((param1.localX * scaleX - offsetLeft) / _loc2_ * (_maximum - _minimum) + _minimum);
                _loc4_ = Math.abs(this._leftValue - _loc3_);
                _loc5_ = Math.abs(this._rightValue - _loc3_);
                if(_loc4_ < _loc5_ || _loc3_ < this.leftValue)
                {
                    this.leftValue = _loc3_;
                    this._draggingThumb = this.leftThumb;
                }
                else
                {
                    this.rightValue = _loc3_;
                    this._draggingThumb = this.rightThumb;
                }
                _trackDragMouseIndex = 0;
                _dragOffset = {"x":0};
                _loc6_ = new MouseEvent(MouseEvent.MOUSE_DOWN,false,true);
                _loc6_.localX = this._draggingThumb.mouseX;
                _loc6_.localY = this._draggingThumb.mouseY;
                this._draggingThumb.dispatchEvent(_loc6_);
            }
            else
            {
                super.trackPress(param1);
            }
        }
        
        override protected function onScrollWheel(param1:MouseEvent) : void
        {
            if(!this._rangeMode)
            {
                super.onScrollWheel(param1);
            }
        }
        
        override protected function beginDrag(param1:MouseEvent) : void
        {
            var _loc2_:Point = null;
            if(App.utils.commons.isLeftButton(param1))
            {
                this._draggingThumb = param1.currentTarget as DisplayObject;
                _thumbPressed = true;
                _loc2_ = globalToLocal(new Point(param1.stageX,param1.stageY));
                _dragOffset = {"x":_loc2_.x - this._draggingThumb.x - this._draggingThumb.width / 2};
                stage.addEventListener(MouseEvent.MOUSE_MOVE,this.doDrag,false,0,true);
                stage.addEventListener(MouseEvent.MOUSE_UP,endDrag,false,0,true);
            }
        }
        
        override protected function doDrag(param1:MouseEvent) : void
        {
            var _loc2_:* = NaN;
            if(this._draggingThumb == thumb)
            {
                super.doDrag(param1);
            }
            else
            {
                _loc2_ = this.getValueByPosition(param1);
                if(this._draggingThumb == this.leftThumb && _loc2_ <= this._rightValue && Math.abs(this._rightValue - _loc2_) >= this._minRangeDistance)
                {
                    this.leftValue = _loc2_;
                }
                else if(this._draggingThumb == this.rightThumb && _loc2_ >= this._leftValue && Math.abs(_loc2_ - this._leftValue) >= this._minRangeDistance)
                {
                    this.rightValue = _loc2_;
                }
                
            }
        }
        
        protected function updateRangeThumbs() : void
        {
            var _loc1_:Number = track.width - offsetLeft - offsetRight;
            var _loc2_:Number = _maximum - _minimum;
            var _loc3_:Number = offsetLeft - thumb.width / 2;
            this.leftThumb.x = (this._leftValue - _minimum) / _loc2_ * _loc1_ + _loc3_ ^ 0;
            this.rightThumb.x = (this._rightValue - _minimum) / _loc2_ * _loc1_ + _loc3_ ^ 0;
            var _loc4_:Number = (this._leftValue - _minimum) / (_maximum - _minimum);
            this.leftProgressMask.gotoAndStop(Math.round(_loc4_ * this.leftProgressMask.totalFrames));
            _loc4_ = (this._rightValue - _minimum) / (_maximum - _minimum);
            track["progress_mask"].gotoAndStop(Math.round(_loc4_ * track["progress_mask"].totalFrames));
        }
        
        protected function getValueByPosition(param1:MouseEvent) : Number
        {
            var _loc2_:Number = track.width - offsetLeft - offsetRight;
            var _loc3_:Point = globalToLocal(new Point(param1.stageX,param1.stageY));
            var _loc4_:Number = _loc3_.x - _dragOffset.x;
            return lockValue((_loc4_ - offsetLeft) / _loc2_ * (_maximum - _minimum) + _minimum);
        }
        
        override public function set minimum(param1:Number) : void
        {
            super.minimum = param1;
            invalidate(INVALID_RANGE);
        }
        
        override public function set maximum(param1:Number) : void
        {
            super.maximum = param1;
            invalidate(INVALID_RANGE);
        }
        
        private function updateDivisionScale() : void
        {
            var _loc1_:SliderKeyPoint = null;
            var _loc8_:* = NaN;
            var _loc9_:* = false;
            this.clearDivisionScale();
            var _loc2_:Number = track.width - offsetLeft - offsetRight;
            var _loc3_:Number = Math.abs(_maximum - _minimum);
            var _loc4_:int = _loc3_ / this._divisionStep;
            var _loc5_:Number = _loc2_ / _loc4_;
            var _loc6_:Class = App.utils.classFactory.getClass(this._divisionPointRenderer);
            var _loc7_:* = 0;
            while(_loc7_ <= _loc4_)
            {
                _loc1_ = App.utils.classFactory.getComponent(this._divisionPointRenderer,_loc6_);
                _loc8_ = _minimum + _loc7_ * this._divisionStep;
                _loc9_ = _loc8_ % this._divisionLabelStep == 0;
                _loc1_.x = _loc7_ * _loc5_ ^ 0;
                _loc1_.index = _loc7_;
                _loc1_.label = _loc9_?_loc8_ + this._divisionLabelPostfix:"";
                this.divisionScaleContainer.addChild(_loc1_);
                _loc7_++;
            }
        }
        
        private function clearDivisionScale() : void
        {
            var _loc1_:SliderKeyPoint = null;
            while(this.divisionScaleContainer.numChildren)
            {
                _loc1_ = this.divisionScaleContainer.getChildAt(0) as SliderKeyPoint;
                this.divisionScaleContainer.removeChild(_loc1_);
                _loc1_.dispose();
            }
        }
        
        private function updateMode() : void
        {
            thumb.visible = !this._rangeMode;
            this.leftThumb.visible = this._rangeMode;
            this.rightThumb.visible = this._rangeMode;
            this.leftProgressMask.visible = this._rangeMode;
        }
        
        private function dispatchChangeEvent() : void
        {
            dispatchEvent(new RangeSliderEvent(SliderEvent.VALUE_CHANGE,false,true,_value,this._leftValue,this._rightValue));
        }
    }
}
