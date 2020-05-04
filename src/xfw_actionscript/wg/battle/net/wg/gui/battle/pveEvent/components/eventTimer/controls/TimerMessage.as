package net.wg.gui.battle.pveEvent.components.eventTimer.controls
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;

    public class TimerMessage extends MovieClip implements IDisposable
    {

        private static const LABEL_INTRO:String = "intro";

        private static const LABEL_OUTRO:String = "outro";

        public var timerTextMc:AnimatedTextContainer = null;

        public function TimerMessage()
        {
            super();
        }

        public function hideMessage() : void
        {
            gotoAndPlay(LABEL_OUTRO);
        }

        public function showMessage(param1:String) : void
        {
            gotoAndPlay(LABEL_INTRO);
            if(this.timerTextMc)
            {
                this.timerTextMc.text = param1;
            }
        }

        public final function dispose() : void
        {
            this.timerTextMc.dispose();
            this.timerTextMc = null;
        }
    }
}
