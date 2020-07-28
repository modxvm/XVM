package net.wg.infrastructure.managers.impl
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;
    import flash.utils.Dictionary;
    import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
    import flash.filters.BlurFilter;
    import flash.filters.BitmapFilter;
    import flash.filters.BitmapFilterQuality;

    public class ElementBlurAdapter extends Object implements IDisposable
    {

        private static const ANIM_STEP_TIME:int = 20;

        private static const BLUR_XY:int = 20;

        private var _blurAnimCount:Number = 0;

        private var _bluredElements:Vector.<DisplayObject>;

        private var _blurAnimRepeatCount:int = 10;

        private var _containersDict:Dictionary = null;

        public function ElementBlurAdapter(param1:Vector.<DisplayObject>)
        {
            var _loc2_:ISimpleManagedContainer = null;
            super();
            this._containersDict = new Dictionary();
            for each(this._containersDict[_loc2_.type] in param1)
            {
            }
        }

        public function blurElements(param1:String, param2:Vector.<String>, param3:int) : void
        {
            var _loc4_:ISimpleManagedContainer = null;
            var _loc5_:* = 0;
            var _loc7_:String = null;
            var _loc8_:DisplayObject = null;
            var _loc6_:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
            this.cancelScheduled();
            for each(_loc7_ in param2)
            {
                _loc4_ = this._containersDict[_loc7_];
                if(_loc4_ != null)
                {
                    _loc6_.push(_loc4_);
                }
            }
            _loc4_ = this._containersDict[param1];
            if(_loc4_ != null)
            {
                _loc5_ = 0;
                while(_loc5_ < _loc4_.numChildren)
                {
                    _loc6_.push(_loc4_.getChildAt(_loc5_));
                    _loc5_++;
                }
            }
            if(this._bluredElements && this._bluredElements.length)
            {
                for each(_loc8_ in this._bluredElements)
                {
                    if(_loc6_.indexOf(_loc8_) == -1)
                    {
                        _loc8_.filters = null;
                    }
                }
            }
            this._blurAnimCount = 0;
            this._bluredElements = _loc6_;
            this._blurAnimRepeatCount = param3;
            App.utils.scheduler.scheduleRepeatableTask(this.animateBlur,ANIM_STEP_TIME,this._blurAnimRepeatCount,this._bluredElements);
        }

        public function dispose() : void
        {
            this.cancelScheduled();
            this.cleanUpBluredElements();
            App.utils.data.cleanupDynamicObject(this._containersDict);
            this._containersDict = null;
        }

        public function unblurElements() : void
        {
            this.cancelScheduled();
            if(!this._bluredElements)
            {
                return;
            }
            if(this._blurAnimCount > BLUR_XY || this._blurAnimCount <= 0)
            {
                this._blurAnimCount = BLUR_XY;
            }
            App.utils.scheduler.scheduleRepeatableTask(this.animateUnblur,ANIM_STEP_TIME,this._blurAnimRepeatCount,this._bluredElements);
        }

        private function cleanUpBluredElements() : void
        {
            if(this._bluredElements)
            {
                this._bluredElements.splice(0,this._bluredElements.length);
                this._bluredElements = null;
            }
        }

        private function animateBlur(param1:Vector.<DisplayObject>) : void
        {
            var _loc3_:BlurFilter = null;
            var _loc4_:DisplayObject = null;
            var _loc5_:BitmapFilter = null;
            this._blurAnimCount = this._blurAnimCount + BLUR_XY / this._blurAnimRepeatCount;
            var _loc2_:Number = this._blurAnimCount;
            for each(_loc4_ in param1)
            {
                if(_loc4_)
                {
                    if(_loc4_.filters || _loc4_.filters.length)
                    {
                        for each(_loc5_ in _loc4_.filters)
                        {
                            _loc3_ = _loc5_ as BlurFilter;
                            if(_loc3_)
                            {
                                _loc2_ = Math.max(_loc3_.blurX,this._blurAnimCount);
                                break;
                            }
                        }
                    }
                    _loc4_.filters = [new BlurFilter(_loc2_,_loc2_,BitmapFilterQuality.MEDIUM)];
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
            if(this._blurAnimCount <= 0)
            {
                this.cleanUpBluredElements();
            }
        }

        private function cancelScheduled() : void
        {
            App.utils.scheduler.cancelTask(this.animateBlur);
            App.utils.scheduler.cancelTask(this.animateUnblur);
        }
    }
}
