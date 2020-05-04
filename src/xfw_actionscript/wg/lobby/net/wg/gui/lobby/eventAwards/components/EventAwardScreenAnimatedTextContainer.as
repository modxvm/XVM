package net.wg.gui.lobby.eventAwards.components
{
    import net.wg.gui.components.controls.TextFieldContainer;

    public class EventAwardScreenAnimatedTextContainer extends TextFieldContainer
    {

        public function EventAwardScreenAnimatedTextContainer()
        {
            super();
        }

        public function setHtmlText(param1:String) : void
        {
            textField.htmlText = param1;
        }

        public function get autoSize() : String
        {
            return textField.autoSize;
        }

        public function set autoSize(param1:String) : void
        {
            textField.autoSize = param1;
        }

        public function get contentWidth() : int
        {
            return textField.textWidth;
        }

        public function get textY() : int
        {
            return textField.y;
        }

        public function set textY(param1:int) : void
        {
            textField.y = param1;
        }
    }
}
