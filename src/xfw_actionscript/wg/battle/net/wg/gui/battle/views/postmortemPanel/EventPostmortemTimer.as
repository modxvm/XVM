package net.wg.gui.battle.views.postmortemPanel
{
    import net.wg.gui.battle.components.FrameAnimationTimer;
    import flash.display.MovieClip;
    import flash.text.TextField;

    public class EventPostmortemTimer extends FrameAnimationTimer
    {

        private static const START_FRAME:int = 1;

        private static const END_FRAME:int = 145;

        private static const ICON_FRAME:int = 1;

        private static const ICON_LOCK_FRAME:int = 2;

        public var graphicsSpr:EventPostmortemTimerContainer = null;

        public function EventPostmortemTimer()
        {
            super();
            init(true,true);
        }

        override protected function invokeAdditionalActionOnIntervalUpdate() : void
        {
        }

        override protected function getProgressBarMc() : MovieClip
        {
            return this.graphicsSpr.progressBar;
        }

        override protected function getTimerTF() : TextField
        {
            return this.graphicsSpr.textField;
        }

        override protected function onIntervalHideUpdateHandler() : void
        {
            this.stopTimer();
        }

        override protected function getStartFrame() : int
        {
            return START_FRAME;
        }

        override protected function getEndFrame() : int
        {
            return END_FRAME;
        }

        override protected function resetAnimState() : void
        {
        }

        override protected function onDispose() : void
        {
            this.graphicsSpr.dispose();
            this.graphicsSpr = null;
            super.onDispose();
        }

        public function setLockedState(param1:Boolean) : void
        {
            this.graphicsSpr.setIconFrame(param1?ICON_LOCK_FRAME:ICON_FRAME);
            this.getTimerTF().visible = !param1;
            this.getProgressBarMc().gotoAndStop(START_FRAME);
        }

        public function stopTimer() : void
        {
            pauseRadialTimer();
            pauseHideTimer();
        }
    }
}
