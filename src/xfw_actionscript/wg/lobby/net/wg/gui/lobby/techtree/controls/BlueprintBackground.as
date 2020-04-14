package net.wg.gui.lobby.techtree.controls
{
    import net.wg.gui.components.controls.BitmapFill;
    import flash.display.Sprite;
    import scaleform.clik.motion.Tween;
    import flash.display.DisplayObject;
    import fl.motion.easing.Linear;

    public class BlueprintBackground extends FadeComponent
    {

        private static const TWEEN_DURATION:int = 300;

        public var gridFill:BitmapFill = null;

        public var blueprintBg:Sprite = null;

        public var techtreeBg:Sprite = null;

        public var backgroundFill:Sprite = null;

        private var _bpBgShowTween:Tween = null;

        private var _bpBgHideTween:Tween = null;

        private var _bgShowTween:Tween = null;

        private var _bgHideTween:Tween = null;

        private var _bpGridShowTween:Tween = null;

        private var _bpGridHideTween:Tween = null;

        public function BlueprintBackground()
        {
            super();
        }

        override public function setSize(param1:Number, param2:Number) : void
        {
            super.setSize(param1,param2);
            this.gridFill.setSize(param1,param2);
            this.backgroundFill.width = param1;
            this.backgroundFill.height = param2;
            this.placeBgImg(this.blueprintBg,param1,param2);
            this.placeBgImg(this.techtreeBg,param1,param2);
        }

        private function placeBgImg(param1:DisplayObject, param2:Number, param3:Number) : void
        {
            var _loc8_:* = false;
            var _loc4_:Number = param2 / param3;
            var _loc5_:Number = param1.width / param1.height;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            if(_loc5_ > 0 && _loc4_ > 0)
            {
                _loc8_ = _loc4_ > _loc5_;
                _loc6_ = _loc8_?param2:_loc5_ * param3;
                _loc7_ = _loc8_?param2 / _loc5_:param3;
            }
            param1.width = _loc6_;
            param1.height = _loc7_;
            param1.x = param2 - _loc6_ >> 1;
            param1.y = param3 - _loc7_ >> 1;
        }

        override protected function onDispose() : void
        {
            this.clearTween(this._bpBgShowTween);
            this._bpBgShowTween = null;
            this.clearTween(this._bpBgHideTween);
            this._bpBgHideTween = null;
            this.clearTween(this._bgHideTween);
            this._bgHideTween = null;
            this.clearTween(this._bgShowTween);
            this._bgShowTween = null;
            this.clearTween(this._bpGridShowTween);
            this._bpGridShowTween = null;
            this.clearTween(this._bpGridHideTween);
            this._bpGridHideTween = null;
            this.gridFill.dispose();
            this.gridFill = null;
            this.blueprintBg = null;
            this.techtreeBg = null;
            this.backgroundFill = null;
            super.onDispose();
        }

        override protected function updateEnabledState(param1:Boolean) : void
        {
            this.updateBg();
        }

        private function updateBg() : void
        {
            if(enabled)
            {
                this.clearTween(this._bpBgShowTween);
                this.clearTween(this._bgHideTween);
                this._bpBgShowTween = new Tween(TWEEN_DURATION,this.blueprintBg,{"alpha":1},{"ease":Linear.easeNone});
                this._bpGridShowTween = new Tween(TWEEN_DURATION,this.gridFill,{"alpha":1},{"ease":Linear.easeNone});
                this._bgHideTween = new Tween(TWEEN_DURATION,this.techtreeBg,{"alpha":0},{"ease":Linear.easeNone});
            }
            else
            {
                this.clearTween(this._bpBgHideTween);
                this.clearTween(this._bgShowTween);
                this._bpBgHideTween = new Tween(TWEEN_DURATION,this.blueprintBg,{"alpha":0},{"ease":Linear.easeNone});
                this._bpGridHideTween = new Tween(TWEEN_DURATION,this.gridFill,{"alpha":0},{"ease":Linear.easeNone});
                this._bgShowTween = new Tween(TWEEN_DURATION,this.techtreeBg,{"alpha":1},{"ease":Linear.easeNone});
            }
        }

        private function clearTween(param1:Tween) : void
        {
            if(param1)
            {
                param1.paused = true;
                param1.dispose();
            }
        }
    }
}
