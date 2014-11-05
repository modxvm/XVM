package net.wg.gui.lobby.header
{
    import net.wg.infrastructure.base.meta.impl.AccountPopoverMeta;
    import net.wg.infrastructure.base.meta.IAccountPopoverMeta;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.UserNameField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.data.VO.UserVO;
    import net.wg.gui.lobby.header.vo.AccountPopoverBlockVo;
    import net.wg.gui.lobby.header.vo.AccountPopoverReferralBlockVO;
    import net.wg.gui.components.advanced.StatisticItem;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.components.popOvers.PopOverConst;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.components.advanced.vo.StatisticItemVo;
    import net.wg.data.constants.ColorSchemeNames;
    import flash.display.InteractiveObject;
    
    public class AccountPopover extends AccountPopoverMeta implements IAccountPopoverMeta
    {
        
        public function AccountPopover()
        {
            super();
        }
        
        public var separator:Sprite = null;
        
        public var userName:UserNameField = null;
        
        public var allAchievements:SoundButtonEx = null;
        
        public var clanInfo:AccountPopoverBlock = null;
        
        public var crewInfo:AccountPopoverBlock = null;
        
        public var referralInfo:AccountPopoverReferralBlock = null;
        
        private var _userVo:UserVO = null;
        
        private var _isTeamKiller:Boolean = false;
        
        private var _infoBtnEnabled:Boolean = false;
        
        private var _mainData:Array = null;
        
        private var _clanData:AccountPopoverBlockVo = null;
        
        private var _crewData:AccountPopoverBlockVo = null;
        
        private var _clanEmblemId:String = null;
        
        private var _crewEmblemId:String = null;
        
        private var _referralData:AccountPopoverReferralBlockVO = null;
        
        private var BLOCK_MARGIN:Number = 18;
        
        private var BTN_MARGIN:Number = 9;
        
        private var statItems:Vector.<StatisticItem> = null;
        
        private var STATS_ITEMS_START_X_POS:Number = 13;
        
        private var STATS_ITEMS_START_Y_POS:Number = 67;
        
        private var STATS_ITEMS_MARGIN:Number = 0;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.allAchievements.label = MENU.HEADER_ACCOUNT_POPOVER_TOALLPROGRESS;
            this.allAchievements.addEventListener(ButtonEvent.CLICK,this.onBtnClick);
            this.clanInfo.doActionBtn.addEventListener(ButtonEvent.CLICK,this.onBtnClick);
            this.crewInfo.doActionBtn.addEventListener(ButtonEvent.CLICK,this.onBtnClick);
        }
        
        private function onBtnClick(param1:ButtonEvent) : void
        {
            switch(param1.currentTarget)
            {
                case this.allAchievements:
                    openProfileS();
                    break;
                case this.clanInfo.doActionBtn:
                    openClanStatisticS();
                    break;
                case this.crewInfo.doActionBtn:
                    openCrewStatisticS();
                    break;
                case this.referralInfo.moreInfoLinkBtn:
                    openReferralManagementS();
                    break;
            }
        }
        
        override protected function initLayout() : void
        {
            popoverLayout.preferredLayout = PopOverConst.ARROW_TOP;
            super.initLayout();
        }
        
        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            if(isInvalid(InvalidationType.DATA))
            {
                _loc1_ = this.updateData();
                this.height = _loc1_;
            }
            super.draw();
        }
        
        private function updateData() : Number
        {
            var _loc3_:* = NaN;
            var _loc4_:StatisticItemVo = null;
            var _loc5_:StatisticItem = null;
            this.userName.textColor = this._isTeamKiller?App.colorSchemeMgr.getScheme(ColorSchemeNames.TEAMKILLER).rgb:UserNameField.DEF_USER_NAME_COLOR;
            this.userName.userVO = this._userVo;
            var _loc1_:Number = this.STATS_ITEMS_START_Y_POS;
            if(this.statItems)
            {
                this.clearStatsItems();
            }
            this.statItems = new Vector.<StatisticItem>();
            if((this._mainData) && this._mainData.length > 0)
            {
                _loc3_ = 0;
                while(_loc3_ < this._mainData.length)
                {
                    _loc4_ = new StatisticItemVo(App.utils.commons.cloneObject(this._mainData[_loc3_]));
                    _loc5_ = App.utils.classFactory.getComponent("statsItem_UI",StatisticItem);
                    _loc5_.x = this.STATS_ITEMS_START_X_POS;
                    _loc5_.y = _loc1_ ^ 0;
                    _loc5_.setData(_loc4_);
                    _loc5_.validateNow();
                    _loc1_ = _loc1_ + (_loc5_.height + this.STATS_ITEMS_MARGIN);
                    this.statItems.push(_loc5_);
                    this.addChild(_loc5_);
                    _loc3_++;
                }
            }
            this.allAchievements.y = _loc1_ + this.BTN_MARGIN ^ 0;
            this.allAchievements.enabled = this._infoBtnEnabled;
            var _loc2_:Number = this.allAchievements.y + this.allAchievements.height + this.BLOCK_MARGIN;
            if(this._clanData)
            {
                this._clanData.emblemId = this._clanEmblemId;
                this.clanInfo.visible = true;
                this.clanInfo.setData(this._clanData);
                this.clanInfo.y = _loc2_ ^ 0;
                this.clanInfo.validateNow();
                _loc2_ = _loc2_ + (this.clanInfo.height + this.BLOCK_MARGIN);
            }
            else
            {
                this.clanInfo.y = 0;
                this.clanInfo.visible = false;
            }
            if(this._crewData)
            {
                this._crewData.emblemId = this._crewEmblemId;
                this.crewInfo.visible = true;
                this.crewInfo.setData(this._crewData);
                this.crewInfo.y = _loc2_ ^ 0;
                this.crewInfo.validateNow();
                _loc2_ = _loc2_ + (this.crewInfo.height + this.BLOCK_MARGIN);
            }
            else
            {
                this.crewInfo.y = 0;
                this.crewInfo.visible = false;
            }
            if(this._referralData)
            {
                this.referralInfo.moreInfoLinkBtn.addEventListener(ButtonEvent.CLICK,this.onBtnClick);
                this.referralInfo.setData(this._referralData);
                this.referralInfo.visible = true;
                this.referralInfo.y = _loc2_ ^ 0;
                _loc2_ = _loc2_ + (this.referralInfo.height + this.BLOCK_MARGIN);
            }
            else
            {
                this.referralInfo.moreInfoLinkBtn.removeEventListener(ButtonEvent.CLICK,this.onBtnClick);
                this.referralInfo.y = 0;
                this.referralInfo.visible = false;
            }
            return _loc2_;
        }
        
        private function clearStatsItems() : void
        {
            var _loc1_:StatisticItem = null;
            if(this.statItems)
            {
                while(this.statItems.length > 0)
                {
                    _loc1_ = this.statItems.pop();
                    this.removeChild(_loc1_);
                    _loc1_.dispose();
                    _loc1_ = null;
                }
            }
            this.statItems = null;
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this);
        }
        
        override protected function onDispose() : void
        {
            this.allAchievements.removeEventListener(ButtonEvent.CLICK,this.onBtnClick);
            this.clanInfo.doActionBtn.removeEventListener(ButtonEvent.CLICK,this.onBtnClick);
            this.crewInfo.doActionBtn.removeEventListener(ButtonEvent.CLICK,this.onBtnClick);
            this.referralInfo.moreInfoLinkBtn.removeEventListener(ButtonEvent.CLICK,this.onBtnClick);
            this.clearStatsItems();
            this._userVo.dispose();
            this._userVo = null;
            if(this._mainData)
            {
                while(this._mainData.length)
                {
                    this._mainData.pop();
                }
                this._mainData = null;
            }
            if(this._clanData)
            {
                this._clanData.dispose();
                this._clanData = null;
            }
            if(this._crewData)
            {
                this._crewData.dispose();
                this._crewData = null;
            }
            if(this._referralData)
            {
                this._referralData.dispose();
                this._referralData = null;
            }
            this.userName.dispose();
            this.userName = null;
            this.clanInfo.dispose();
            this.clanInfo = null;
            this.crewInfo.dispose();
            this.crewInfo = null;
            this.referralInfo.dispose();
            this.referralInfo = null;
            super.onDispose();
        }
        
        public function as_setData(param1:Object, param2:Boolean, param3:Array, param4:Boolean, param5:Object, param6:Object) : void
        {
            this._userVo = new UserVO(param1);
            this._isTeamKiller = param2;
            this._infoBtnEnabled = param4;
            this._mainData = param3;
            this._clanData = param5?new AccountPopoverBlockVo(param5):null;
            this._crewData = param6?new AccountPopoverBlockVo(param6):null;
            invalidateData();
        }
        
        public function as_setClanEmblem(param1:String) : void
        {
            if(this._clanEmblemId == param1)
            {
                return;
            }
            this._clanEmblemId = param1;
            invalidateData();
        }
        
        public function as_setCrewEmblem(param1:String) : void
        {
            if(this._crewEmblemId == param1)
            {
                return;
            }
            this._crewEmblemId = param1;
            invalidateData();
        }
        
        override protected function setReferralData(param1:AccountPopoverReferralBlockVO) : void
        {
            this._referralData = param1;
            invalidateData();
        }
    }
}
