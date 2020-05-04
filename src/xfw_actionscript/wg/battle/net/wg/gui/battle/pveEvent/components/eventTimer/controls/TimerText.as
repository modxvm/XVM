package net.wg.gui.battle.pveEvent.components.eventTimer.controls
{
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import flash.text.TextFieldAutoSize;

    public class TimerText extends AnimatedTextContainer
    {

        public function TimerText()
        {
            super();
            textField.autoSize = TextFieldAutoSize.CENTER;
        }
    }
}
