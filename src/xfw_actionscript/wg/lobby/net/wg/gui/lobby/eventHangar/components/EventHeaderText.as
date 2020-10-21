package net.wg.gui.lobby.eventHangar.components
{
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import flash.display.MovieClip;

    public class EventHeaderText extends AnimatedTextContainer
    {

        public var gradientMask:MovieClip = null;

        public function EventHeaderText()
        {
            super();
        }

        override protected function onDispose() : void
        {
            this.gradientMask = null;
            super.onDispose();
        }

        override public function set text(param1:String) : void
        {
            super.text = param1;
            App.utils.commons.updateTextFieldSize(textField);
            textField.x = -textField.width >> 1 | 0;
            this.gradientMask.width = textField.width;
            this.gradientMask.height = textField.height;
            this.gradientMask.x = textField.x;
            this.gradientMask.y = textField.y;
        }
    }
}
