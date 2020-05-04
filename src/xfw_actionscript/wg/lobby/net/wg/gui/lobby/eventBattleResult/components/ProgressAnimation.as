package net.wg.gui.lobby.eventBattleResult.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public class ProgressAnimation extends MovieClip implements IDisposable
    {

        public var barFxRight:ClipContainer = null;

        public var barFxLeft:ClipContainer = null;

        public var dotRight:ClipContainer = null;

        public var dotLeft:ClipContainer = null;

        public var barFx:ClipContainer = null;

        public var progressMask:MovieClip = null;

        public function ProgressAnimation()
        {
            super();
        }

        public function appear() : void
        {
            this.barFx.appear();
            this.dotLeft.appear();
            this.dotRight.appear();
            this.barFxRight.appear();
            this.barFxLeft.appear();
            this.updateBars();
        }

        public function immediateAppear() : void
        {
            this.barFx.immediateAppear();
            this.dotLeft.immediateAppear();
            this.dotRight.immediateAppear();
            this.barFxRight.immediateAppear();
            this.barFxLeft.immediateAppear();
            this.updateBars();
        }

        public final function dispose() : void
        {
            this.dotRight.dispose();
            this.dotRight = null;
            this.dotLeft.dispose();
            this.dotLeft = null;
            this.barFx.dispose();
            this.barFx = null;
            this.barFxRight.dispose();
            this.barFxRight = null;
            this.barFxLeft.dispose();
            this.barFxLeft = null;
            this.progressMask = null;
        }

        public function init(param1:Boolean) : void
        {
            this.dotRight.init(param1);
            this.dotLeft.init(param1);
            this.barFx.init(param1);
            this.barFxRight.init(param1);
            this.barFxLeft.init(param1);
        }

        public function setProgress(param1:int) : void
        {
            gotoAndStop(param1);
            this.updateFx();
        }

        private function updateBars() : void
        {
            this.dotLeft.x = this.barFxLeft.x = this.barFx.x = this.progressMask.x + this.progressMask.width | 0;
            this.updateFx();
        }

        private function updateFx() : void
        {
            var _loc1_:* = 0;
            _loc1_ = this.progressMask.x + this.progressMask.width - this.barFx.x | 0;
            this.dotRight.x = this.progressMask.x + this.progressMask.width | 0;
            this.barFxRight.x = this.barFx.x + _loc1_ | 0;
            this.barFxLeft.visible = this.barFxRight.visible = this.barFx.visible = _loc1_ > 0;
            if(this.barFx.visible)
            {
                this.barFx.width = _loc1_;
            }
        }

        public function resetInitialProgress(param1:int) : void
        {
            gotoAndStop(param1);
            this.updateBars();
        }
    }
}
