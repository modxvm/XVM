package net.wg.gui.lobby.header.ny
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.geom.Rectangle;
    import flash.filters.BlurFilter;
    
    public class FlakeAnim extends MovieClip implements IDisposable
    {
        
        public function FlakeAnim()
        {
            super();
        }
        
        private static var MIN_SCALE:Number = 0.1;
        
        private static var DELTA_SCALE:Number = 0.4;
        
        private static var MAX_CORN:Number = 40;
        
        private static var MAX_DX:Number = 200;
        
        private static var MIN_ALPHA:Number = 0.5;
        
        private static var DELTA_ALPHA:Number = 0.5;
        
        private static var DELTA_TIME:Number = 1300;
        
        private static var MIN_TIME:Number = 2000;
        
        private static var DELTA_SHOW_Y:Number = 80;
        
        private static var MIN_SHOW_Y:Number = 20;
        
        private static var MAX_Y_BLUR:Number = 4;
        
        private var _allowRect:Rectangle = null;
        
        private var _bFilter:BlurFilter = null;
        
        public var flakeAnim:MovieClip = null;
        
        public function start(param1:Rectangle) : void
        {
            this._allowRect = param1;
            this._bFilter = new BlurFilter();
            this._bFilter.blurX = 0;
            this._bFilter.blurY = 0;
            this._bFilter.quality = 2;
            var _loc2_:Number = this.flakeAnim.totalFrames - 1;
            this.flakeAnim.gotoAndPlay(1 + Math.floor(Math.random() * _loc2_));
            this.flakeAnim.addFrameScript(_loc2_,this.flakeAnimationDispatch);
            this.updateParams();
        }
        
        private function flakeAnimationDispatch() : void
        {
            this.updateParams();
        }
        
        private function updateParams() : void
        {
            this.x = this._allowRect.x + this._allowRect.width * Math.random();
            this.y = this._allowRect.y - Math.random() * DELTA_SHOW_Y - MIN_SHOW_Y;
            this.rotation = MAX_CORN * Math.random() - (MAX_CORN >> 1);
            this.filters = null;
            this._bFilter.blurX = this._bFilter.blurY = MAX_Y_BLUR * Math.random();
            this.filters = [this._bFilter];
        }
        
        public function dispose() : void
        {
            this.flakeAnim.stop();
            this._bFilter = null;
        }
    }
}
