package net.wg.gui.bootcamp.battleResult.containers
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.DisplayObject;
    import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;

    public class AnimationContainer extends MovieClip implements IDisposable
    {

        public var content:DisplayObject = null;

        public function AnimationContainer()
        {
            super();
            addFrameScript(this.totalFrames - 1,this.onAnimationComplete);
        }

        public final function dispose() : void
        {
            this.content = null;
            addFrameScript(this.totalFrames - 1,null);
            stop();
        }

        private function onAnimationComplete() : void
        {
            dispatchEvent(new BattleViewEvent(BattleViewEvent.ANIMATION_COMPLETE));
            stop();
        }
    }
}
