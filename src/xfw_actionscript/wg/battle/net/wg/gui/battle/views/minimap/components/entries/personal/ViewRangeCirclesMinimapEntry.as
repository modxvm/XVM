package net.wg.gui.battle.views.minimap.components.entries.personal
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Shape;
    import flash.display.BlendMode;
    import flash.display.Graphics;
    import flash.display.LineScaleMode;

    public class ViewRangeCirclesMinimapEntry extends Sprite implements IDisposable
    {

        private static var LINE_THICKNESS:Number = 1;

        private static var AREA_MAX_SIZE_REAL:Number = 210;

        private var _minMC:Shape = null;

        private var _dynamicMC:Shape = null;

        private var _maxMC:Shape = null;

        private var _drawMC:Shape = null;

        private var _mapSizeCoeff:Number = 0;

        private var _rangeCoeff:Number = 0;

        private var _circleDiameterCoeff:Number = 0;

        private var _currentDynamicRadius:Number = 0;

        public function ViewRangeCirclesMinimapEntry()
        {
            super();
        }

        public function as_addDrawRange(param1:Number, param2:Number, param3:Number) : void
        {
            if(this._drawMC == null)
            {
                this._drawMC = this.initializeCircle(param1,param2,param3);
            }
        }

        public function as_addDynamicViewRange(param1:Number, param2:Number, param3:Number) : void
        {
            if(this._dynamicMC == null)
            {
                this._dynamicMC = this.initializeCircle(param1,param2,param3);
            }
        }

        public function as_addMaxViewRage(param1:Number, param2:Number, param3:Number) : void
        {
            if(this._maxMC == null)
            {
                this._maxMC = this.initializeCircle(param1,param2,param3);
            }
        }

        public function as_addMinSpottingRange(param1:Number, param2:Number, param3:Number) : void
        {
            if(this._minMC == null)
            {
                this._minMC = this.initializeCircle(param1,param2,param3);
            }
        }

        public function as_delDrawRange() : void
        {
            if(this._drawMC)
            {
                this.removeChild(this._drawMC);
                this._drawMC = null;
            }
        }

        public function as_delDynRange() : void
        {
            if(this._dynamicMC)
            {
                this.removeChild(this._dynamicMC);
                this._dynamicMC = null;
            }
        }

        public function as_delMaxViewRage() : void
        {
            if(this._maxMC)
            {
                this.removeChild(this._maxMC);
                this._maxMC = null;
            }
        }

        public function as_delMinSpottingRange() : void
        {
            if(this._minMC)
            {
                this.removeChild(this._minMC);
                this._minMC = null;
            }
        }

        public function as_initArenaSize(param1:int, param2:int) : void
        {
            this._mapSizeCoeff = AREA_MAX_SIZE_REAL / param1;
            this._rangeCoeff = param1 * this._mapSizeCoeff * 0.5;
            this._circleDiameterCoeff = this._mapSizeCoeff * 2;
        }

        public function as_removeAllCircles() : void
        {
            this.as_delDynRange();
            this.as_delDrawRange();
            this.as_delMaxViewRage();
            this.as_delMinSpottingRange();
        }

        public function as_updateDynRange(param1:Number) : void
        {
            var _loc2_:* = NaN;
            if(this._dynamicMC && this._currentDynamicRadius != param1)
            {
                this._currentDynamicRadius = param1;
                _loc2_ = this._currentDynamicRadius * this._circleDiameterCoeff;
                this._dynamicMC.width = _loc2_;
                this._dynamicMC.height = _loc2_;
            }
        }

        public function dispose() : void
        {
            this.as_removeAllCircles();
        }

        private function initializeCircle(param1:Number, param2:Number, param3:Number) : Shape
        {
            var _loc4_:Shape = new Shape();
            this.addChild(_loc4_);
            _loc4_.blendMode = BlendMode.ADD;
            _loc4_.x = 0;
            _loc4_.y = 0;
            this.drawCircle(_loc4_,this._rangeCoeff,param1,param2);
            var _loc5_:Number = param3 * this._circleDiameterCoeff;
            _loc4_.width = _loc5_;
            _loc4_.height = _loc5_;
            return _loc4_;
        }

        private function drawCircle(param1:Shape, param2:Number, param3:Number, param4:Number) : void
        {
            var _loc5_:Graphics = param1.graphics;
            _loc5_.clear();
            _loc5_.lineStyle(LINE_THICKNESS,param3,param4,false,LineScaleMode.NONE);
            _loc5_.drawCircle(0,0,param2);
            _loc5_.endFill();
        }
    }
}
