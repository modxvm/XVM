package net.wg.gui.lobby.header
{
    import net.wg.infrastructure.base.meta.impl.LobbyHeaderMeta;
    import net.wg.infrastructure.base.meta.ILobbyHeaderMeta;
    import net.wg.gui.interfaces.IHelpLayoutComponent;
    import flash.display.Sprite;
    import net.wg.gui.lobby.header.mainMenuButtonBar.MainMenuButtonBar;
    import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonBar;
    import net.wg.gui.lobby.header.mainMenuButtonBar.MainMenuHelper;
    import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonsHelper;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.header.events.HeaderEvents;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.header.headerButtonBar.HeaderButton;
    import net.wg.gui.lobby.header.vo.HeaderButtonVo;
    import net.wg.data.Aliases;
    import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
    import net.wg.data.VO.UserVO;
    import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
    import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
    import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;
    import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
    import net.wg.data.constants.IconsTypes;
    import net.wg.gui.lobby.headerTutorial.HeaderTutorialStates;
    
    public class LobbyHeader extends LobbyHeaderMeta implements ILobbyHeaderMeta, IHelpLayoutComponent
    {
        
        public function LobbyHeader()
        {
            super();
            this._headerButtonsHelper = new HeaderButtonsHelper(this.headerButtonBar);
        }
        
        public static var NARROW_SCREEN:String = "narrowScreen";
        
        public static var WIDE_SCREEN:String = "wideScreen";
        
        public static var MAX_SCREEN:String = "maxScreen";
        
        public var centerBg:Sprite = null;
        
        public var resizeBg:Sprite = null;
        
        public var mainMenuGradient:Sprite = null;
        
        public var fightBtn:FightButton;
        
        public var mainMenuButtonBar:MainMenuButtonBar;
        
        public var headerButtonBar:HeaderButtonBar;
        
        private var _mainMenuHelper:MainMenuHelper;
        
        private var _headerButtonsHelper:HeaderButtonsHelper;
        
        private var _isShowHelpLayout:Boolean = false;
        
        private var _currentScreen:String = "";
        
        private var NARROW_SCREEN_SIZE:Number = 1024;
        
        private var WIDE_SCREEN_SIZE:Number = 1280;
        
        private var MAX_SCREEN_SIZE:Number = 1600;
        
        private var _currentHeaderHelpStepId:String = "";
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            constraints = new Constraints(this,ConstrainMode.REFLOW);
            constraints.addElement("centerBg",this.centerBg,Constraints.CENTER_H);
            constraints.addElement("resizeBg",this.resizeBg,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
            constraints.addElement("fightBtn",this.fightBtn,Constraints.CENTER_H);
            constraints.addElement("mainMenuButtonBar",this.mainMenuButtonBar,Constraints.CENTER_H);
            constraints.addElement("mainMenuGradient",this.mainMenuGradient,Constraints.CENTER_H);
            this.centerBg.mouseChildren = this.centerBg.mouseEnabled = false;
            this.mainMenuGradient.mouseEnabled = false;
            this.mainMenuGradient.mouseChildren = false;
            this.hitArea = this.resizeBg;
            this._mainMenuHelper = new MainMenuHelper(this.mainMenuButtonBar);
            this.updateSize();
            this._headerButtonsHelper.setData();
            this.fightBtn.addEventListener(ButtonEvent.CLICK,this.onFightClick);
            this.headerButtonBar.updateCenterItem(this.fightBtn.getRectangle());
            this.mainMenuButtonBar.addEventListener(ButtonEvent.CLICK,this.mainMenuButtonClickHandler,false,0,true);
            this.headerButtonBar.addEventListener(ButtonEvent.CLICK,this.headerButtonClickHandler,false,0,true);
            this.headerButtonBar.addEventListener(HeaderEvents.HEADER_ITEMS_REPOSITION,this.onHeaderItemsReposition,false,0,true);
        }
        
        private function onFightClick(param1:ButtonEvent) : void
        {
            fightClickS(0,"");
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                constraints.update(width,height);
                this.updateSize();
            }
        }
        
        private function updateSize() : void
        {
            this.headerButtonBar.updateCenterItem(this.fightBtn.getRectangle());
            this._currentScreen = WIDE_SCREEN;
            var _loc1_:Number = 0;
            var _loc2_:Number = 0;
            if(App.appWidth <= this.NARROW_SCREEN_SIZE)
            {
                this._currentScreen = NARROW_SCREEN;
            }
            else if(App.appWidth >= this.WIDE_SCREEN_SIZE)
            {
                this._currentScreen = MAX_SCREEN;
                _loc1_ = 1;
                _loc2_ = Math.min((App.appWidth - this.WIDE_SCREEN_SIZE) / (this.MAX_SCREEN_SIZE - this.WIDE_SCREEN_SIZE),1);
            }
            else
            {
                _loc1_ = Math.min((App.appWidth - this.NARROW_SCREEN_SIZE) / (this.WIDE_SCREEN_SIZE - this.NARROW_SCREEN_SIZE),1);
            }
            
            this.headerButtonBar.updateScreen(this._currentScreen,App.appWidth,_loc1_,_loc2_);
        }
        
        private function onHeaderItemsReposition(param1:HeaderEvents) : void
        {
            if(this._currentHeaderHelpStepId != Values.EMPTY_STR)
            {
                this.as_highlightTutorialControls(this._currentHeaderHelpStepId);
            }
        }
        
        override protected function onDispose() : void
        {
            this.mainMenuButtonBar.removeEventListener(ButtonEvent.CLICK,this.mainMenuButtonClickHandler);
            this.mainMenuButtonBar.dispose();
            this.mainMenuButtonBar = null;
            this.headerButtonBar.removeEventListener(ButtonEvent.CLICK,this.headerButtonClickHandler);
            this.headerButtonBar.removeEventListener(HeaderEvents.HEADER_ITEMS_REPOSITION,this.onHeaderItemsReposition);
            this.headerButtonBar.dispose();
            this.headerButtonBar = null;
            this._mainMenuHelper.dispose();
            this._mainMenuHelper = null;
            this.fightBtn.removeEventListener(ButtonEvent.CLICK,this.onFightClick);
            this._headerButtonsHelper.dispose();
            this._headerButtonsHelper = null;
            super.onDispose();
        }
        
        protected function mainMenuButtonClickHandler(param1:ButtonEvent) : void
        {
            if(param1.target.data != null)
            {
                menuItemClickS(param1.target.data.value);
            }
        }
        
        protected function headerButtonClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:HeaderButton = HeaderButton(param1.target);
            var _loc3_:HeaderButtonVo = HeaderButtonVo(_loc2_.data);
            switch(_loc3_.id)
            {
                case HeaderButtonsHelper.ITEM_ID_SETTINGS:
                    showLobbyMenuS();
                    break;
                case HeaderButtonsHelper.ITEM_ID_ACCOUNT:
                    App.popoverMgr.show(_loc2_,Aliases.ACCOUNT_POPOVER,null,_loc2_);
                    break;
                case HeaderButtonsHelper.ITEM_ID_PREM:
                    showPremiumDialogS();
                    break;
                case HeaderButtonsHelper.ITEM_ID_SQUAD:
                    showSquadS();
                    break;
                case HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR:
                    App.popoverMgr.show(_loc2_,Aliases.BATTLE_TYPE_SELECT_POPOVER,null,_loc2_);
                    break;
                case HeaderButtonsHelper.ITEM_ID_GOLD:
                    onPaymentS();
                    break;
                case HeaderButtonsHelper.ITEM_ID_SILVER:
                    showExchangeWindowS();
                    break;
                case HeaderButtonsHelper.ITEM_ID_FREEXP:
                    showExchangeXPWindowS();
                    break;
            }
        }
        
        public function as_setScreen(param1:String) : void
        {
            this.mainMenuButtonBar.setDisableNav(false);
            this._mainMenuHelper.setCurrent(param1);
        }
        
        public function as_doDisableNavigation() : void
        {
            this.mainMenuButtonBar.setDisableNav(true);
        }
        
        public function as_nameResponse(param1:String, param2:String, param3:String, param4:Boolean, param5:Boolean) : void
        {
            var _loc6_:HBC_AccountDataVo = HBC_AccountDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT));
            if(_loc6_)
            {
                _loc6_.userVO = new UserVO({"fullName":param1,
                "userName":param2,
                "clanAbbrev":param3
            });
            _loc6_.isTeamKiller = param4;
            _loc6_.isClan = param5;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT);
        }
    }
    
    public function as_setClanEmblem(param1:String) : void
    {
        var _loc2_:HBC_AccountDataVo = HBC_AccountDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT));
        if(_loc2_)
        {
            _loc2_.clanEmblemId = (param1) && !(param1 == Values.EMPTY_STR)?param1:null;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT);
        }
    }
    
    public function as_setPremiumParams(param1:Boolean, param2:String, param3:String, param4:Boolean) : void
    {
        var _loc5_:HBC_PremDataVo = HBC_PremDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_PREM));
        if(_loc5_)
        {
            _loc5_.isPrem = param1;
            _loc5_.btnLabel = param2;
            _loc5_.doLabel = param3;
            _loc5_.isYear = param4;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_PREM);
        }
    }
    
    public function as_updateSquad(param1:Boolean) : void
    {
        var _loc2_:HBC_SquadDataVo = HBC_SquadDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_SQUAD));
        if(_loc2_)
        {
            _loc2_.isInSquad = param1;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_SQUAD);
        }
    }
    
    public function as_updateBattleType(param1:String, param2:String, param3:Boolean) : void
    {
        var _loc4_:HBC_BattleTypeVo = HBC_BattleTypeVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR));
        if(_loc4_)
        {
            _loc4_.battleTypeName = param1;
            _loc4_.battleTypeIcon = param2;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR);
            this.as_doDisableHeaderButton(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR,param3);
        }
    }
    
    public function as_goldResponse(param1:String) : void
    {
        var _loc2_:HBC_FinanceVo = HBC_FinanceVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_GOLD));
        if(_loc2_)
        {
            _loc2_.money = param1;
            _loc2_.iconId = IconsTypes.GOLD;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_GOLD);
        }
    }
    
    public function as_creditsResponse(param1:String) : void
    {
        var _loc2_:HBC_FinanceVo = HBC_FinanceVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_SILVER));
        if(_loc2_)
        {
            _loc2_.money = param1;
            _loc2_.iconId = IconsTypes.CREDITS;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_SILVER);
        }
    }
    
    public function as_setFreeXP(param1:String, param2:Boolean) : void
    {
        var _loc3_:HBC_FinanceVo = HBC_FinanceVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_FREEXP));
        if(_loc3_)
        {
            _loc3_.money = param1;
            _loc3_.iconId = IconsTypes.FREE_XP;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_FREEXP);
        }
    }
    
    public function as_doDisableHeaderButton(param1:String, param2:Boolean) : void
    {
        this._headerButtonsHelper.setButtonEnabled(param1,param2);
    }
    
    public function as_setWalletStatus(param1:Object) : void
    {
        App.utils.voMgr.walletStatusVO.update(param1);
        this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_GOLD);
        this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_FREEXP);
    }
    
    public function showHelpLayout() : void
    {
        if(!this._isShowHelpLayout)
        {
            this._isShowHelpLayout = true;
            App.helpLayout.createBackground();
            this.fightBtn.showHelpLayout();
            this.mainMenuButtonBar.showHelpLayout();
            this.headerButtonBar.showHelpLayout();
        }
    }
    
    public function closeHelpLayout() : void
    {
        if(this._isShowHelpLayout)
        {
            this._isShowHelpLayout = false;
            this.hideHelpLayout();
        }
    }
    
    public function as_highlightTutorialControls(param1:String) : void
    {
        this.hideHelpLayout();
        this._isShowHelpLayout = true;
        this._currentHeaderHelpStepId = param1;
        switch(param1)
        {
            case HeaderTutorialStates.STEP1:
                this.headerButtonBar.showHelpLayoutById([HeaderButtonsHelper.ITEM_ID_SETTINGS]);
                break;
            case HeaderTutorialStates.STEP2:
                this.headerButtonBar.showHelpLayoutById([HeaderButtonsHelper.ITEM_ID_ACCOUNT]);
                break;
            case HeaderTutorialStates.STEP3:
                this.headerButtonBar.showHelpLayoutById([HeaderButtonsHelper.ITEM_ID_PREM]);
                break;
            case HeaderTutorialStates.STEP4:
                this.headerButtonBar.showHelpLayoutById([HeaderButtonsHelper.ITEM_ID_SQUAD]);
                break;
            case HeaderTutorialStates.STEP5:
                this.headerButtonBar.showHelpLayoutById([HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR]);
                break;
            case HeaderTutorialStates.STEP6:
                this.headerButtonBar.showFinanceHelpLayout();
                break;
        }
    }
    
    private function hideHelpLayout() : void
    {
        this.fightBtn.closeHelpLayout();
        this.mainMenuButtonBar.closeHelpLayout();
        this.headerButtonBar.closeHelpLayout();
    }
    
    public function as_resetHighlightTutorialControls() : void
    {
        this._currentHeaderHelpStepId = Values.EMPTY_STR;
        this.closeHelpLayout();
    }
    
    private var _actualEnabledVal:Boolean;
    
    private var _isInCoolDown:Boolean = false;
    
    public function as_disableFightButton(param1:Boolean, param2:String) : void
    {
        this._actualEnabledVal = !param1;
        this.fightBtn.enabled = !this._isInCoolDown?this._actualEnabledVal:!this._isInCoolDown;
        this.fightBtn.validateNow();
        App.toolTipMgr.hide();
    }
    
    public function as_setFightButton(param1:String) : void
    {
        this.fightBtn.label = param1;
        this.fightBtn.validateNow();
    }
    
    public function as_setCoolDownForReady(param1:uint) : void
    {
        this._isInCoolDown = true;
        App.utils.scheduler.cancelTask(this.stopReadyCoolDown);
        this.fightBtn.enabled = false;
        App.utils.scheduler.scheduleTask(this.stopReadyCoolDown,param1 * 1000);
    }
    
    private function stopReadyCoolDown() : void
    {
        this._isInCoolDown = false;
        this.fightBtn.enabled = this._actualEnabledVal;
    }
}
}
