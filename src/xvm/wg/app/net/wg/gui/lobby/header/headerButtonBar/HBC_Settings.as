package net.wg.gui.lobby.header.headerButtonBar
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import net.wg.gui.lobby.header.vo.HBC_SettingsVo;
    import scaleform.clik.utils.Padding;
    
    public class HBC_Settings extends HeaderButtonContentItem
    {
        
        public function HBC_Settings()
        {
            this._minScreenPaddingIfTextMoreIco = new Padding(0,6,0,6);
            this._minScreenPaddingIfIcoMoreText = new Padding(0,1,0,1);
            super();
            _minScreenPadding.left = 1;
            _minScreenPadding.right = 1;
        }
        
        public var icon:Sprite;
        
        public var serverName:TextField;
        
        private var _settingsDataVo:HBC_SettingsVo = null;
        
        private var _minScreenPaddingIfTextMoreIco:Padding;
        
        private var _minScreenPaddingIfIcoMoreText:Padding;
        
        override protected function updateSize() : void
        {
            bounds.width = Math.max(this.icon.x + this.icon.width,this.serverName.x + this.serverName.textWidth);
            super.updateSize();
        }
        
        override protected function updateData() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            if(data)
            {
                this.serverName.text = this._settingsDataVo.serverName;
                this.icon.x = 0;
                _loc1_ = this.serverName.textWidth ^ 0;
                _loc2_ = (this.icon.width - _loc1_) / 2 ^ 0;
                if(_loc2_ < 0)
                {
                    _loc2_ = 0;
                    this.icon.x = (_loc1_ - this.icon.width) / 2 ^ 0;
                    _minScreenPadding = this._minScreenPaddingIfTextMoreIco;
                }
                else
                {
                    _minScreenPadding = this._minScreenPaddingIfIcoMoreText;
                }
                this.serverName.x = _loc2_;
                this.serverName.width = this.serverName.textWidth + TEXT_FIELD_MARGIN;
            }
            super.updateData();
        }
        
        override public function set data(param1:Object) : void
        {
            this._settingsDataVo = HBC_SettingsVo(param1);
            super.data = param1;
        }
    }
}
