package net.wg.gui.battle.views.postmortemPanel
{
    import net.wg.gui.battle.views.destroyTimers.components.DestroyTimerContainer;
    import flash.display.MovieClip;

    public class EventPostmortemTimerContainer extends DestroyTimerContainer
    {

        public function EventPostmortemTimerContainer()
        {
            super();
        }

        public function setIconFrame(param1:int) : void
        {
            MovieClip(iconSpr).gotoAndStop(param1);
        }

        override protected function onDispose() : void
        {
            progressBar.stop();
            super.onDispose();
        }
    }
}
