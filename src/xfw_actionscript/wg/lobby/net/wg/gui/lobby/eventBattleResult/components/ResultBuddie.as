package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import net.wg.gui.components.controls.BadgeComponent;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.utils.ILocale;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.eventBattleResult.data.ResultPlayerVO;
    import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
    import net.wg.gui.lobby.eventBattleResult.data.ResultMaxValuesVO;
    import net.wg.data.constants.Values;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.ComponentState;

    public class ResultBuddie extends UIComponentEx
    {

        private static const NORMAL_COLOR:uint = 15132390;

        private static const SQUAD_COLOR:uint = 16757350;

        private static const SQUAD_LABEL:String = "Squad";

        private static const TIRE_LABEL_PREFIX:String = "tire";

        private static const BADGE_MARGIN:uint = 26;

        private static const BADGE_GAP:int = 2;

        private static const BUDDY_FRAME:int = 1;

        private static const PLAYER_FRAME:int = 2;

        private static const DEAD_ALPHA:Number = 0.6;

        public var playerTF:TextField = null;

        public var vehicleTF:TextField = null;

        public var killsTF:TextField = null;

        public var damageTF:TextField = null;

        public var assistTF:TextField = null;

        public var armorTF:TextField = null;

        public var killsGlow:MovieClip = null;

        public var damageGlow:MovieClip = null;

        public var assistGlow:MovieClip = null;

        public var armorGlow:MovieClip = null;

        public var squadIcon:AnimatedTextContainer = null;

        public var vehicleTypeIcon:MovieClip = null;

        public var selectedMC:MovieClip = null;

        public var leftPanel:BuddieLeftPanel = null;

        public var badge:BadgeComponent = null;

        public var testerIcon:UILoaderAlt = null;

        public var testerBG:MovieClip = null;

        public var tireIcon:MovieClip = null;

        public var hover:MovieClip = null;

        private var _locale:ILocale;

        private var _playerTFNormalX:int = 0;

        private var _playerTFNormalWidth:int = 0;

        public function ResultBuddie()
        {
            this._locale = App.utils.locale;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.badge.mouseEnabled = this.testerIcon.mouseEnabled = this.testerBG.mouseEnabled = false;
        }

        override protected function onBeforeDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.badge.dispose();
            this.badge = null;
            this.playerTF = null;
            this.assistTF = null;
            this.armorTF = null;
            this.vehicleTF = null;
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
            this.testerBG = null;
            this.killsGlow = null;
            this.damageGlow = null;
            this.assistGlow = null;
            this.armorGlow = null;
            this.hover = null;
            this.tireIcon = null;
            this._locale = null;
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

        public function setData(param1:ResultPlayerVO, param2:CommonStatsVO, param3:Boolean, param4:Boolean, param5:ResultMaxValuesVO) : void
        {
            var _loc8_:uint = 0;
            this.selectedMC.visible = param1.isSelf;
            this.vehicleTF.htmlText = param1.vehicleName;
            this.killsTF.text = this._locale.integer(param1.kills);
            this.killsGlow.visible = param1.kills > 0 && param1.kills == param5.kills;
            this.damageTF.text = this._locale.integer(param1.damageDealt);
            this.damageGlow.visible = param1.damageDealt > 0 && param1.damageDealt == param5.damageDealt;
            this.assistTF.text = this._locale.integer(param1.assist);
            this.assistGlow.visible = param1.assist > 0 && param1.assist == param5.assist;
            this.armorTF.text = this._locale.integer(param1.armor);
            this.armorGlow.visible = param1.armor > 0 && param1.armor == param5.armor;
            this.squadIcon.visible = param1.squadID > 0;
            if(this.squadIcon.visible)
            {
                this.squadIcon.text = param1.squadID.toString();
                this.squadIcon.gotoAndStop(param1.isOwnSquad?PLAYER_FRAME:BUDDY_FRAME);
            }
            var _loc6_:String = param1.tankType;
            var _loc7_:String = TIRE_LABEL_PREFIX + (param1.generalLevel + 1);
            if(param1.isSelf || param1.isOwnSquad)
            {
                _loc8_ = SQUAD_COLOR;
                _loc6_ = _loc6_ + SQUAD_LABEL;
                _loc7_ = _loc7_ + SQUAD_LABEL;
            }
            else
            {
                _loc8_ = NORMAL_COLOR;
            }
            this.squadIcon.textColor = this.playerTF.textColor = this.vehicleTF.textColor = this.armorTF.textColor = this.assistTF.textColor = this.killsTF.textColor = this.damageTF.textColor = _loc8_;
            this.squadIcon.alpha = this.badge.alpha = this.testerBG.alpha = this.testerIcon.alpha = this.tireIcon.alpha = this.killsTF.alpha = this.vehicleTypeIcon.alpha = this.playerTF.alpha = this.vehicleTF.alpha = this.armorTF.alpha = this.assistTF.alpha = this.damageTF.alpha = param1.deathReason > -1?DEAD_ALPHA:Values.DEFAULT_ALPHA;
            enabled = !param1.isSelf;
            this.vehicleTypeIcon.gotoAndStop(_loc6_);
            this.tireIcon.gotoAndStop(_loc7_);
            this.leftPanel.setData(param1,param2,param3,param4);
            if(this._playerTFNormalWidth == Values.ZERO)
            {
                this._playerTFNormalX = this.playerTF.x;
                this._playerTFNormalWidth = this.playerTF.width >> 0;
            }
            this.badge.visible = param1.userVO.badgeVisualVO != null && StringUtils.isNotEmpty(param1.userVO.badgeVisualVO.icon);
            if(this.badge.visible)
            {
                this.badge.setData(param1.userVO.badgeVisualVO);
                this.playerTF.x = this._playerTFNormalX + BADGE_MARGIN;
                this.playerTF.width = this._playerTFNormalWidth - BADGE_MARGIN;
            }
            else
            {
                this.playerTF.x = this._playerTFNormalX;
                this.playerTF.width = this._playerTFNormalWidth;
            }
            var _loc9_:Boolean = StringUtils.isNotEmpty(param1.suffixBadgeIcon);
            this.testerIcon.visible = this.testerBG.visible = _loc9_;
            if(_loc9_)
            {
                this.testerIcon.source = param1.suffixBadgeIcon;
                this.playerTF.width = this.playerTF.width - BADGE_MARGIN;
            }
            App.utils.commons.truncateTextFieldText(this.playerTF,param1.playerName);
            if(_loc9_)
            {
                this.testerIcon.x = this.playerTF.x + this.playerTF.textWidth + BADGE_GAP >> 0;
                this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x - this.testerBG.width >> 0;
            }
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(enabled)
            {
                gotoAndPlay(ComponentState.OVER);
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            if(enabled)
            {
                gotoAndPlay(ComponentState.OUT);
            }
        }
    }
}
