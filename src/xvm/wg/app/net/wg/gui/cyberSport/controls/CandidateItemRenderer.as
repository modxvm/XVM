package net.wg.gui.cyberSport.controls
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import net.wg.infrastructure.interfaces.entity.IDropItem;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    import net.wg.gui.components.advanced.InviteIndicator;
    import flash.text.TextField;
    import net.wg.gui.components.controls.VoiceWave;
    import net.wg.data.constants.Cursors;
    import net.wg.infrastructure.events.VoiceChatEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.rally.vo.RallyCandidateVO;
    import net.wg.infrastructure.interfaces.IUserProps;
    import net.wg.gui.prebattle.squad.MessengerUtils;
    import net.wg.data.constants.Values;
    import net.wg.gui.rally.events.RallyViewsEvent;
    
    public class CandidateItemRenderer extends SoundListItemRenderer implements IDropItem, IUpdatable
    {
        
        public function CandidateItemRenderer()
        {
            super();
            this.inviteIndicator.visible = false;
            this.candidateRating.visible = false;
            this.candidateName.visible = false;
            this.doubleClickEnabled = true;
        }
        
        public var inviteIndicator:InviteIndicator = null;
        
        public var candidateName:TextField = null;
        
        public var candidateRating:TextField = null;
        
        public var voiceWave:VoiceWave = null;
        
        public function get getCursorType() : String
        {
            return Cursors.DRAG_OPEN;
        }
        
        override public function setData(param1:Object) : void
        {
            this.data = param1;
            invalidateData();
        }
        
        public function update(param1:Object) : void
        {
            this.setData(param1);
        }
        
        public function onPlayerSpeak(param1:Number, param2:Boolean) : void
        {
            if((data) && param1 == data.uid)
            {
                this.setSpeakers(param2);
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
            App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            addEventListener(MouseEvent.DOUBLE_CLICK,this.doubleClickHandler);
        }
        
        override protected function onDispose() : void
        {
            App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
            App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.voiceWave.dispose();
            this.voiceWave = null;
            this.inviteIndicator.dispose();
            this.inviteIndicator = null;
            this.candidateName = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.updateElements(data);
                this.updateVoiceWave();
            }
        }
        
        protected function updateElements(param1:Object) : void
        {
            var _loc2_:RallyCandidateVO = null;
            var _loc3_:IUserProps = null;
            _loc2_ = RallyCandidateVO(param1);
            visible = !(_loc2_ == null);
            if(_loc2_)
            {
                this.inviteIndicator.visible = _loc2_.isInvite;
                if(_loc2_.isRatingAvailable)
                {
                    this.candidateRating.visible = true;
                    this.candidateRating.text = _loc2_.rating;
                }
                else
                {
                    this.candidateRating.visible = false;
                }
                this.candidateName.width = this.candidateRating.x + this.candidateRating.width - this.candidateName.x - this.candidateRating.textWidth - 10;
                _loc3_ = App.utils.commons.getUserProps(_loc2_.userName,_loc2_.clanAbbrev,_loc2_.region,_loc2_.igrType);
                _loc3_.rgb = _loc2_.color;
                this.candidateName.visible = true;
                App.utils.commons.formatPlayerName(this.candidateName,_loc3_);
                this.setSpeakers(_loc2_.isPlayerSpeaking,true);
            }
            else
            {
                this.setSpeakers(false,true);
            }
        }
        
        protected function updateVoiceWave() : void
        {
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            this.voiceWave.setMuted(data?MessengerUtils.isMuted(data):false);
        }
        
        protected function setSpeakers(param1:Boolean, param2:Boolean = false) : void
        {
            if(param1)
            {
                param2 = false;
            }
            if(this.voiceWave is VoiceWave)
            {
                this.voiceWave.setSpeaking(param1,param2);
            }
            if(data)
            {
                data.isPlayerSpeaking = param1;
            }
        }
        
        private function speakHandler(param1:VoiceChatEvent) : void
        {
            this.onPlayerSpeak(param1.getAccountDBID(),param1.type == VoiceChatEvent.START_SPEAKING);
        }
        
        private function onRollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:RallyCandidateVO = RallyCandidateVO(data);
            if((_loc2_) && !(_loc2_.getToolTip() == Values.EMPTY_STR))
            {
                App.toolTipMgr.show(_loc2_.getToolTip());
            }
        }
        
        private function onRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        private function doubleClickHandler(param1:MouseEvent) : void
        {
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.ASSIGN_FREE_SLOT_REQUEST,RallyCandidateVO(data).dbID));
        }
    }
}
