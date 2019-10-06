package net.wg.gui.bootcamp.prebattleHints.controls
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.Sprite;
    import flash.text.TextFieldAutoSize;

    public class HintContainer extends MovieClip
    {

        private static const TEXT_PADDING:int = 20;

        public var textField:TextField;

        public var background:Sprite;

        public var arrowRight:Sprite;

        public var arrowUpDown:Sprite;

        public function HintContainer()
        {
            super();
            this.textField.autoSize = TextFieldAutoSize.LEFT;
        }

        public function setLabel(param1:String) : void
        {
            this.textField.text = param1;
            this.background.width = this.textField.width + (TEXT_PADDING << 1);
            if(this.arrowRight)
            {
                this.arrowRight.x = this.background.x + this.background.width + this.arrowRight.width;
            }
            if(this.arrowUpDown)
            {
                this.arrowUpDown.x = this.background.x + (this.background.width - this.arrowUpDown.width >> 1);
            }
        }

        public final function dispose() : void
        {
            this.textField = null;
            this.background = null;
            this.arrowRight = null;
            this.arrowUpDown = null;
        }
    }
}
