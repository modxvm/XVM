package net.wg.gui.lobby.header.headerButtonBar
{
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;
    import net.wg.gui.events.UILoaderEvent;
    import net.wg.gui.lobby.header.LobbyHeader;
    
    public class HBC_BattleSelector extends HeaderButtonContentItem
    {
        
        public function HBC_BattleSelector()
        {
            super();
            _minScreenPadding.left = 10;
            _minScreenPadding.right = 10;
            _additionalScreenPadding.left = 0;
            _additionalScreenPadding.right = 4;
            _maxFontSize = 14;
            _hideDisplayObjList.push(this.icon);
            this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIcoLoaded);
        }
        
        public var textField:TextField = null;
        
        public var icon:UILoaderAlt = null;
        
        public var arrow:MovieClip = null;
        
        private var _battleTypeVo:HBC_BattleTypeVo = null;
        
        private var MAX_TEXT_WIDTH_NARROW_SCREEN:Number = 104;
        
        private var MAX_TEXT_WIDTH_WIDE_SCREEN:Number = 40;
        
        private var MAX_TEXT_WIDTH_MAX_SCREEN:Number = 500;
        
        private function onIcoLoaded(param1:UILoaderEvent) : void
        {
            this.updateData();
        }
        
        override protected function updateSize() : void
        {
            bounds.width = this.arrow.x + this.arrow.width;
            super.updateSize();
        }
        
        override protected function updateData() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            if(data)
            {
                this.textField.x = this.icon.visible?this.icon.x + this.icon.width + ICON_MARGIN:0;
                this.icon.source = this._battleTypeVo.battleTypeIcon;
                _loc1_ = -this.textField.x;
                switch(screen)
                {
                    case LobbyHeader.NARROW_SCREEN:
                        _loc1_ = _loc1_ + this.MAX_TEXT_WIDTH_NARROW_SCREEN;
                        break;
                    case LobbyHeader.WIDE_SCREEN:
                        _loc1_ = _loc1_ + (this.MAX_TEXT_WIDTH_NARROW_SCREEN + _wideScreenPrc * this.MAX_TEXT_WIDTH_WIDE_SCREEN);
                        break;
                    case LobbyHeader.MAX_SCREEN:
                        _loc1_ = _loc1_ + (this.MAX_TEXT_WIDTH_NARROW_SCREEN + _wideScreenPrc * this.MAX_TEXT_WIDTH_WIDE_SCREEN + _maxScreenPrc * this.MAX_TEXT_WIDTH_MAX_SCREEN);
                        break;
                }
                if(availableWidth > 0)
                {
                    _loc2_ = availableWidth - (TEXT_FIELD_MARGIN + ARROW_MARGIN + this.textField.x + this.arrow.width);
                    _loc1_ = _loc2_;
                }
                this.textField.width = _loc1_;
                if(this.isNeedUpdateFont())
                {
                    updateFontSize(this.textField,useFontSize);
                    needUpdateFontSize = false;
                }
                App.utils.commons.formatPlayerName(this.textField,App.utils.commons.getUserProps(this._battleTypeVo.battleTypeName));
                this.textField.width = this.textField.textWidth + TEXT_FIELD_MARGIN;
                this.arrow.x = this.textField.x + this.textField.width + ARROW_MARGIN ^ 0;
            }
            super.updateData();
        }
        
        override protected function isNeedUpdateFont() : Boolean
        {
            return (super.isNeedUpdateFont()) || !(useFontSize == this.textField.getTextFormat().size);
        }
        
        override protected function onDispose() : void
        {
            this._battleTypeVo = null;
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIcoLoaded);
            super.onDispose();
        }
        
        override public function set data(param1:Object) : void
        {
            this._battleTypeVo = HBC_BattleTypeVo(param1);
            super.data = param1;
        }
    }
}
