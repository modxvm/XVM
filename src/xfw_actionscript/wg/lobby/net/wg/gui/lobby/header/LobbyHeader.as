package net.wg.gui.lobby.header
{
    import net.wg.infrastructure.base.meta.impl.LobbyHeaderMeta;
    import net.wg.gui.lobby.header.interfaces.ILobbyHeader;
    import net.wg.data.constants.Values;
    import flash.display.Sprite;
    import net.wg.gui.tutorial.components.TutorialClip;
    import net.wg.gui.lobby.header.rankedBattles.SparkAnim;
    import net.wg.gui.components.controls.FightButton;
    import net.wg.gui.lobby.header.mainMenuButtonBar.MainMenuButtonBar;
    import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonBar;
    import net.wg.gui.lobby.header.headerButtonBar.HeaderButtonsHelper;
    import net.wg.gui.components.tooltips.ToolTipComplex;
    import net.wg.utils.IUtils;
    import net.wg.utils.ICounterManager;
    import net.wg.utils.IScheduler;
    import flash.geom.Rectangle;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.ConstrainMode;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.MouseEvent;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.header.vo.AccountDataVo;
    import net.wg.gui.lobby.header.vo.HBC_AccountDataVo;
    import net.wg.data.VO.UserVO;
    import net.wg.gui.lobby.header.vo.AccountBoosterVO;
    import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
    import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
    import net.wg.gui.components.controls.VO.BadgeVisualVO;
    import scaleform.clik.controls.Button;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
    import net.wg.gui.lobby.header.vo.HBC_PremShopVO;
    import net.wg.gui.lobby.header.vo.HBC_SettingsVo;
    import net.wg.data.managers.impl.TooltipProps;
    import net.wg.data.constants.BaseTooltips;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.lobby.header.vo.HBC_BattleTypeVo;
    import net.wg.gui.lobby.header.vo.HBC_SquadDataVo;
    import net.wg.gui.lobby.header.headerButtonBar.HeaderButton;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.gui.lobby.header.vo.HeaderButtonVo;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import net.wg.data.Aliases;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.lobby.header.vo.HangarMenuTabItemVO;

    public class LobbyHeader extends LobbyHeaderMeta implements ILobbyHeader
    {

        public static const NARROW_SCREEN:String = "narrowScreen";

        public static const WIDE_SCREEN:String = "wideScreen";

        public static const MAX_SCREEN:String = "maxScreen";

        private static const NARROW_SCREEN_SIZE:int = 1024;

        private static const WIDE_SCREEN_SIZE:int = 1280;

        private static const MAX_SCREEN_SIZE:int = 1600;

        private static const BUBBLE_TOOLTIP_X:int = 16;

        private static const BUBBLE_TOOLTIP_Y:int = 7;

        private static const EMPTY_ACTION:String = Values.EMPTY_STR;

        private static const SPARKS_OFFSET_X:int = 50;

        private static const SPARKS_OFFSET_Y:int = -10;

        private static const OPTIMIZE_OFFSET:int = 10;

        private static const BG_OVERLAY_ONLY:uint = 1;

        private static const BUTTON_BAR_ONLY:uint = 2;

        private static const ONLINE_COUNTER_ONLY:uint = 4;

        public var centerBg:Sprite = null;

        public var centerMenuBg:TutorialClip = null;

        public var resizeBg:Sprite = null;

        public var sparks:SparkAnim = null;

        public var mainMenuGradient:Sprite = null;

        public var fightBtn:FightButton;

        public var mainMenuButtonBar:MainMenuButtonBar;

        public var headerButtonBar:HeaderButtonBar;

        public var onlineCounter:OnlineCounter;

        private var _headerButtonsHelper:HeaderButtonsHelper;

        // XFW
        public function get xfw_headerButtonsHelper():HeaderButtonsHelper
        {
            return _headerButtonsHelper;
        }

        private var _bubbleTooltip:ToolTipComplex;

        private var _actualEnabledVal:Boolean;

        private var _isInCoolDown:Boolean = false;

        private var _fightBtnTooltipStr:String = "";

        private var _isFigthButtonSpecialTooltip:Boolean = false;

        private var _utils:IUtils = null;

        private var _counterManager:ICounterManager = null;

        private var _scheduler:IScheduler = null;

        public function LobbyHeader()
        {
            super();
            this._utils = App.utils;
            this._counterManager = this._utils.counterManager;
            this._scheduler = this._utils.scheduler;
            this._headerButtonsHelper = new HeaderButtonsHelper(this.headerButtonBar);
        }

        override public function getRectangles() : Vector.<Rectangle>
        {
            if(!visible)
            {
                return null;
            }
            var _loc1_:Rectangle = this.resizeBg.getBounds(App.stage);
            _loc1_.width = App.appWidth;
            _loc1_.height = _loc1_.height - OPTIMIZE_OFFSET;
            return new <Rectangle>[_loc1_];
        }

        override protected function configUI() : void
        {
            super.configUI();
            constraints = new Constraints(this,ConstrainMode.REFLOW);
            constraints.addElement(this.centerBg.name,this.centerBg,Constraints.CENTER_H);
            constraints.addElement(this.centerMenuBg.name,this.centerMenuBg,Constraints.CENTER_H);
            constraints.addElement(this.resizeBg.name,this.resizeBg,Constraints.LEFT | Constraints.RIGHT | Constraints.TOP);
            constraints.addElement(this.fightBtn.name,this.fightBtn,Constraints.CENTER_H);
            constraints.addElement(this.mainMenuButtonBar.name,this.mainMenuButtonBar,Constraints.CENTER_H);
            constraints.addElement(this.mainMenuGradient.name,this.mainMenuGradient,Constraints.CENTER_H);
            this.centerBg.mouseChildren = this.centerBg.mouseEnabled = false;
            this.centerMenuBg.mouseChildren = this.centerMenuBg.mouseEnabled = false;
            this.mainMenuGradient.mouseEnabled = false;
            this.mainMenuGradient.mouseChildren = false;
            this.hitArea = this.resizeBg;
            this.updateSize();
            this._headerButtonsHelper.invalidateAllData();
            this.fightBtn.addEventListener(ButtonEvent.CLICK,this.onFightBtnClickHandler);
            this.headerButtonBar.updateCenterItem(this.fightBtn.getRectangle());
            this.mainMenuButtonBar.addEventListener(ButtonEvent.CLICK,this.onMainMenuButtonBarClickHandler,false,0,true);
            this.headerButtonBar.addEventListener(ButtonEvent.CLICK,this.onHeaderButtonBarClickHandler,false,0,true);
            this.fightBtn.mouseEnabledOnDisabled = true;
            _deferredDispose = true;
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

        override protected function onBeforeDispose() : void
        {
            this.disposeBubbleToolTip();
            this.mainMenuButtonBar.removeEventListener(ButtonEvent.CLICK,this.onMainMenuButtonBarClickHandler);
            this.headerButtonBar.removeEventListener(ButtonEvent.CLICK,this.onHeaderButtonBarClickHandler);
            this.fightBtn.removeEventListener(ButtonEvent.CLICK,this.onFightBtnClickHandler);
            this.fightBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onFightBtnMouseOverHandler);
            this.fightBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.onFightBtnMouseOutHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.sparks = null;
            this._scheduler.cancelTask(this.stopReadyCoolDown);
            var _loc1_:int = this.mainMenuButtonBar.dataProvider.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                this._counterManager.removeCounter(this.mainMenuButtonBar.getButtonAt(_loc2_));
                _loc2_++;
            }
            this.mainMenuButtonBar.dispose();
            this.mainMenuButtonBar = null;
            this.headerButtonBar.dispose();
            this.headerButtonBar = null;
            this.fightBtn.dispose();
            this.fightBtn = null;
            this._headerButtonsHelper.dispose();
            this._headerButtonsHelper = null;
            this.onlineCounter.dispose();
            this.onlineCounter = null;
            this.mainMenuGradient = null;
            this.resizeBg = null;
            this.centerBg = null;
            this.centerMenuBg.dispose();
            this.centerMenuBg = null;
            this._counterManager = null;
            this._scheduler = null;
            this._utils = null;
            super.onDispose();
        }

        override protected function setHangarMenuData(param1:DataProvider) : void
        {
            this.mainMenuButtonBar.dataProvider = param1;
            this.mainMenuButtonBar.validateNow();
        }

        override protected function setHeaderButtons(param1:Vector.<String>) : void
        {
            this._headerButtonsHelper.setupButtons(param1);
        }

        override protected function nameResponse(param1:AccountDataVo) : void
        {
            var _loc2_:HBC_AccountDataVo = HBC_AccountDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT));
            if(_loc2_ != null)
            {
                if(_loc2_.userVO != null)
                {
                    _loc2_.userVO.dispose();
                }
                _loc2_.userVO = new UserVO({
                    "fullName":param1.userVO.fullName,
                    "userName":param1.userVO.userName,
                    "clanAbbrev":param1.userVO.clanAbbrev
                });
                _loc2_.isTeamKiller = param1.isTeamKiller;
                _loc2_.tooltip = param1.tooltip;
                _loc2_.tooltipType = param1.tooltipType;
                this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT);
            }
        }

        public function as_updateAnonymizedState(param1:Boolean) : void
        {
            var _loc2_:HBC_AccountDataVo = HBC_AccountDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT));
            if(_loc2_ != null)
            {
                _loc2_.isAnonymized = param1;
                this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT);
            }
        }

        override protected function setBoosterData(param1:AccountBoosterVO) : void
        {
            var _loc2_:HBC_AccountDataVo = HBC_AccountDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT));
            if(_loc2_ != null)
            {
                _loc2_.hasActiveBooster = param1.hasActiveBooster;
                _loc2_.hasAvailableBoosters = param1.hasAvailableBoosters;
                _loc2_.boosterIcon = param1.boosterIcon;
                _loc2_.boosterText = param1.boosterText;
                _loc2_.boosterBg = param1.boosterBg;
                this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT);
            }
        }

        override protected function updateWalletBtn(param1:String, param2:HBC_FinanceVo) : void
        {
            this._headerButtonsHelper.setContentData(param1,param2);
        }

        override protected function setPremiumParams(param1:HBC_PremDataVo) : void
        {
            var _loc2_:HBC_PremDataVo = HBC_PremDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_PREM));
            if(_loc2_)
            {
                _loc2_.btnLabel = param1.btnLabel;
                _loc2_.btnLabelShort = param1.btnLabelShort;
                _loc2_.doLabel = param1.doLabel;
                _loc2_.timeLabel = param1.timeLabel;
                _loc2_.isHasAction = param1.isHasAction;
                _loc2_.isPremium = param1.isPremium;
                _loc2_.isSubscription = param1.isSubscription;
                _loc2_.premiumIcon = param1.premiumIcon;
                _loc2_.tooltip = param1.tooltip;
                _loc2_.tooltipType = param1.tooltipType;
                this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_PREM);
            }
        }

        override protected function setBadge(param1:BadgeVisualVO, param2:Boolean) : void
        {
            var _loc3_:HBC_AccountDataVo = this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT) as HBC_AccountDataVo;
            if(_loc3_ != null)
            {
                _loc3_.badgeVO = param1;
                _loc3_.selectedBadge = param2;
                this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_ACCOUNT);
            }
        }

        public function as_disableFightButton(param1:Boolean) : void
        {
            this._actualEnabledVal = !param1;
            this.fightBtn.enabled = !this._isInCoolDown?this._actualEnabledVal:!this._isInCoolDown;
            this.fightBtn.validateNow();
        }

        public function as_doDeselectHeaderButton(param1:String) : void
        {
            this.mainMenuButtonBar.deselectHeaderButton(param1);
        }

        public function as_doDisableHeaderButton(param1:String, param2:Boolean) : void
        {
            this._headerButtonsHelper.setButtonEnabled(param1,param2);
        }

        public function as_doDisableNavigation() : void
        {
            this.mainMenuButtonBar.setDisableNav(true);
        }

        public function as_hideMenu(param1:Boolean) : void
        {
            this.centerMenuBg.visible = !param1;
            this.onlineCounter.visible = !param1;
            this.mainMenuGradient.visible = !param1;
            this.mainMenuButtonBar.visible = !param1;
        }

        public function as_initOnlineCounter(param1:Boolean) : void
        {
            this.onlineCounter.initVisible(param1);
        }

        public function as_removeButtonCounter(param1:String) : void
        {
            var _loc2_:Button = this.mainMenuButtonBar.getButtonByValue(param1);
            this.assertMainMenuButtonWasntFound(_loc2_,param1);
            this._counterManager.removeCounter(_loc2_);
        }

        public function as_setButtonCounter(param1:String, param2:String) : void
        {
            var _loc3_:Button = this.mainMenuButtonBar.getButtonByValue(param1);
            if(_loc3_ == null)
            {
                this.mainMenuButtonBar.validateNow();
                _loc3_ = this.mainMenuButtonBar.getButtonByValue(param1);
            }
            this.assertMainMenuButtonWasntFound(_loc3_,param1);
            this._counterManager.setCounter(_loc3_,param2);
        }

        public function as_setCoolDownForReady(param1:uint) : void
        {
            this._isInCoolDown = true;
            this._scheduler.cancelTask(this.stopReadyCoolDown);
            this.fightBtn.enabled = false;
            this._scheduler.scheduleTask(this.stopReadyCoolDown,param1 * 1000);
        }

        public function as_setFightBtnTooltip(param1:String, param2:Boolean) : void
        {
            if(StringUtils.isNotEmpty(param1))
            {
                this._fightBtnTooltipStr = param1;
                this._isFigthButtonSpecialTooltip = param2;
                this.fightBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onFightBtnMouseOverHandler);
                this.fightBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onFightBtnMouseOutHandler);
            }
            else
            {
                this.fightBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onFightBtnMouseOverHandler);
                this.fightBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.onFightBtnMouseOutHandler);
            }
        }

        public function as_setFightButton(param1:String) : void
        {
            this.fightBtn.label = param1;
            this.fightBtn.validateNow();
        }

        public function as_setGoldFishEnabled(param1:Boolean, param2:Boolean, param3:String, param4:String) : void
        {
            var _loc5_:HBC_FinanceVo = HBC_FinanceVo(this._headerButtonsHelper.getContentDataById(CURRENCIES_CONSTANTS.GOLD));
            if(_loc5_)
            {
                _loc5_.isDiscountEnabled = param1;
                _loc5_.playDiscountAnimation = param2;
                _loc5_.tooltip = param3;
                _loc5_.tooltipType = param4;
                this._headerButtonsHelper.invalidateDataById(CURRENCIES_CONSTANTS.GOLD);
            }
        }

        public function as_setPremShopData(param1:String, param2:String, param3:String, param4:String) : void
        {
            var _loc5_:HBC_PremShopVO = HBC_PremShopVO(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_PREMSHOP));
            if(_loc5_)
            {
                _loc5_.iconSrc = param1;
                _loc5_.premShopText = param2;
                _loc5_.tooltip = param3;
                _loc5_.tooltipType = param4;
                this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_PREMSHOP);
            }
        }

        public function as_setScreen(param1:String) : void
        {
            this.mainMenuButtonBar.setDisableNav(false);
            this.mainMenuButtonBar.setCurrent(param1);
        }

        public function as_setServer(param1:String, param2:String, param3:String) : void
        {
            var _loc4_:HBC_SettingsVo = HBC_SettingsVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_SETTINGS));
            if(_loc4_)
            {
                _loc4_.serverName = param1;
                _loc4_.tooltip = param2;
                _loc4_.tooltipType = param3;
                this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_SETTINGS);
            }
        }

        public function as_setWalletStatus(param1:Object) : void
        {
            this._utils.voMgr.walletStatusVO.update(param1);
            this._headerButtonsHelper.invalidateDataById(CURRENCIES_CONSTANTS.GOLD);
            this._headerButtonsHelper.invalidateDataById(CURRENCIES_CONSTANTS.FREE_XP);
            this._headerButtonsHelper.invalidateDataById(CURRENCIES_CONSTANTS.CRYSTAL);
        }

        public function as_showBubbleTooltip(param1:String, param2:int) : void
        {
            this.disposeBubbleToolTip();
            var _loc3_:TooltipProps = new TooltipProps(BaseTooltips.TYPE_INFO,BUBBLE_TOOLTIP_X,BUBBLE_TOOLTIP_Y);
            this._bubbleTooltip = this._utils.classFactory.getComponent(Linkages.TOOL_TIP_COMPLEX,ToolTipComplex);
            addChild(this._bubbleTooltip);
            this._bubbleTooltip.build(param1,_loc3_);
            this._scheduler.scheduleTask(this.hideBubbleTooltip,param2);
        }

        public function as_toggleVisibilityMenu(param1:uint) : void
        {
            this.mainMenuGradient.visible = this.centerMenuBg.visible = Boolean(param1 & BG_OVERLAY_ONLY);
            this.mainMenuButtonBar.visible = Boolean(param1 & BUTTON_BAR_ONLY);
            this.onlineCounter.visible = Boolean(param1 & ONLINE_COUNTER_ONLY);
        }

        public function as_updateBattleType(param1:String, param2:String, param3:Boolean, param4:String, param5:String, param6:String, param7:Boolean, param8:Boolean) : void
        {
            var _loc9_:HBC_BattleTypeVo = HBC_BattleTypeVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR));
            if(_loc9_)
            {
                _loc9_.battleTypeName = param1;
                _loc9_.battleTypeIcon = param2;
                _loc9_.battleTypeID = param6;
                _loc9_.tooltip = param4;
                _loc9_.tooltipType = param5;
                _loc9_.eventBgEnabled = param7;
                if(param8)
                {
                    this.sparks.play();
                }
                else
                {
                    this.sparks.stop();
                }
                this.sparks.visible = param8;
                this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR);
                this.as_doDisableHeaderButton(HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR,param3);
            }
        }

        public function as_updateOnlineCounter(param1:String, param2:String, param3:String, param4:Boolean) : void
        {
            this.onlineCounter.updateCount(param1,param2,param3,param4);
        }

        public function as_updatePingStatus(param1:int, param2:Boolean) : void
        {
            var _loc3_:HBC_SettingsVo = HBC_SettingsVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_SETTINGS));
            if(_loc3_)
            {
                _loc3_.pingStatus = param1;
                _loc3_.isColorBlind = param2;
                this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_SETTINGS);
            }
        }

        public function as_updateSquad(param1:Boolean, param2:String, param3:String, param4:Boolean, param5:String) : void
        {
            var _loc6_:HBC_SquadDataVo = HBC_SquadDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_SQUAD));
            _loc6_.isInSquad = param1;
            _loc6_.tooltip = param2;
            _loc6_.tooltipType = param3;
            _loc6_.isEvent = param4;
            _loc6_.icon = param5;
            this._headerButtonsHelper.invalidateDataById(HeaderButtonsHelper.ITEM_ID_SQUAD);
        }

        public function as_setServerName(param1:String) : void
        {
            this.onlineCounter.setServerName(param1);
        }

        public function getTabRenderer(param1:String) : HeaderButton
        {
            var _loc2_:IDataProvider = this.headerButtonBar.dataProvider;
            var _loc3_:HeaderButtonVo = null;
            var _loc4_:int = _loc2_.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                _loc3_ = HeaderButtonVo(_loc2_.requestItemAt(_loc5_));
                if(_loc3_.id == param1)
                {
                    return HeaderButton(this.headerButtonBar.getButtonAt(_loc5_));
                }
                _loc5_++;
            }
            return null;
        }

        public function setHeaderButtonsHelper(param1:HeaderButtonsHelper) : void
        {
            if(this._headerButtonsHelper != null)
            {
                this._headerButtonsHelper.dispose();
            }
            this._headerButtonsHelper = param1;
        }

        private function assertMainMenuButtonWasntFound(param1:Button, param2:String) : void
        {
            this._utils.asserter.assertNotNull(param1,"Main menu button alias:" + param2 + Errors.WASNT_FOUND);
        }

        private function updateSize() : void
        {
            this.headerButtonBar.updateCenterItem(this.fightBtn.getRectangle());
            var _loc1_:String = WIDE_SCREEN;
            var _loc2_:Number = 0;
            var _loc3_:Number = 0;
            var _loc4_:Number = App.appWidth;
            if(_loc4_ <= NARROW_SCREEN_SIZE)
            {
                _loc1_ = NARROW_SCREEN;
            }
            else if(_loc4_ >= WIDE_SCREEN_SIZE)
            {
                _loc1_ = MAX_SCREEN;
                _loc2_ = 1;
                _loc3_ = Math.min((_loc4_ - WIDE_SCREEN_SIZE) / (MAX_SCREEN_SIZE - WIDE_SCREEN_SIZE),1);
            }
            else
            {
                _loc2_ = Math.min((_loc4_ - NARROW_SCREEN_SIZE) / (WIDE_SCREEN_SIZE - NARROW_SCREEN_SIZE),1);
            }
            this.headerButtonBar.updateScreen(_loc1_,_loc4_,_loc2_,_loc3_);
            this.sparks.x = this.fightBtn.x + SPARKS_OFFSET_X;
            this.sparks.y = this.fightBtn.y + SPARKS_OFFSET_Y;
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
        }

        private function stopReadyCoolDown() : void
        {
            this._isInCoolDown = false;
            this.fightBtn.enabled = this._actualEnabledVal;
        }

        private function disposeBubbleToolTip() : void
        {
            if(this._bubbleTooltip)
            {
                this._scheduler.cancelTask(this.hideBubbleTooltip);
                this._utils.tweenAnimator.removeAnims(this._bubbleTooltip);
                removeChild(this._bubbleTooltip);
                this._bubbleTooltip.dispose();
                this._bubbleTooltip = null;
            }
        }

        private function hideBubbleTooltip() : void
        {
            if(this._bubbleTooltip)
            {
                this._utils.tweenAnimator.addFadeOutAnim(this._bubbleTooltip,null);
            }
        }

        private function onHeaderButtonBarClickHandler(param1:ButtonEvent) : void
        {
            var _loc4_:HBC_SquadDataVo = null;
            var _loc2_:HeaderButton = HeaderButton(param1.target);
            var _loc3_:HeaderButtonVo = HeaderButtonVo(_loc2_.data);
            switch(_loc3_.id)
            {
                case HeaderButtonsHelper.ITEM_ID_SETTINGS:
                    showLobbyMenuS();
                    break;
                case HeaderButtonsHelper.ITEM_ID_ACCOUNT:
                    showDashboardS();
                    break;
                case HeaderButtonsHelper.ITEM_ID_PREM:
                    showPremiumViewS();
                    break;
                case HeaderButtonsHelper.ITEM_ID_PREMSHOP:
                    onPremShopClickS();
                    break;
                case HeaderButtonsHelper.ITEM_ID_SQUAD:
                    _loc4_ = HBC_SquadDataVo(this._headerButtonsHelper.getContentDataById(HeaderButtonsHelper.ITEM_ID_SQUAD));
                    if(_loc4_.isEvent)
                    {
                        App.popoverMgr.show(_loc2_,Aliases.SQUAD_TYPE_SELECT_POPOVER,null,_loc2_);
                    }
                    else
                    {
                        showSquadS();
                    }
                    break;
                case HeaderButtonsHelper.ITEM_ID_BATTLE_SELECTOR:
                    App.popoverMgr.show(_loc2_,Aliases.BATTLE_TYPE_SELECT_POPOVER,null,_loc2_);
                    break;
                case CURRENCIES_CONSTANTS.GOLD:
                    onPaymentS();
                    break;
                case CURRENCIES_CONSTANTS.CREDITS:
                    showExchangeWindowS();
                    break;
                case CURRENCIES_CONSTANTS.FREE_XP:
                    showExchangeXPWindowS();
                    break;
                case CURRENCIES_CONSTANTS.CRYSTAL:
                    onCrystalClickS();
                    break;
            }
        }

        private function onMainMenuButtonBarClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:ISoundButtonEx = ISoundButtonEx(param1.target);
            var _loc3_:HangarMenuTabItemVO = HangarMenuTabItemVO(_loc2_.data);
            if(_loc3_ != null)
            {
                menuItemClickS(_loc3_.value);
            }
        }

        private function onFightBtnClickHandler(param1:ButtonEvent) : void
        {
            fightClickS(0,EMPTY_ACTION);
        }

        private function onFightBtnMouseOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        private function onFightBtnMouseOverHandler(param1:MouseEvent) : void
        {
            if(this._isFigthButtonSpecialTooltip)
            {
                App.toolTipMgr.showSpecial(this._fightBtnTooltipStr,null);
            }
            else
            {
                App.toolTipMgr.showComplex(this._fightBtnTooltipStr);
            }
        }
    }
}
