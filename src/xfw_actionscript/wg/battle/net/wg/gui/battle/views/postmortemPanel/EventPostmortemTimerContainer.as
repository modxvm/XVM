package net.wg.gui.battle.views.postmortemPanel
{
    import net.wg.gui.battle.views.destroyTimers.components.TimerContainer;
    import flash.display.Sprite;
    import flash.display.MovieClip;

    public class EventPostmortemTimerContainer extends TimerContainer
    {

        public var bg:Sprite = null;

        public function EventPostmortemTimerContainer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.bg = null;
            progressBar.stop();
            super.onDispose();
        }

        public function setIconFrame(param1:int) : void
        {
            MovieClip(iconSpr).gotoAndStop(param1);
        }
    }
}
