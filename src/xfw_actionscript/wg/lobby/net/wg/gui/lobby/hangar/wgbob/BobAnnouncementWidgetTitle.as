package net.wg.gui.lobby.hangar.wgbob
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;

    public class BobAnnouncementWidgetTitle extends UIComponent
    {

        private static const MAX_WIDTH:int = 190;

        public var textContainer:MovieClip;

        public var textHighlight:MovieClip;

        private var _titleTextField:TextField;

        private var _titleText:String = "";

        public function BobAnnouncementWidgetTitle()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._titleTextField = this.textContainer.textField;
            this._titleTextField.autoSize = TextFieldAutoSize.LEFT;
            this.textContainer.cacheAsBitmap = true;
        }

        override protected function onDispose() : void
        {
            this.textContainer = null;
            this.textHighlight = null;
            this._titleTextField = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this._titleTextField.text = this._titleText;
                _loc1_ = this._titleTextField.width / this._titleTextField.scaleX;
                _loc2_ = Math.min(1,MAX_WIDTH / _loc1_);
                this._titleTextField.scaleX = this._titleTextField.scaleY = _loc2_;
                this._titleTextField.x = -this._titleTextField.width >> 1;
                this._titleTextField.y = -this._titleTextField.height >> 1;
                this.textHighlight.width = this._titleTextField.textWidth * this._titleTextField.scaleX;
                this.textHighlight.height = this._titleTextField.textHeight * this._titleTextField.scaleY;
            }
        }

        public function setTitle(param1:String) : void
        {
            if(this._titleText != param1)
            {
                this._titleText = param1;
                invalidateData();
            }
        }
    }
}
