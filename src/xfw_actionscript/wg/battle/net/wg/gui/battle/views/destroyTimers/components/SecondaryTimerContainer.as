package net.wg.gui.battle.views.destroyTimers.components
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import scaleform.gfx.TextFieldEx;

    public class SecondaryTimerContainer extends DestroyTimerContainer
    {

        public static const ORANGE_STATE:String = "orange";

        public static const GREEN_STATE:String = "green";

        public var pulse:MovieClip = null;

        public var noise:MovieClip = null;

        public var textFieldLabel:TextField = null;

        public function SecondaryTimerContainer()
        {
            super();
            TextFieldEx.setNoTranslate(textField,true);
        }

        override protected function onDispose() : void
        {
            this.noise = null;
            this.textFieldLabel = null;
            this.pulse.stop();
            this.pulse = null;
            super.onDispose();
        }

        public function getProgressBar() : MovieClip
        {
            return progressBar;
        }

        public function setTimerSettings(param1:SecondaryTimerSetting) : void
        {
            gotoAndStop(param1.state);
            this.textFieldLabel.text = param1.text;
            this.noise.visible = param1.noiseVisible;
            this.pulse.visible = param1.pulseVisible;
            progressBar.visible = !param1.pulseVisible;
        }
    }
}
