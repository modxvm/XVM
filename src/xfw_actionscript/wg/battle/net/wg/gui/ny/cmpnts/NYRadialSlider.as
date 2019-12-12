package net.wg.gui.ny.cmpnts
{
    import flash.events.MouseEvent;

    public class NYRadialSlider extends NYSliderBase
    {

        private static const CIRCLE_DEGREES:int = 360;

        private static const CIRCLE_DEGREES_HALF:int = 180;

        private static const START_FRAME:int = 1;

        public function NYRadialSlider()
        {
            super();
        }

        override protected function validateValue(param1:Number) : void
        {
            var _loc2_:* = NaN;
            if(param1 >= leftValue && param1 <= rightValue)
            {
                currentValue = param1;
            }
            else
            {
                _loc2_ = CIRCLE_DEGREES - rightValue + leftValue >> 1;
                if(param1 < rightValue + _loc2_)
                {
                    currentValue = rightValue;
                }
                else
                {
                    currentValue = leftValue;
                }
            }
        }

        override protected function applySliderValue(param1:Number) : void
        {
            var _loc2_:int = (param1 - leftValue) / (rightValue - leftValue) * control.totalFrames + START_FRAME;
            control.gotoAndStop(_loc2_);
        }

        override protected function applyMousePosition(param1:MouseEvent) : void
        {
            super.applyMousePosition(param1);
            var _loc2_:Number = Math.atan2(mousePoint.y - control.y,mousePoint.x - control.x) * CIRCLE_DEGREES_HALF / Math.PI;
            this.validateValue(_loc2_);
        }
    }
}
