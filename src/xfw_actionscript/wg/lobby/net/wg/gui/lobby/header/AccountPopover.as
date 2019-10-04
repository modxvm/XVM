package net.wg.gui.lobby.header
{
    import net.wg.infrastructure.base.meta.impl.AccountPopoverMeta;
    import net.wg.infrastructure.base.meta.IAccountPopoverMeta;
    import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
    import net.wg.gui.components.controls.UserNameField;
    import net.wg.gui.components.controls.slotsPanel.ISlotsPanel;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.lobby.header.vo.AccountClanPopoverBlockVO;
    import net.wg.gui.lobby.header.vo.AccountPopoverReferralBlockVO;
    import net.wg.gui.lobby.header.vo.AccountPopoverMainVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.Event;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.header.events.AccountPopoverEvent;
    import flash.events.MouseEvent;
    import net.wg.data.constants.Linkages;
    import net.wg.data.Aliases;
    import net.wg.gui.components.controls.events.SlotsPanelEvent;
    import net.wg.gui.lobby.components.events.BoosterPanelEvent;
    import net.wg.gui.components.popovers.PopOverConst;
    import net.wg.data.constants.Values;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.InteractiveObject;
    import net.wg.data.constants.ColorSchemeNames;
    import org.idmedia.as3commons.util.StringUtils;

    public class AccountPopover extends AccountPopoverMeta implements IAccountPopoverMeta
    {

        private static const BLOCK_MARGIN:int = 18;

        private static const UPDATE_CLAN_DATA:String = "updateClanData";

        private static const UPDATE_MAIN_DATA:String = "updateMainData";

        private static const UPDATE_CLAN_EMBLEM:String = "updateClanEmblem";

        private static const DEFAULT_SEPARATOR_Y_POSITION:int = 84;

        private static const DEFAULT_BOOSTER_BLOCK_Y_POSITION:int = 93;

        private static const DEFAULT_BOOSTER_PANEL_Y_POSITION:int = 119;

        private static const ADDITIONAL_PADDING_AFTER_CLAN_BLOCK:int = 20;

        public var separator:ISeparatorAsset = null;

        public var userName:UserNameField = null;

        public var boostersPanel:ISlotsPanel = null;

        public var boostersBlockTitleTF:TextField = null;

        public var boosterBack:Sprite;

        public var clanInfo:IAccountClanPopOverBlock = null;

        public var referralInfo:AccountPopoverReferralBlock = null;

        public var badgeSlot:BadgeSlot = null;

        private var _clanData:AccountClanPopoverBlockVO = null;

        private var _clanEmblemId:String = "";

        private var _referralData:AccountPopoverReferralBlockVO = null;

        private var _mainData:AccountPopoverMainVO = null;

        private var _toolTipMgr:ITooltipMgr = null;

        public function AccountPopover()
        {
            super();
            this._toolTipMgr = App.toolTipMgr;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.addEventListener(Event.RESIZE,this.onResizeHandler);
            this.badgeSlot.addEventListener(ButtonEvent.CLICK,this.onBadgeClickHandler);
            this.badgeSlot.tooltip = BADGE.ACCOUNTPOPOVER_BADGE_TOOLTIP;
            this.clanInfo.addEventListener(AccountPopoverEvent.CLICK_ON_MAIN_BUTTON,this.onClanInfoClickOnMainButtonHandler);
            this.clanInfo.addEventListener(AccountPopoverEvent.OPEN_CLAN_RESEARCH,this.onClanInfoOpenClanResearchHandler);
            this.clanInfo.addEventListener(AccountPopoverEvent.OPEN_REQUEST_INVITE,this.onClanInfoOpenRequestInviteHandler);
            this.clanInfo.addEventListener(AccountPopoverEvent.OPEN_INVITE,this.onClanInfoOpenInviteHandler);
            this.clanInfo.addEventListener(Event.RESIZE,this.onResizeHandler);
            this.referralInfo.addEventListener(AccountPopoverEvent.OPEN_REFERRAL_MANAGEMENT,this.onReferralInfoOpenReferralManagementHandler);
            this.boostersBlockTitleTF.addEventListener(MouseEvent.ROLL_OVER,this.onBoostersTitleRollOverHandler);
            this.boostersBlockTitleTF.addEventListener(MouseEvent.ROLL_OUT,this.onBoostersTitleRollOutHandler);
            this.separator.setCenterAsset(Linkages.TOOLTIP_SEPARATOR_UI);
            this.separator.y = DEFAULT_SEPARATOR_Y_POSITION;
            this.boostersBlockTitleTF.y = DEFAULT_BOOSTER_BLOCK_Y_POSITION;
            this.boostersPanel.y = DEFAULT_BOOSTER_PANEL_Y_POSITION;
            registerFlashComponentS(this.boostersPanel,Aliases.BOOSTERS_PANEL);
            this.boostersPanel.addEventListener(SlotsPanelEvent.NEED_REPOSITION,this.onBoostersPanelNeedRepositionHandler);
            this.boostersPanel.addEventListener(BoosterPanelEvent.SLOT_SELECTED,this.onBoostersPanelSlotSelectedHandler);
        }

        override protected function initLayout() : void
        {
            popoverLayout.preferredLayout = PopOverConst.ARROW_TOP;
            super.initLayout();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._mainData != null && isInvalid(UPDATE_MAIN_DATA))
            {
                this.updateData();
            }
            if(this._clanData != null && isInvalid(UPDATE_CLAN_DATA))
            {
                if(this._clanData.isClanFeaturesEnabled || this._clanData.isInClan)
                {
                    this.clanInfo.setData(this._clanData);
                    this.clanInfo.visible = true;
                }
                else
                {
                    this._clanData = null;
                    this.clanInfo.visible = false;
                }
            }
            if(this._clanEmblemId != Values.EMPTY_STR && isInvalid(UPDATE_CLAN_EMBLEM))
            {
                this.clanInfo.setEmblem(this._clanEmblemId);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateSize();
            }
        }

        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            setFocus(this);
        }

        override protected function onDispose() : void
        {
            this.removeEventListener(Event.RESIZE,this.onResizeHandler);
            this.badgeSlot.removeEventListener(ButtonEvent.CLICK,this.onBadgeClickHandler);
            this.badgeSlot.dispose();
            this.badgeSlot = null;
            this.separator.dispose();
            this.separator = null;
            this.boostersPanel.removeEventListener(SlotsPanelEvent.NEED_REPOSITION,this.onBoostersPanelNeedRepositionHandler);
            this.boostersPanel.removeEventListener(BoosterPanelEvent.SLOT_SELECTED,this.onBoostersPanelSlotSelectedHandler);
            this.clanInfo.removeEventListener(AccountPopoverEvent.CLICK_ON_MAIN_BUTTON,this.onClanInfoClickOnMainButtonHandler);
            this.clanInfo.removeEventListener(AccountPopoverEvent.OPEN_CLAN_RESEARCH,this.onClanInfoOpenClanResearchHandler);
            this.clanInfo.removeEventListener(AccountPopoverEvent.OPEN_REQUEST_INVITE,this.onClanInfoOpenRequestInviteHandler);
            this.clanInfo.removeEventListener(AccountPopoverEvent.OPEN_INVITE,this.onClanInfoOpenInviteHandler);
            this.clanInfo.removeEventListener(Event.RESIZE,this.onResizeHandler);
            this.referralInfo.removeEventListener(AccountPopoverEvent.OPEN_REFERRAL_MANAGEMENT,this.onReferralInfoOpenReferralManagementHandler);
            this.boostersBlockTitleTF.removeEventListener(MouseEvent.ROLL_OVER,this.onBoostersTitleRollOverHandler);
            this.boostersBlockTitleTF.removeEventListener(MouseEvent.ROLL_OUT,this.onBoostersTitleRollOutHandler);
            this._mainData = null;
            this._clanData = null;
            this._referralData = null;
            this.userName.dispose();
            this.userName = null;
            this.clanInfo.dispose();
            this.clanInfo = null;
            this.referralInfo.dispose();
            this.referralInfo = null;
            this.boostersPanel = null;
            this.boostersBlockTitleTF = null;
            this.boosterBack = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        override protected function setClanData(param1:AccountClanPopoverBlockVO) : void
        {
            this._clanData = param1;
            invalidate(UPDATE_CLAN_DATA);
            invalidateSize();
        }

        override protected function setReferralData(param1:AccountPopoverReferralBlockVO) : void
        {
            this._referralData = param1;
            invalidateData();
        }

        override protected function setData(param1:AccountPopoverMainVO) : void
        {
            this._mainData = param1;
            invalidate(UPDATE_MAIN_DATA);
        }

        public function as_setClanEmblem(param1:String) : void
        {
            if(this._clanEmblemId == param1)
            {
                return;
            }
            this._clanEmblemId = param1;
            invalidate(UPDATE_CLAN_EMBLEM);
        }

        private function updateSize() : void
        {
            var _loc1_:* = NaN;
            _loc1_ = this.boostersPanel.y + this.boostersPanel.actualHeight + BLOCK_MARGIN;
            if(this._clanData)
            {
                this.clanInfo.y = _loc1_ ^ 0;
                _loc1_ = _loc1_ + (this.clanInfo.height + BLOCK_MARGIN + ADDITIONAL_PADDING_AFTER_CLAN_BLOCK);
            }
            else
            {
                this.clanInfo.y = 0;
                this.clanInfo.visible = false;
            }
            if(this._referralData)
            {
                this.referralInfo.setData(this._referralData);
                this.referralInfo.visible = true;
                this.referralInfo.y = _loc1_ ^ 0;
                _loc1_ = _loc1_ + (this.referralInfo.height + (BLOCK_MARGIN << 1));
            }
            else
            {
                this.referralInfo.y = 0;
                this.referralInfo.visible = false;
            }
            this.boostersPanel.x = width - this.boostersPanel.width >> 1;
            this.boosterBack.x = 0;
            this.boosterBack.y = this.separator.y + this.separator.height | 0;
            this.boosterBack.width = width;
            _loc1_ = _loc1_ ^ 0;
            var _loc2_:Number = _loc1_;
            if(this.clanInfo.visible)
            {
                _loc2_ = this.clanInfo.y;
            }
            else if(this.referralInfo.visible)
            {
                _loc2_ = this.referralInfo.y;
            }
            this.boosterBack.height = _loc2_ - this.boosterBack.y | 0;
            this.height = _loc1_;
            popoverLayout.invokeLayout();
        }

        private function updateData() : void
        {
            this.boostersBlockTitleTF.htmlText = this._mainData.boostersBlockTitle;
            this.userName.textColor = this._mainData.isTeamKiller?App.colorSchemeMgr.getScheme(ColorSchemeNames.TEAMKILLER).rgb:UserNameField.DEF_USER_NAME_COLOR;
            this.userName.userVO = this._mainData.userData;
            this.badgeSlot.setIconSource(this._mainData.badgeIcon);
        }

        private function onClanInfoOpenInviteHandler(param1:AccountPopoverEvent) : void
        {
            openInviteWindowS();
        }

        private function onClanInfoOpenRequestInviteHandler(param1:AccountPopoverEvent) : void
        {
            openRequestWindowS();
        }

        private function onClanInfoOpenClanResearchHandler(param1:AccountPopoverEvent) : void
        {
            openClanResearchS();
        }

        private function onClanInfoClickOnMainButtonHandler(param1:AccountPopoverEvent) : void
        {
            openClanStatisticS();
        }

        private function onBoostersPanelNeedRepositionHandler(param1:SlotsPanelEvent) : void
        {
            invalidateSize();
        }

        private function onBoostersPanelSlotSelectedHandler(param1:BoosterPanelEvent) : void
        {
            openBoostersWindowS(param1.data.id);
        }

        private function onResizeHandler(param1:Event) : void
        {
            invalidateSize();
        }

        private function onReferralInfoOpenReferralManagementHandler(param1:AccountPopoverEvent) : void
        {
            openReferralManagementS();
        }

        private function onBoostersTitleRollOverHandler(param1:MouseEvent) : void
        {
            if(StringUtils.isNotEmpty(this._mainData.boostersBlockTitleTooltip))
            {
                this._toolTipMgr.showComplex(this._mainData.boostersBlockTitleTooltip);
            }
        }

        private function onBoostersTitleRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onBadgeClickHandler(param1:Event) : void
        {
            openBadgesWindowS();
        }
    }
}
