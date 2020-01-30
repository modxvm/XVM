package net.wg.gui.lobby.hangar.wgbob
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;

    public class BobAnnouncementWidgetDescription extends UIComponent
    {

        private static const ICON_TIMER:String = "timer";

        private static const ICON_LOCK:String = "lock";

        private static const TEXT_FIELD_PADDING:int = 2;

        private static const ICON_SIZE:int = 24;

        private static const ICON_PADDING_LEFT:int = 3;

        public var descriptionGlowText:TextField;

        public var descriptionText:TextField;

        public var icon:MovieClip;

        private var _description:String = "";

        private var _isLocked:Boolean;

        private var _hasTimer:Boolean;

        public function BobAnnouncementWidgetDescription()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.descriptionText.autoSize = TextFieldAutoSize.LEFT;
            this.descriptionGlowText.autoSize = TextFieldAutoSize.LEFT;
        }

        override protected function onDispose() : void
        {
            this.descriptionText = null;
            this.descriptionGlowText = null;
            this.icon = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.descriptionText.text = this._description;
                this.descriptionGlowText.text = this._description;
                if(this._isLocked || this._hasTimer)
                {
                    this.icon.gotoAndStop(this._isLocked?ICON_LOCK:ICON_TIMER);
                    this.icon.visible = true;
                    _loc1_ = this.descriptionText.textWidth + ICON_SIZE + TEXT_FIELD_PADDING * 2;
                    this.descriptionText.x = -_loc1_ / 2 + ICON_SIZE - ICON_PADDING_LEFT;
                    this.icon.x = (-_loc1_ + ICON_SIZE >> 1) - ICON_PADDING_LEFT;
                }
                else
                {
                    this.descriptionText.x = -this.descriptionText.width / 2;
                    this.icon.visible = false;
                }
                this.descriptionText.visible = !this._isLocked;
                this.descriptionGlowText.visible = this._isLocked;
                this.descriptionGlowText.x = this.descriptionText.x;
            }
        }

        public function setDescription(param1:String, param2:Boolean, param3:Boolean) : void
        {
            this._description = param1;
            this._isLocked = param2;
            this._hasTimer = param3;
            invalidateData();
        }
    }
}
