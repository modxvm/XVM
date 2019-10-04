package net.wg.gui.lobby.header.headerButtonBar
{
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.lobby.components.ArrowDown;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;
    import net.wg.gui.lobby.header.LobbyHeader;
    import net.wg.gui.events.UILoaderEvent;
    import scaleform.clik.constants.InvalidationType;

    public class HBC_BattleSelector extends HeaderButtonContentItem
    {

        private static const MAX_TEXT_WIDTH_NARROW_SCREEN:int = 104;

        private static const MAX_TEXT_WIDTH_WIDE_SCREEN:int = 40;

        private static const MAX_TEXT_WIDTH_MAX_SCREEN:int = 500;

        private static const WIDTH_FOR_TEXT:int = 150;

        public var textField:TextField = null;

        public var icon:UILoaderAlt = null;

        public var arrow:ArrowDown = null;

        public var rankedBattlesBgAnim:MovieClip = null;

        private var _battleTypeVo:HBC_BattleTypeVo = null;

        private var _iconWidth:int = 0;

        public function HBC_BattleSelector()
        {
            super();
            minScreenPadding.left = 10;
            minScreenPadding.right = 10;
            additionalScreenPadding.left = 0;
            additionalScreenPadding.right = 4;
            maxFontSize = 14;
            this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
            this.icon.addEventListener(UILoaderEvent.IOERROR,this.onIconLoadIoerrorHandler);
        }

        override public function onPopoverClose() : void
        {
            this.arrow.state = ArrowDown.STATE_NORMAL;
        }

        override public function onPopoverOpen() : void
        {
            this.arrow.state = ArrowDown.STATE_UP;
        }

        override protected function updateSize() : void
        {
            bounds.width = this.arrow.x + this.arrow.width;
            super.updateSize();
        }

        override protected function updateData() : void
        {
            var _loc2_:* = false;
            var _loc3_:* = NaN;
            var _loc1_:Boolean = this.rankedBattlesBgAnim.visible;
            if(data)
            {
                this.icon.source = this._battleTypeVo.battleTypeIcon;
                _loc2_ = availableWidth > WIDTH_FOR_TEXT || wideScreenPrc > WIDE_SCREEN_PRC_BORDER;
                this.textField.visible = _loc2_;
                if(_loc2_)
                {
                    this.textField.x = this._battleTypeVo.battleTypeIcon?this._iconWidth?this.icon.x + this._iconWidth:this.icon.x + this.icon.width + ICON_MARGIN:0;
                    _loc3_ = -this.textField.x + MAX_TEXT_WIDTH_NARROW_SCREEN;
                    switch(screen)
                    {
                        case LobbyHeader.WIDE_SCREEN:
                            _loc3_ = _loc3_ + wideScreenPrc * MAX_TEXT_WIDTH_WIDE_SCREEN;
                            break;
                        case LobbyHeader.MAX_SCREEN:
                            _loc3_ = _loc3_ + (wideScreenPrc * MAX_TEXT_WIDTH_WIDE_SCREEN + maxScreenPrc * MAX_TEXT_WIDTH_MAX_SCREEN);
                            break;
                    }
                    if(availableWidth > 0)
                    {
                        _loc3_ = availableWidth - (TEXT_FIELD_MARGIN + ARROW_MARGIN + this.textField.x + this.arrow.width);
                    }
                    this.textField.width = _loc3_;
                    if(this.isNeedUpdateFont())
                    {
                        updateFontSize(this.textField,useFontSize);
                        needUpdateFontSize = false;
                    }
                    App.utils.commons.formatPlayerName(this.textField,App.utils.commons.getUserProps(this._battleTypeVo.battleTypeName));
                    this.textField.width = this.textField.textWidth + TEXT_FIELD_MARGIN;
                    this.arrow.x = this.textField.x + this.textField.width + ARROW_MARGIN ^ 0;
                }
                else
                {
                    this.arrow.x = this.icon.x + this.icon.width + (ARROW_MARGIN >> 1);
                }
                if(this._battleTypeVo.eventBgEnabled)
                {
                    if(!_loc1_)
                    {
                        this.rankedBattlesBgAnim.play();
                    }
                }
                this.rankedBattlesBgAnim.visible = this._battleTypeVo.eventBgEnabled;
            }
            else if(_loc1_)
            {
                this.hideRankedBattlesBgAnim();
            }
            super.updateData();
        }

        override protected function isNeedUpdateFont() : Boolean
        {
            return super.isNeedUpdateFont() || useFontSize != this.textField.getTextFormat().size;
        }

        override protected function onDispose() : void
        {
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
            this.icon.removeEventListener(UILoaderEvent.IOERROR,this.onIconLoadIoerrorHandler);
            this._battleTypeVo = null;
            this.textField.filters = null;
            this.textField = null;
            this.icon.dispose();
            this.icon = null;
            this.arrow.dispose();
            this.arrow = null;
            this.rankedBattlesBgAnim = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.rankedBattlesBgAnim.mouseEnabled = this.rankedBattlesBgAnim.mouseChildren = false;
            this.hideRankedBattlesBgAnim();
        }

        private function hideRankedBattlesBgAnim() : void
        {
            this.rankedBattlesBgAnim.visible = false;
            this.rankedBattlesBgAnim.stop();
        }

        override public function set data(param1:Object) : void
        {
            this._battleTypeVo = HBC_BattleTypeVo(param1);
            if(!this._battleTypeVo.battleTypeIcon)
            {
                this._iconWidth = 0;
            }
            super.data = param1;
        }

        private function onIconLoadIoerrorHandler(param1:UILoaderEvent) : void
        {
            this._iconWidth = 0;
            invalidate(InvalidationType.DATA,InvalidationType.SIZE);
        }

        private function onIconLoadCompleteHandler(param1:UILoaderEvent) : void
        {
            this._iconWidth = param1.target.width;
            invalidate(InvalidationType.DATA,InvalidationType.SIZE);
        }
    }
}
