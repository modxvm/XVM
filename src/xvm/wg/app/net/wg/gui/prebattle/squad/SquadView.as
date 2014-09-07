package net.wg.gui.prebattle.squad
{
    import net.wg.infrastructure.base.meta.impl.SquadViewMeta;
    import net.wg.infrastructure.base.meta.ISquadViewMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.InfoIcon;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.events.MouseEvent;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.rally.vo.RallyVO;
    import net.wg.data.constants.Values;
    
    public class SquadView extends SquadViewMeta implements ISquadViewMeta
    {
        
        public function SquadView()
        {
            super();
        }
        
        private static var CHANGE_READY_STATE:int = 1;
        
        private static var BATTLE_TYPE_INFO_VISIBLE_TEMP:Boolean = false;
        
        public var battleTypeHeader:TextField = null;
        
        public var battleType:TextField = null;
        
        public var battleTypeInfo:InfoIcon = null;
        
        public var inviteBtn:SoundButtonEx = null;
        
        public var leaveSquadBtn:SoundButtonEx = null;
        
        private var _battleTypeName:String = "";
        
        private var BATTLE_TYPE_INVALID:String = "battleTypeIsInvalid";
        
        private var BATTLE_TYPE_INFO_MARGIN:Number = 5;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.battleTypeInfo.tooltip = TOOLTIPS.SQUADWINDOW_BATTLETYPEINFO;
            this.battleTypeInfo.visible = BATTLE_TYPE_INFO_VISIBLE_TEMP;
            this.leaveSquadBtn.label = MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_DISMISS;
            this.leaveSquadBtn.addEventListener(MouseEvent.CLICK,this.onLeaveClick);
            this.leaveSquadBtn.tooltip = TOOLTIPS.SQUADWINDOW_BUTTONS_LEAVESQUAD;
            this.inviteBtn.addEventListener(MouseEvent.CLICK,this.onInviteClick);
            this.battleTypeHeader.text = MESSENGER.DIALOGS_SQUADCHANNEL_BATTLETYPE;
        }
        
        private function onInviteClick(param1:MouseEvent) : void
        {
            inviteFriendRequestS();
        }
        
        private function onLeaveClick(param1:MouseEvent) : void
        {
            leaveSquadS();
        }
        
        override protected function onDispose() : void
        {
            this.leaveSquadBtn.addEventListener(MouseEvent.CLICK,this.onLeaveClick);
            this.inviteBtn.addEventListener(MouseEvent.CLICK,this.onInviteClick);
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(this.BATTLE_TYPE_INVALID)) && (this.battleType))
            {
                this.battleType.text = this._battleTypeName;
                if((this.battleTypeInfo) && (this.battleTypeInfo.visible))
                {
                    this.battleTypeInfo.x = this.battleType.x + this.battleType.width - this.battleType.textWidth - this.BATTLE_TYPE_INFO_MARGIN ^ 0;
                }
            }
        }
        
        override public function as_updateRally(param1:Object) : void
        {
            super.as_updateRally(param1);
            this.inviteBtn.visible = rallyData.isCommander;
            if(rallyData.isCommander)
            {
                this.inviteBtn.label = MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_INVITE;
                this.inviteBtn.tooltip = TOOLTIPS.SQUADWINDOW_BUTTONS_INVITE;
            }
            else
            {
                this.inviteBtn.label = MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_RECOMMEND;
                this.inviteBtn.tooltip = TOOLTIPS.SQUADWINDOW_BUTTONS_RECOMMEND;
            }
        }
        
        override public function as_setActionButtonState(param1:Object) : void
        {
            super.as_setActionButtonState(param1);
        }
        
        override protected function getRallyVO(param1:Object) : IRallyVO
        {
            return new RallyVO(param1);
        }
        
        public function as_updateBattleType(param1:String) : void
        {
            var _loc2_:* = false;
            _loc2_ = (param1) && !(param1 == Values.EMPTY_STR);
            this.battleType.visible = _loc2_;
            this.battleTypeHeader.visible = _loc2_;
            this.battleTypeInfo.visible = BATTLE_TYPE_INFO_VISIBLE_TEMP;
            if(param1 == this._battleTypeName)
            {
                return;
            }
            this._battleTypeName = param1;
            invalidate(this.BATTLE_TYPE_INVALID);
        }
        
        public function as_updateInviteBtnState(param1:Boolean) : void
        {
            this.inviteBtn.enabled = param1;
        }
        
        override protected function coolDownControls(param1:Boolean, param2:int) : void
        {
            if(param2 == CHANGE_READY_STATE)
            {
                teamSection.enableFightButton(param1);
            }
            super.coolDownControls(param1,param2);
        }
        
        public function as_setCoolDownForReadyButton(param1:Number) : void
        {
            as_setCoolDown(param1,CHANGE_READY_STATE);
        }
    }
}
