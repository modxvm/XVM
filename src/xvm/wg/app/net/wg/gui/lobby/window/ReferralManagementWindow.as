package net.wg.gui.lobby.window
{
    import net.wg.infrastructure.base.meta.impl.ReferralManagementWindowMeta;
    import net.wg.infrastructure.base.meta.IReferralManagementWindowMeta;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import flash.text.TextField;
    import net.wg.gui.components.controls.HyperLink;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.controls.SortableTable;
    import net.wg.gui.components.controls.InfoIcon;
    import net.wg.gui.lobby.referralSystem.ComplexProgressIndicator;
    import net.wg.gui.lobby.referralSystem.AwardReceivedBlock;
    import scaleform.clik.data.DataProvider;
    import scaleform.gfx.TextFieldEx;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.referralSystem.ReferralManagementEvent;
    import net.wg.gui.lobby.referralSystem.data.ComplexProgressIndicatorVO;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.constants.Tooltips;
    import net.wg.data.constants.Values;
    
    public class ReferralManagementWindow extends ReferralManagementWindowMeta implements IReferralManagementWindowMeta
    {
        
        public function ReferralManagementWindow()
        {
            super();
            this.progressIndicator.visible = false;
            this.awardReceivedBlock.visible = false;
            this.progressAlertTF.visible = false;
            isModal = false;
            canClose = true;
            isCentered = true;
        }
        
        private static var INFO_ICON_VERTICAL_OFFSET:int = 10;
        
        private static function createTableBtnInfo(param1:String, param2:Number, param3:Number, param4:String, param5:String = "", param6:String = "") : NormalSortingBtnInfo
        {
            var _loc7_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc7_.label = param1;
            _loc7_.buttonWidth = param2;
            _loc7_.sortOrder = param3;
            _loc7_.textAlign = param4;
            if(param6)
            {
                _loc7_.setToolTipSpecial(param6);
            }
            else
            {
                _loc7_.toolTip = param5;
            }
            return _loc7_;
        }
        
        public var infoHeaderTF:TextField = null;
        
        public var descriptionTF:TextField = null;
        
        public var invitedPlayersTF:TextField = null;
        
        public var invitesManagementLink:HyperLink = null;
        
        public var closeButton:SoundButtonEx = null;
        
        public var referralsTable:SortableTable = null;
        
        public var descriptionInfoIcon:InfoIcon = null;
        
        public var progressIndicator:ComplexProgressIndicator;
        
        public var awardReceivedBlock:AwardReceivedBlock;
        
        public var progressAlertTF:TextField = null;
        
        private var model:RefManagementWindowVO = null;
        
        public function as_setTableData(param1:Array) : void
        {
            this.referralsTable.listDP = new DataProvider(param1);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            TextFieldEx.setVerticalAlign(this.infoHeaderTF,TextFieldEx.VALIGN_CENTER);
            this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
            this.invitesManagementLink.addEventListener(ButtonEvent.CLICK,this.onInvitesManagementLinkClickHandler);
            this.descriptionInfoIcon.addEventListener(MouseEvent.ROLL_OVER,this.onDescriptionInfoIconRollOverHandler);
            this.descriptionInfoIcon.addEventListener(MouseEvent.ROLL_OUT,this.onDescriptionInfoIconRollOutHandler);
            this.referralsTable.addEventListener(ReferralManagementEvent.CREATE_SQUAD_BTN_CLICK,this.onTableBtnClickHandler);
        }
        
        override protected function onDispose() : void
        {
            this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
            this.invitesManagementLink.removeEventListener(ButtonEvent.CLICK,this.onInvitesManagementLinkClickHandler);
            this.descriptionInfoIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onDescriptionInfoIconRollOverHandler);
            this.descriptionInfoIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onDescriptionInfoIconRollOutHandler);
            this.referralsTable.removeEventListener(ReferralManagementEvent.CREATE_SQUAD_BTN_CLICK,this.onTableBtnClickHandler);
            this.infoHeaderTF = null;
            this.descriptionTF = null;
            this.invitedPlayersTF = null;
            this.progressAlertTF = null;
            this.closeButton.dispose();
            this.closeButton = null;
            this.referralsTable.dispose();
            this.referralsTable = null;
            this.descriptionInfoIcon.dispose();
            this.descriptionInfoIcon = null;
            this.invitesManagementLink.dispose();
            this.invitesManagementLink = null;
            this.progressIndicator.dispose();
            this.progressIndicator = null;
            this.awardReceivedBlock.dispose();
            this.awardReceivedBlock = null;
            if(this.model)
            {
                this.model.dispose();
            }
            this.model = null;
            super.onDispose();
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.useBottomBtns = true;
            App.utils.commons.initTabIndex([this.closeButton,window.getCloseBtn()]);
        }
        
        override protected function setData(param1:RefManagementWindowVO) : void
        {
            this.model = param1;
            window.title = param1.windowTitle;
            this.infoHeaderTF.htmlText = param1.infoHeaderText;
            this.descriptionTF.htmlText = param1.descriptionText;
            this.invitedPlayersTF.htmlText = param1.invitedPlayersText;
            this.invitesManagementLink.label = param1.invitesManagementLinkText;
            this.closeButton.label = param1.closeBtnLabel;
            App.utils.commons.moveDsiplObjToEndOfText(this.descriptionInfoIcon,this.descriptionTF,0,INFO_ICON_VERTICAL_OFFSET);
            this.referralsTable.headerDP = this.getHeadersDP();
        }
        
        override protected function setProgressData(param1:ComplexProgressIndicatorVO) : void
        {
            if(param1.isProgressAvailable)
            {
                this.progressAlertTF.visible = false;
                if(param1.isCompleted)
                {
                    this.progressIndicator.visible = false;
                    this.awardReceivedBlock.visible = true;
                    this.awardReceivedBlock.model = param1;
                }
                else
                {
                    this.awardReceivedBlock.visible = false;
                    this.progressIndicator.visible = true;
                    this.progressIndicator.model = param1;
                }
            }
            else
            {
                this.progressIndicator.visible = this.awardReceivedBlock.visible = false;
                this.progressAlertTF.visible = true;
                this.progressAlertTF.htmlText = param1.progressAlertText;
            }
        }
        
        private function getHeadersDP() : DataProvider
        {
            var _loc1_:Array = [];
            _loc1_.push(createTableBtnInfo(this.model.tableNickText,146,0,TextFieldAutoSize.LEFT));
            _loc1_.push(createTableBtnInfo(this.model.tableExpText,143,0,TextFieldAutoSize.RIGHT,this.model.tableExpTT));
            _loc1_.push(createTableBtnInfo(this.model.tableExpMultiplierText,193,0,TextFieldAutoSize.CENTER,"",Tooltips.REF_SYS_XP_MULTIPLIER));
            _loc1_.push(createTableBtnInfo(Values.EMPTY_STR,166,0,TextFieldAutoSize.CENTER));
            return new DataProvider(_loc1_);
        }
        
        private function onCloseButtonClickHandler(param1:ButtonEvent) : void
        {
            onWindowCloseS();
        }
        
        private function onInvitesManagementLinkClickHandler(param1:ButtonEvent) : void
        {
            onInvitesManagementLinkClickS();
        }
        
        private function onDescriptionInfoIconRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showSpecial(Tooltips.REF_SYS_DESCRIPTION,null);
        }
        
        private function onDescriptionInfoIconRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function onTableBtnClickHandler(param1:ReferralManagementEvent) : void
        {
            inviteIntoSquadS(param1.referralID);
        }
    }
}
