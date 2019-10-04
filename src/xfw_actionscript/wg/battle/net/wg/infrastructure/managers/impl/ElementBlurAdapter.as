package net.wg.infrastructure.managers.impl
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;
    import flash.filters.BlurFilter;
    import flash.filters.BitmapFilterQuality;

    public class ElementBlurAdapter extends Object implements IDisposable
    {

        private static const ANIM_STEP_TIME:int = 20;

        private static const BLUR_XY:int = 20;

        private var _blurAnimCount:Number = 0;

        private var _bluredElements:Vector.<DisplayObject>;

        private var _blurAnimRepeatCount:Number = 10;

        public function ElementBlurAdapter()
        {
            super();
        }

        public function blurElements(param1:Vector.<DisplayObject>, param2:Number) : void
        {
            this._bluredElements = param1;
            this._blurAnimRepeatCount = param2;
            this._blurAnimCount = 0;
            this.cancelScheduled();
            App.utils.scheduler.scheduleRepeatableTask(this.animateBlur,ANIM_STEP_TIME,this._blurAnimRepeatCount,param1);
        }

        public function dispose() : void
        {
            this.cancelScheduled();
            if(this._bluredElements)
            {
                this._bluredElements.splice(0,this._bluredElements.length);
                this._bluredElements = null;
            }
        }

        public function unblurElements() : void
        {
            this._blurAnimCount = BLUR_XY;
            this.cancelScheduled();
            App.utils.scheduler.scheduleRepeatableTask(this.animateUnblur,ANIM_STEP_TIME,this._blurAnimRepeatCount,this._bluredElements);
        }

        private function animateBlur(param1:Vector.<DisplayObject>) : void
        {
            var _loc2_:DisplayObject = null;
            this._blurAnimCount = this._blurAnimCount + BLUR_XY / this._blurAnimRepeatCount;
            for each(_loc2_ in param1)
            {
                if(_loc2_)
                {
                    _loc2_.filters = [new BlurFilter(this._blurAnimCount,this._blurAnimCount,BitmapFilterQuality.MEDIUM)];
                }
            }
        }

        private function animateUnblur(param1:Vector.<DisplayObject>) : void
        {
            var _loc2_:DisplayObject = null;
            this._blurAnimCount = this._blurAnimCount - BLUR_XY / this._blurAnimRepeatCount;
            for each(_loc2_ in param1)
            {
                _loc2_.filters = [new BlurFilter(this._blurAnimCount,this._blurAnimCount,BitmapFilterQuality.LOW)];
            }
        }

        private function cancelScheduled() : void
        {
            App.utils.scheduler.cancelTask(this.animateBlur);
            App.utils.scheduler.cancelTask(this.animateUnblur);
        }
    }
}
