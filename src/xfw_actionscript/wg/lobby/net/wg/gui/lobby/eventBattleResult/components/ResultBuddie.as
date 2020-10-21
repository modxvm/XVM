package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import net.wg.gui.components.icons.SquadIcon;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.BadgeComponent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.utils.ILocale;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.eventBattleResult.data.ResultPlayerVO;
    import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.ComponentState;

    public class ResultBuddie extends UIComponentEx
    {

        private static const SQUAD_COLOR:uint = 16757350;

        private static const SQUAD_LABEL:String = "Squad";

        private static const BADGE_MARGIN:uint = 26;

        private static const BADGE_GAP:int = 2;

        public var playerTF:TextField = null;

        public var vehicleTF:TextField = null;

        public var soulsTF:TextField = null;

        public var soulsOnTankTF:TextField = null;

        public var killsTF:TextField = null;

        public var damageTF:TextField = null;

        public var squadIcon:SquadIcon = null;

        public var vehicleTypeIcon:MovieClip = null;

        public var selectedMC:MovieClip = null;

        public var leftPanel:BuddieLeftPanel = null;

        public var badgeIcon:BadgeComponent = null;

        public var banIcon:MovieClip = null;

        public var testerIcon:UILoaderAlt = null;

        public var testerBG:UILoaderAlt = null;

        private var _locale:ILocale;

        private var _tooltipMgr:ITooltipMgr;

        private var _banTooltipData:String = "";

        public function ResultBuddie()
        {
            this._locale = App.utils.locale;
            this._tooltipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.banIcon.addEventListener(MouseEvent.ROLL_OVER,this.onBanIconRollOverHandler);
            this.banIcon.addEventListener(MouseEvent.ROLL_OUT,this.onBanIconRollOutHandler);
            this.badgeIcon.mouseEnabled = this.testerIcon.mouseEnabled = this.testerBG.mouseEnabled = false;
        }

        override protected function onBeforeDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.banIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onBanIconRollOverHandler);
            this.banIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onBanIconRollOutHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.badgeIcon.dispose();
            this.badgeIcon = null;
            this.playerTF = null;
            this.vehicleTF = null;
            this.soulsTF = null;
            this.soulsOnTankTF = null;
            this.killsTF = null;
            this.damageTF = null;
            this.squadIcon.dispose();
            this.squadIcon = null;
            this.vehicleTypeIcon = null;
            this.selectedMC = null;
            this.leftPanel.dispose();
            this.leftPanel = null;
            this.testerIcon.dispose();
            this.testerIcon = null;
            this.testerBG.dispose();
            this.testerBG = null;
            this._locale = null;
            this._tooltipMgr = null;
            this._banTooltipData = null;
            super.onDispose();
        }

        public function restoreFriendButton() : void
        {
            this.leftPanel.restoreFriendButton();
        }

        public function restoreSquadButton() : void
        {
            this.leftPanel.restoreSquadButton();
        }

        public function setData(param1:ResultPlayerVO, param2:CommonStatsVO, param3:Boolean, param4:Boolean) : void
        {
            this.selectedMC.visible = param1.isSelf;
            this.vehicleTF.htmlText = param1.vehicleName;
            this.soulsTF.text = this._locale.integer(param1.matter);
            this.soulsOnTankTF.text = this._locale.integer(param1.matterOnTank);
            this.killsTF.text = this._locale.integer(param1.kills);
            this.damageTF.text = this._locale.integer(param1.damageDealt);
            this.banIcon.gotoAndStop(param1.banStatus);
            this._banTooltipData = param1.banStatusTooltip;
            if(param1.squadID > 0)
            {
                this.squadIcon.show(param1.isOwnSquad,param1.squadID);
            }
            else
            {
                this.squadIcon.hide();
            }
            var _loc5_:String = param1.tankType;
            if(param1.isSelf || param1.isOwnSquad)
            {
                this.playerTF.textColor = this.vehicleTF.textColor = this.soulsTF.textColor = this.soulsOnTankTF.textColor = this.killsTF.textColor = this.damageTF.textColor = SQUAD_COLOR;
                _loc5_ = _loc5_ + SQUAD_LABEL;
            }
            this.vehicleTypeIcon.gotoAndStop(_loc5_);
            this.leftPanel.setData(param1,param2,param3,param4);
            if(param1.userVO.badgeVisualVO != null)
            {
                this.badgeIcon.setData(param1.userVO.badgeVisualVO);
                this.playerTF.x = this.playerTF.x + BADGE_MARGIN;
                this.playerTF.width = this.playerTF.width - BADGE_MARGIN;
            }
            var _loc6_:Boolean = StringUtils.isNotEmpty(param1.suffixBadgeIcon);
            this.testerIcon.visible = this.testerBG.visible = _loc6_;
            if(_loc6_)
            {
                this.testerIcon.source = param1.suffixBadgeIcon;
                this.testerBG.source = param1.suffixBadgeStripIcon;
                this.playerTF.width = this.playerTF.width - BADGE_MARGIN;
            }
            App.utils.commons.truncateTextFieldText(this.playerTF,param1.playerName);
            if(_loc6_)
            {
                this.testerIcon.x = this.playerTF.x + this.playerTF.textWidth + BADGE_GAP >> 0;
                this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x - this.testerBG.originalWidth >> 0;
            }
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            gotoAndPlay(ComponentState.OVER);
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            gotoAndPlay(ComponentState.OUT);
        }

        private function onBanIconRollOverHandler(param1:MouseEvent) : void
        {
            if(StringUtils.isNotEmpty(this._banTooltipData))
            {
                this._tooltipMgr.showComplex(this._banTooltipData);
            }
        }

        private function onBanIconRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }
    }
}
