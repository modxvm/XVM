package net.wg.gui.lobby.header.headerButtonBar
{
    import net.wg.gui.lobby.components.ArrowDown;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
    import net.wg.gui.events.UILoaderEvent;
    import scaleform.clik.constants.InvalidationType;

    public class HBC_Squad extends HeaderButtonContentItem
    {

        private static const MIN_SCREEN_PADDING_LEFT:int = 13;

        private static const MIN_SCREEN_PADDING_RIGHT:int = 11;

        private static const ADDITIONAL_SCREEN_PADDING_LEFT:int = 4;

        private static const ADDITIONAL_SCREEN_PADDING_RIGHT:int = -2;

        private static const MAX_FONT_SIZE:int = 14;

        private static const ICON_ARROW_GAP:int = 3;

        private static const SQUAD_ICON_MARGIN:int = 0;

        private static const SQUAD_TEXT_MARGIN:int = 5;

        public var arrow:ArrowDown = null;

        public var textField:TextField = null;

        public var icon:UILoaderAlt = null;

        private var _squadDataVo:HBC_SquadDataVo = null;

        public function HBC_Squad()
        {
            super();
            minScreenPadding.left = MIN_SCREEN_PADDING_LEFT;
            minScreenPadding.right = MIN_SCREEN_PADDING_RIGHT;
            additionalScreenPadding.left = ADDITIONAL_SCREEN_PADDING_LEFT;
            additionalScreenPadding.right = ADDITIONAL_SCREEN_PADDING_RIGHT;
            maxFontSize = MAX_FONT_SIZE;
        }

        override public function onPopoverClose() : void
        {
            this.arrow.state = ArrowDown.STATE_NORMAL;
        }

        override public function onPopoverOpen() : void
        {
            this.arrow.state = ArrowDown.STATE_UP;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
            this.icon.source = RES_ICONS.MAPS_ICONS_BATTLETYPES_40X40_SQUAD;
        }

        override protected function updateSize() : void
        {
            bounds.width = this.icon.x + this.icon.width;
            super.updateSize();
        }

        override protected function updateData() : void
        {
            if(data)
            {
                this.textField.text = this._squadDataVo.buttonName;
            }
            else
            {
                this.textField.text = MENU.HEADERBUTTONS_BTNLABEL_CREATESQUAD;
            }
            this.icon.source = this._squadDataVo.icon;
            var _loc1_:* = wideScreenPrc > WIDE_SCREEN_PRC_BORDER;
            this.textField.visible = _loc1_;
            if(_loc1_)
            {
                if(this.isNeedUpdateFont())
                {
                    updateFontSize(this.textField,useFontSize);
                    needUpdateFontSize = false;
                }
                this.textField.width = this.textField.textWidth + TEXT_FIELD_MARGIN;
            }
            else
            {
                this.textField.width = 0;
            }
            this.arrow.visible = this._squadDataVo.isEvent;
            if(this._squadDataVo.isEvent)
            {
                this.arrow.x = 0;
                this.textField.x = SQUAD_TEXT_MARGIN + this.arrow.x + this.arrow.width + ICON_ARROW_GAP ^ 0;
            }
            else
            {
                this.textField.x = 0;
            }
            this.icon.x = this.textField.x + this.textField.width + SQUAD_ICON_MARGIN ^ 0;
            super.updateData();
        }

        override protected function onDispose() : void
        {
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
            this.textField = null;
            this.icon.dispose();
            this.icon = null;
            this._squadDataVo = null;
            this.arrow.dispose();
            this.arrow = null;
            super.onDispose();
        }

        override protected function isNeedUpdateFont() : Boolean
        {
            return super.isNeedUpdateFont() || useFontSize != this.textField.getTextFormat().size;
        }

        override public function set data(param1:Object) : void
        {
            this._squadDataVo = HBC_SquadDataVo(param1);
            super.data = param1;
        }

        private function onIconLoadCompleteHandler(param1:UILoaderEvent) : void
        {
            invalidate(InvalidationType.DATA,InvalidationType.SIZE);
        }
    }
}
