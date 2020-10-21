package net.wg.gui.prebattle.squads
{
    import net.wg.infrastructure.base.meta.impl.SquadViewMeta;
    import net.wg.infrastructure.base.meta.ISquadViewMeta;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.prebattle.squads.simple.SquadViewHeaderVO;
    import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadTeamSectionVO;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.prebattle.squads.ev.SquadViewEvent;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.prebattle.squads.simple.SimpleSquadTeamSection;
    import net.wg.gui.prebattle.squads.simple.vo.SimpleSquadRallyVO;
    import net.wg.data.constants.generated.SQUADTYPES;
    import net.wg.gui.prebattle.squads.interfaces.ISquadAbstractFactory;
    import flash.display.DisplayObject;

    public class SquadView extends SquadViewMeta implements ISquadViewMeta
    {

        private static const ADDITIONAL_INFO_TEAM_SECTION:String = "additionalInfoTeamSection";

        private static const INVITE_BTN_Y_SIMPLE_SQUAD:Number = 280;

        private static const CHAT_SECTION_X_POS:Number = 411;

        private static const CHANGE_READY_STATE:int = 1;

        private static const SET_ES_PLAYER_STATE:int = 6;

        public var inviteBtn:SoundButtonEx = null;

        public var leaveSquadBtn:SoundButtonEx = null;

        private var _headerVO:SquadViewHeaderVO;

        private var _data:SimpleSquadTeamSectionVO = null;

        public function SquadView()
        {
            super();
        }

        override protected function updateRally(param1:IRallyVO) : void
        {
            super.updateRally(param1);
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

        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.initBattleType();
            dispatchEvent(new SquadViewEvent(SquadViewEvent.ON_POPULATED));
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.leaveSquadBtn.label = MESSENGER.DIALOGS_SQUADCHANNEL_BUTTONS_DISMISS;
            this.leaveSquadBtn.addEventListener(ButtonEvent.CLICK,this.onLeaveBtnClickHandler);
            this.inviteBtn.addEventListener(ButtonEvent.CLICK,this.onInviteTbnClickHandler);
        }

        override protected function onDispose() : void
        {
            this._data = null;
            this._headerVO = null;
            this.leaveSquadBtn.removeEventListener(ButtonEvent.CLICK,this.onLeaveBtnClickHandler);
            this.leaveSquadBtn.dispose();
            this.leaveSquadBtn = null;
            this.inviteBtn.removeEventListener(ButtonEvent.CLICK,this.onInviteTbnClickHandler);
            this.inviteBtn.dispose();
            this.inviteBtn = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._headerVO && isInvalid(InvalidationType.DATA))
            {
                this.leaveSquadBtn.tooltip = this._headerVO.leaveBtnTooltip;
            }
            if(this._data && isInvalid(ADDITIONAL_INFO_TEAM_SECTION))
            {
                SimpleSquadTeamSection(teamSection).setSimpleSquadTeamSectionVO(this._data);
            }
        }

        override protected function getIRallyVOForRally(param1:Object) : IRallyVO
        {
            return new SimpleSquadRallyVO(param1);
        }

        override protected function setSimpleTeamSectionData(param1:SimpleSquadTeamSectionVO) : void
        {
            this._data = param1;
            invalidate(ADDITIONAL_INFO_TEAM_SECTION);
        }

        override protected function coolDownControls(param1:Boolean, param2:int) : void
        {
            if(param2 == CHANGE_READY_STATE || param2 == SET_ES_PLAYER_STATE)
            {
                teamSection.enableFightButton(param1);
            }
            super.coolDownControls(param1,param2);
        }

        override protected function updateBattleType(param1:SquadViewHeaderVO) : void
        {
            this._headerVO = param1;
            invalidateData();
        }

        public function as_setCoolDownForReadyButton(param1:Number) : void
        {
            as_setCoolDown(param1,CHANGE_READY_STATE);
        }

        public function as_updateInviteBtnState(param1:Boolean) : void
        {
            this.inviteBtn.enabled = param1;
        }

        protected function get squadType() : String
        {
            return SQUADTYPES.SQUAD_TYPE_SIMPLE;
        }

        protected function get teamSectionPosY() : Number
        {
            return INVITE_BTN_Y_SIMPLE_SQUAD;
        }

        protected function initBattleType() : void
        {
            this.inviteBtn.y = this.teamSectionPosY;
            var _loc1_:ISquadAbstractFactory = new SquadAbstractFactory(this.squadType);
            teamSection = _loc1_.getTeamSection();
            chatSection = _loc1_.getChatSection();
            chatSection.x = CHAT_SECTION_X_POS;
            this.addChildAt(DisplayObject(chatSection),0);
            this.addChildAt(DisplayObject(teamSection),0);
            setSize(this.actualWidth,this.actualHeight);
        }

        private function onInviteTbnClickHandler(param1:ButtonEvent) : void
        {
            inviteFriendRequestS();
        }

        private function onLeaveBtnClickHandler(param1:ButtonEvent) : void
        {
            leaveSquadS();
        }
    }
}
