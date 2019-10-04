package net.wg.gui.bootcamp.battleResult.containers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import scaleform.clik.controls.Button;
    import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;

    public class BottomContainer extends MovieClip implements IDisposable
    {

        public var btnHangar:Button = null;

        public var bottomBg:MovieClip = null;

        public var gradientBg:MovieClip = null;

        public function BottomContainer()
        {
            super();
            addFrameScript(this.totalFrames - 1,this.onAnimationComplete);
        }

        public final function dispose() : void
        {
            addFrameScript(this.totalFrames - 1,null);
            stop();
            this.btnHangar.dispose();
            this.btnHangar = null;
            this.bottomBg = null;
            this.gradientBg = null;
        }

        private function onAnimationComplete() : void
        {
            dispatchEvent(new BattleViewEvent(BattleViewEvent.ANIMATION_COMPLETE));
            stop();
        }
    }
}
