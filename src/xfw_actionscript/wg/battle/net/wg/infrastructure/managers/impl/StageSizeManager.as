package net.wg.infrastructure.managers.impl
{
    import net.wg.infrastructure.managers.IStageSizeManager;
    import net.wg.utils.StageSizeBoundaries;
    import net.wg.utils.IStageSizeDependComponent;
    import flash.geom.Rectangle;
    import net.wg.infrastructure.events.LifeCycleEvent;

    public class StageSizeManager extends Object implements IStageSizeManager
    {

        private static const WIDTH_BOUNDARY_VALUES:Vector.<int> = new <int>[StageSizeBoundaries.WIDTH_2200,StageSizeBoundaries.WIDTH_1920,StageSizeBoundaries.WIDTH_1600,StageSizeBoundaries.WIDTH_1366,StageSizeBoundaries.WIDTH_1280,StageSizeBoundaries.WIDTH_1024];

        private static const HEIGHT_BOUNDARY_VALUES:Vector.<int> = new <int>[StageSizeBoundaries.HEIGHT_1080,StageSizeBoundaries.HEIGHT_900,StageSizeBoundaries.HEIGHT_837,StageSizeBoundaries.HEIGHT_800,StageSizeBoundaries.HEIGHT_768];

        private var _components:Vector.<IStageSizeDependComponent>;

        private var _currentBoundaries:Rectangle;

        public function StageSizeManager()
        {
            super();
            this._components = new Vector.<IStageSizeDependComponent>(0);
            this._currentBoundaries = new Rectangle();
        }

        private static function getBoundary(param1:int, param2:Vector.<int>) : int
        {
            var _loc3_:* = 0;
            for each(_loc3_ in param2)
            {
                if(param1 >= _loc3_)
                {
                    return _loc3_;
                }
            }
            return param2[param2.length - 1];
        }

        public function calcAllowSize(param1:int, param2:Array) : int
        {
            if(param2.indexOf(param1) >= 0)
            {
                return param1;
            }
            var _loc3_:int = param2.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                if(param2[_loc4_] > param1)
                {
                    return param2[_loc4_ > 0?_loc4_ - 1:_loc4_];
                }
                _loc4_++;
            }
            return param2[_loc3_ - 1];
        }

        public function dispose() : void
        {
            var _loc1_:IStageSizeDependComponent = null;
            for each(_loc1_ in this._components)
            {
                _loc1_.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onComponentDisposeHandler);
            }
            this._components.length = 0;
            this._components = null;
            this._currentBoundaries = null;
        }

        public function register(param1:IStageSizeDependComponent) : void
        {
            if(this._components.indexOf(param1) == -1)
            {
                this._components.push(param1);
                param1.setStateSizeBoundaries(this._currentBoundaries.width,this._currentBoundaries.height);
                param1.addEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onComponentDisposeHandler);
            }
        }

        public function unregister(param1:IStageSizeDependComponent) : void
        {
            param1.removeEventListener(LifeCycleEvent.ON_BEFORE_DISPOSE,this.onComponentDisposeHandler);
            var _loc2_:Number = this._components.indexOf(param1);
            if(_loc2_ != -1)
            {
                this._components.splice(_loc2_,1);
            }
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            var _loc5_:IStageSizeDependComponent = null;
            var _loc3_:int = getBoundary(param1,WIDTH_BOUNDARY_VALUES);
            var _loc4_:int = getBoundary(param2,HEIGHT_BOUNDARY_VALUES);
            if(_loc3_ != this._currentBoundaries.width || _loc4_ != this._currentBoundaries.height)
            {
                this._currentBoundaries.width = _loc3_;
                this._currentBoundaries.height = _loc4_;
                for each(_loc5_ in this._components)
                {
                    _loc5_.setStateSizeBoundaries(_loc3_,_loc4_);
                }
            }
        }

        private function onComponentDisposeHandler(param1:LifeCycleEvent) : void
        {
            this.unregister(param1.currentTarget as IStageSizeDependComponent);
        }
    }
}
