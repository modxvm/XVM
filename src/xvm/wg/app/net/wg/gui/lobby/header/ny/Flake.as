package net.wg.gui.lobby.header.ny
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.geom.Rectangle;
    import scaleform.clik.motion.Tween;
    import flash.filters.BlurFilter;
    import fl.transitions.easing.None;
    
    public class Flake extends MovieClip implements IDisposable
    {
        
        public function Flake()
        {
            super();
        }
        
        private static var MIN_SCALE:Number = 0.05;
        
        private static var DELTA_SCALE:Number = 0.05;
        
        private static var MAX_CORN:Number = 30;
        
        private static var MAX_DX:Number = 200;
        
        private static var MIN_ALPHA:Number = 0.5;
        
        private static var DELTA_ALPHA:Number = 0.5;
        
        private static var DELTA_TIME:Number = 1300;
        
        private static var MIN_TIME:Number = 2000;
        
        private static var MAX_Y_BLUR:Number = 4;
        
        private var _allowRect:Rectangle = null;
        
        private var _tween:Tween = null;
        
        private var _bFilter:BlurFilter = null;
        
        public function start(param1:Rectangle) : void
        {
            this._allowRect = param1;
            this._bFilter = new BlurFilter();
            this._bFilter.blurX = 0;
            this._bFilter.blurY = 0;
            this._bFilter.quality = 2;
            this.move();
        }
        
        private function move() : void
        {
            this.updateParams();
            var _loc1_:Number = Math.random();
            var _loc2_:Number = MIN_TIME + DELTA_TIME * _loc1_;
            var _loc3_:Number = MAX_DX * Math.random() - (MAX_DX >> 1);
            var _loc4_:Number = this.x + _loc3_;
            var _loc5_:Number = this.y + this._allowRect.height;
            this.scaleX = this.scaleY = MIN_SCALE + (1 - _loc1_) * DELTA_SCALE;
            this._bFilter.blurX = this._bFilter.blurY = MAX_Y_BLUR * _loc1_;
            this.filters = null;
            this.filters = [this._bFilter];
            this._tween = new Tween(_loc2_,this,{"x":_loc4_,
            "y":_loc5_,
            "alpha":0
        },{"paused":false,
        "ease":None.easeNone,
        "onComplete":this.motionFinish
    });
}

private function updateParams() : void
{
    this.x = this._allowRect.x + this._allowRect.width * Math.random();
    this.y = this._allowRect.y - this.height;
    this.rotation = MAX_CORN * Math.random();
    this.alpha = MIN_ALPHA + Math.random() * DELTA_ALPHA;
}

private function motionFinish(param1:Tween) : void
{
    this.clearTween();
    this.move();
}

private function clearTween() : void
{
    this._tween.paused = true;
    this._tween = null;
}

public function dispose() : void
{
    this.clearTween();
    this._bFilter = null;
}
}
}
