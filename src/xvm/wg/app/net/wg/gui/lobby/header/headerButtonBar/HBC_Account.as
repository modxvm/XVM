package net.wg.gui.lobby.header.headerButtonBar
{
    import net.wg.gui.components.controls.UserNameField;
    import flash.display.MovieClip;
    import net.wg.gui.components.advanced.ClanEmblem;
    import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
    import net.wg.data.constants.ColorSchemeNames;
    import net.wg.gui.lobby.header.LobbyHeader;
    
    public class HBC_Account extends HeaderButtonContentItem
    {
        
        public function HBC_Account()
        {
            super();
            _minScreenPadding.left = 9;
            _minScreenPadding.right = 12;
            _additionalScreenPadding.left = 0;
            _additionalScreenPadding.right = 6;
        }
        
        public var userName:UserNameField = null;
        
        public var arrow:MovieClip = null;
        
        public var clanEmblem:ClanEmblem = null;
        
        private var _accountVo:HBC_AccountDataVo = null;
        
        private var MAX_WIDTH_NARROW:Number = 120;
        
        private var MAX_WIDTH_WIDE:Number = 60;
        
        private var CLAN_EMBLEM_MARGIN:Number = 5;
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        override protected function updateSize() : void
        {
            bounds.width = this.arrow.x + this.arrow.width;
            super.updateSize();
        }
        
        override protected function updateData() : void
        {
            var _loc1_:* = NaN;
            if(data)
            {
                this.userName.textColor = this._accountVo.isTeamKiller?App.colorSchemeMgr.getScheme(ColorSchemeNames.TEAMKILLER).rgb:UserNameField.DEF_USER_NAME_COLOR;
                if(this._accountVo.clanEmblemId)
                {
                    this.clanEmblem.setImage(this._accountVo.clanEmblemId);
                    if(screen == LobbyHeader.MAX_SCREEN)
                    {
                        this.userName.x = this.clanEmblem.x + this.clanEmblem.width + this.CLAN_EMBLEM_MARGIN;
                        this.clanEmblem.alpha = 1;
                    }
                    else
                    {
                        this.userName.x = this.clanEmblem.width >> 2;
                        this.clanEmblem.alpha = 0.6;
                    }
                }
                else
                {
                    this.userName.x = this.clanEmblem.x + 7;
                }
                this.clanEmblem.visible = Boolean(this._accountVo.clanEmblemId);
                if(this._accountVo.userVO)
                {
                    _loc1_ = 0;
                    if(availableWidth > 0)
                    {
                        _loc1_ = availableWidth - (this.userName.x + ARROW_MARGIN + this.arrow.width);
                    }
                    else
                    {
                        _loc1_ = screen == LobbyHeader.NARROW_SCREEN?this.MAX_WIDTH_NARROW:this.MAX_WIDTH_NARROW + _wideScreenPrc * this.MAX_WIDTH_WIDE;
                    }
                    this.userName.width = _loc1_;
                    this.userName.userVO = this._accountVo.userVO;
                    this.userName.validateNow();
                }
                this.arrow.x = this.userName.x + this.userName.textField.textWidth + ARROW_MARGIN ^ 0;
            }
            super.updateData();
        }
        
        override protected function onDispose() : void
        {
            this._accountVo = null;
            super.onDispose();
        }
        
        override public function set data(param1:Object) : void
        {
            this._accountVo = HBC_AccountDataVo(param1);
            super.data = param1;
        }
    }
}
