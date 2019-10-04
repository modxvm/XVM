package net.wg.gui.bootcamp.containers
{
    import flash.display.MovieClip;
    import net.wg.gui.bootcamp.interfaces.IAnimatedRenderer;
    import flash.text.TextField;

    public class AnimatedTextContainer extends MovieClip implements IAnimatedRenderer
    {

        public var textField:TextField;

        public function AnimatedTextContainer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        protected function onDispose() : void
        {
            this.textField = null;
        }

        public function get contentHeight() : int
        {
            return this.textField.textHeight;
        }

        public function get contentWidth() : int
        {
            return this.textField.textWidth;
        }

        public function get text() : String
        {
            return this.textField.text;
        }

        public function set text(param1:String) : void
        {
            this.textField.text = param1;
        }

        public function set htmlText(param1:String) : void
        {
            this.textField.htmlText = param1;
        }

        public function set textColor(param1:int) : void
        {
            this.textField.textColor = param1;
        }
    }
}
