package net.wg.gui.ny.cmpnts
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;

    public class NYLinearSlider extends NYSliderBase
    {

        private static const RADIUS:int = 675;

        private static const CIRCLE_DEGREES_HALF:int = 180;

        private static const DIGREES_TO_RADIAN:Number = Math.PI / CIRCLE_DEGREES_HALF;

        private static const ANIMATED_CONTROL_NAME:String = "animatedControl";

        private var _animatedControl:MovieClip = null;

        public function NYLinearSlider()
        {
            super();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this._animatedControl = MovieClip(control.getChildByName(ANIMATED_CONTROL_NAME));
        }

        override protected function validateValue(param1:Number) : void
        {
            if(param1 < leftValue)
            {
                currentValue = leftValue;
            }
            else if(param1 > rightValue)
            {
                currentValue = rightValue;
            }
            else
            {
                currentValue = param1;
            }
        }

        override protected function applySliderValue(param1:Number) : void
        {
            var _loc2_:Number = param1 * DIGREES_TO_RADIAN;
            var _loc3_:Number = (param1 - leftValue) / (rightValue - leftValue);
            var _loc4_:uint = _loc3_ * control.totalFrames ^ 0;
            var _loc5_:uint = _loc3_ * this._animatedControl.totalFrames ^ 0;
            control.gotoAndStop(_loc4_);
            this._animatedControl.gotoAndStop(_loc5_);
        }

        override protected function onDispose() : void
        {
            stop();
            control.stop();
            this._animatedControl.stop();
            this._animatedControl = null;
            super.onDispose();
        }

        override protected function applyMousePosition(param1:MouseEvent) : void
        {
            super.applyMousePosition(param1);
            var _loc2_:Number = Math.atan2(mousePoint.y - RADIUS,mousePoint.x - RADIUS) * CIRCLE_DEGREES_HALF / Math.PI;
            this.validateValue(_loc2_);
        }
    }
}
