package net.wg.gui.prebattle.squads.simple
{
    import net.wg.gui.rally.controls.VoiceRallySlotRenderer;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.InviteIndicator;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.components.advanced.IndicationOfStatus;
    import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadRallySlotVO;
    import net.wg.data.constants.Values;
    import flash.events.MouseEvent;
    import net.wg.data.VO.ExtendedUserVO;
    import net.wg.data.constants.UserTags;
    import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
    import scaleform.gfx.TextFieldEx;

    public class SimpleSquadSlotRenderer extends VoiceRallySlotRenderer
    {

        public var playerMessage:TextField = null;

        public var inviteIndicator:InviteIndicator = null;

        public var premiumIcon:Sprite = null;

        public var notificationInfoIcon:UILoaderAlt = null;

        private var _notificationIconTooltip:String = null;

        private var _tooltipMgr:ITooltipMgr;

        public function SimpleSquadSlotRenderer()
        {
            this._tooltipMgr = App.toolTipMgr;
            badgeOffsetY = -3;
            super();
            this.notificationInfoIcon.visible = false;
            TextFieldEx.setVerticalAlign(this.playerMessage,TextFieldEx.VALIGN_CENTER);
            slotLabelTextWithBadgeY = -badgeOffsetY;
        }

        override public function setStatus(param1:int) : String
        {
            var _loc2_:String = IndicationOfStatus.STATUS_NORMAL;
            if(param1 < STATUSES.length && param1)
            {
                _loc2_ = STATUSES[param1];
            }
            statusIndicator.status = _loc2_;
            return _loc2_;
        }

        override public function updateComponents() : void
        {
            var _loc4_:* = 0;
            super.updateComponents();
            var _loc1_:SimpleSquadRallySlotVO = SimpleSquadRallySlotVO(slotData);
            var _loc2_:Boolean = _loc1_.isVisibleAdtMsg;
            if(this.playerMessage.visible != _loc2_)
            {
                this.playerMessage.visible = _loc2_;
            }
            if(_loc2_)
            {
                _loc4_ = this.height;
                this.playerMessage.wordWrap = true;
                this.playerMessage.height = _loc4_;
                this.playerMessage.htmlText = _loc1_.additionalMsg;
                App.utils.commons.updateTextFieldSize(this.playerMessage,false,true);
                this.playerMessage.y = _loc4_ - this.playerMessage.height >> 1;
            }
            var _loc3_:String = _loc1_.slotNotificationIcon;
            if(_loc3_ != Values.EMPTY_STR)
            {
                this.notificationInfoIcon.source = _loc3_;
                this._notificationIconTooltip = _loc1_.slotNotificationIconTooltip;
                this.notificationInfoIcon.visible = true;
                this.addTooltipListeners();
            }
            else
            {
                this._notificationIconTooltip = Values.EMPTY_STR;
                this.notificationInfoIcon.visible = false;
                this.removeTooltipListeners();
            }
        }

        override protected function getOrderNoSymbol() : String
        {
            return "";
        }

        override protected function configUI() : void
        {
            super.configUI();
            addTooltipSubscriber(statusIndicator);
            addTooltipSubscriber(commander);
            commander.visible = false;
        }

        override protected function onDispose() : void
        {
            removeTooltipSubscriber(statusIndicator);
            this.playerMessage = null;
            this.inviteIndicator.dispose();
            this.inviteIndicator = null;
            removeTooltipSubscriber(commander);
            this.removeTooltipListeners();
            this.notificationInfoIcon.dispose();
            this.notificationInfoIcon = null;
            this._tooltipMgr = null;
            this.premiumIcon = null;
            super.onDispose();
        }

        private function removeTooltipListeners() : void
        {
            this.notificationInfoIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onNotificationIconRollOverHandler);
            this.notificationInfoIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onNotificationIconRollOutHandler);
        }

        private function addTooltipListeners() : void
        {
            this.notificationInfoIcon.addEventListener(MouseEvent.ROLL_OVER,this.onNotificationIconRollOverHandler);
            this.notificationInfoIcon.addEventListener(MouseEvent.ROLL_OUT,this.onNotificationIconRollOutHandler);
        }

        override protected function onContextMenuAreaClick(param1:MouseEvent) : void
        {
            var _loc2_:ExtendedUserVO = slotData?slotData.player as ExtendedUserVO:null;
            if(_loc2_ && !UserTags.isCurrentPlayer(_loc2_.tags) && _loc2_.accID > -1)
            {
                App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.UNIT_USER,this,_loc2_);
            }
        }

        private function onNotificationIconRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }

        private function onNotificationIconRollOverHandler(param1:MouseEvent) : void
        {
            if(this._notificationIconTooltip != Values.EMPTY_STR)
            {
                this._tooltipMgr.showComplex(this._notificationIconTooltip);
            }
        }
    }
}
