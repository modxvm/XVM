package net.wg.gui.ny.cmpnts
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.filters.ColorMatrixFilter;
    import flash.display.MovieClip;
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import net.wg.gui.ny.ev.NYSliderEv;
    import scaleform.clik.events.IndexEvent;

    public class NYSliderBase extends UIComponentEx
    {

        private static const OVER_FILTER:ColorMatrixFilter = new ColorMatrixFilter([1.44,0,0,0,-6.34,0,1.44,0,0,-6.34,0,0,1.44,0,-6.34,0,0,0,1,0]);

        public var control:MovieClip = null;

        protected var snapingValue:Number = 0;

        protected var oneStep:Number = 0;

        protected var sliderValue:int = 0;

        protected var mousePoint:Point;

        protected var currentValue:Number = 0;

        protected var leftValue:Number = 0;

        protected var rightValue:Number = 0;

        protected var maxValue:int = 0;

        private var _isDragging:Boolean = false;

        private var _mouseDown:Boolean = false;

        private var _mouseHover:Boolean = false;

        public function NYSliderBase()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            buttonMode = true;
            this.control.mouseEnabled = false;
            this.control.mouseChildren = false;
            addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler,false,0,true);
            addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
            addEventListener(MouseEvent.MOUSE_OVER,this.onControlMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.onControlMouseOutHandler);
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
            removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
            removeEventListener(MouseEvent.MOUSE_OVER,this.onControlMouseOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onControlMouseOutHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler,false);
            App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler,false);
            this.control = null;
            this.mousePoint = null;
            super.onDispose();
        }

        public function initSlider(param1:Number, param2:Number, param3:Number) : void
        {
            this.oneStep = param3;
            this.snapingValue = param3 >> 1;
            this.leftValue = param1;
            this.rightValue = param2;
            this.maxValue = Math.ceil((param2 - param1) / param3);
        }

        public function setIndex(param1:int) : void
        {
            this.currentValue = this.leftValue + this.oneStep * param1;
            this.sliderValue = param1;
            this.applySliderValue(this.currentValue);
        }

        protected function getSnapValueState(param1:Number) : int
        {
            var _loc2_:Number = param1 - this.leftValue;
            var _loc3_:int = _loc2_ / this.oneStep;
            if(_loc2_ % this.oneStep > this.snapingValue)
            {
                _loc3_ = _loc3_ + 1;
            }
            return _loc3_;
        }

        protected function applySliderValue(param1:Number) : void
        {
        }

        protected function validateValue(param1:Number) : void
        {
        }

        protected function getSnapSliderState(param1:Number) : Number
        {
            var _loc2_:int = this.getSnapValueState(param1);
            this.currentValue = _loc2_ * this.oneStep;
            this.sliderValue = _loc2_;
            return this.currentValue;
        }

        protected function applySliderPosition() : void
        {
            this.applySliderValue(this.currentValue);
            this.showNextSnapValue(this.getSnapValueState(this.currentValue));
        }

        private function showNextSnapValue(param1:int) : void
        {
            dispatchEvent(new NYSliderEv(NYSliderEv.SNAP_VALUE_CHANGE,param1,true,true));
        }

        private function snapMousePosition() : void
        {
            this.validateValue(this.currentValue);
            this.applySliderValue(this.getSnapSliderState(this.currentValue));
            dispatchEvent(new IndexEvent(IndexEvent.INDEX_CHANGE,true,true,this.sliderValue));
        }

        public function get isDragging() : Boolean
        {
            return this._isDragging;
        }

        protected function applyMousePosition(param1:MouseEvent) : void
        {
            this.mousePoint = globalToLocal(new Point(param1.stageX,param1.stageY));
        }

        private function onMouseWheelHandler(param1:MouseEvent) : void
        {
            if(param1.delta > 0 && this.sliderValue < this.maxValue)
            {
                dispatchEvent(new IndexEvent(IndexEvent.INDEX_CHANGE,true,true,this.sliderValue + 1));
            }
            if(param1.delta < 0 && this.sliderValue > 0)
            {
                dispatchEvent(new IndexEvent(IndexEvent.INDEX_CHANGE,true,true,this.sliderValue - 1));
            }
        }

        private function onControlMouseOverHandler(param1:MouseEvent) : void
        {
            this._mouseHover = true;
            this.control.filters = [OVER_FILTER];
        }

        private function onControlMouseOutHandler(param1:MouseEvent) : void
        {
            this._mouseHover = false;
            if(!this._mouseDown)
            {
                this.control.filters = [];
            }
        }

        private function onMouseDownHandler(param1:MouseEvent) : void
        {
            this._mouseDown = true;
            this._isDragging = true;
            dispatchEvent(new NYSliderEv(NYSliderEv.DRAGGING_CHANGE,this.sliderValue));
            this.control.filters = [OVER_FILTER];
            App.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler,false,0,true);
            App.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler,false,0,true);
        }

        private function onStageMouseMoveHandler(param1:MouseEvent) : void
        {
            this.applyMousePosition(param1);
            this.applySliderPosition();
        }

        private function onStageMouseUpHandler(param1:MouseEvent) : void
        {
            this._mouseDown = false;
            this._isDragging = false;
            dispatchEvent(new NYSliderEv(NYSliderEv.DRAGGING_CHANGE,this.sliderValue));
            if(!this._mouseHover)
            {
                this.control.filters = [];
            }
            App.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler,false);
            App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler,false);
            this.applyMousePosition(param1);
            this.applySliderPosition();
            this.snapMousePosition();
        }
    }
}
