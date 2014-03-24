package net.wg.gui.cyberSport.controls
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.VoiceWave;
   import net.wg.infrastructure.events.VoiceChatEvent;
   import flash.events.MouseEvent;
   import net.wg.gui.cyberSport.vo.UnitCandidateVO;
   import net.wg.infrastructure.interfaces.IUserProps;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.prebattle.squad.MessengerUtils;


   public class CandidateItemRenderer extends SoundListItemRenderer implements IDropItem, IUpdatable
   {
          
      public function CandidateItemRenderer() {
         super();
      }

      public var inviteIndicator:MovieClip = null;

      public var candidateName:TextField = null;

      public var candidateRating:TextField = null;

      public var voiceWave:VoiceWave = null;

      override protected function configUI() : void {
         super.configUI();
         this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
         App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }

      override protected function onDispose() : void {
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.voiceWave.dispose();
         this.voiceWave = null;
         this.inviteIndicator = null;
         this.candidateName = null;
         super.onDispose();
      }

      override protected function draw() : void {
         var _loc1_:UnitCandidateVO = null;
         var _loc2_:IUserProps = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = UnitCandidateVO(data);
            visible = !(_loc1_ == null);
            if(_loc1_)
            {
               this.inviteIndicator.visible = _loc1_.isInvite;
               if(_loc1_.isRatingAvailable())
               {
                  this.candidateRating.visible = true;
                  this.candidateRating.text = _loc1_.rating;
               }
               else
               {
                  this.candidateRating.visible = false;
               }
               this.candidateName.width = this.candidateRating.x + this.candidateRating.width - this.candidateName.x - this.candidateRating.textWidth - 10;
               _loc2_ = App.utils.commons.getUserProps(_loc1_.userName,_loc1_.clanAbbrev,_loc1_.region,_loc1_.igrType);
               _loc2_.rgb = _loc1_.color;
               App.utils.commons.formatPlayerName(this.candidateName,_loc2_);
               this.setSpeakers(_loc1_.isPlayerSpeaking,true);
            }
            else
            {
               this.setSpeakers(false,true);
            }
            this.updateVoiceWave();
         }
      }

      public function update(param1:Object) : void {
         this.setData(param1);
      }

      override public function setData(param1:Object) : void {
         this.data = param1;
         invalidateData();
      }

      protected function updateVoiceWave() : void {
         this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
         this.voiceWave.setMuted(data?MessengerUtils.isMuted(data):false);
      }

      protected function setSpeakers(param1:Boolean, param2:Boolean=false) : void {
         if(param1)
         {
            param2 = false;
         }
         if(this.voiceWave  is  VoiceWave)
         {
            this.voiceWave.setSpeaking(param1,param2);
         }
         if(data)
         {
            data.isPlayerSpeaking = param1;
         }
      }

      private function speakHandler(param1:VoiceChatEvent) : void {
         this.onPlayerSpeak(param1.getAccountDBID(),param1.type == VoiceChatEvent.START_SPEAKING);
      }

      public function onPlayerSpeak(param1:Number, param2:Boolean) : void {
         if((data) && param1 == data.uid)
         {
            this.setSpeakers(param2);
         }
      }

      private function onRollOverHandler(param1:MouseEvent) : void {
         var _loc2_:UnitCandidateVO = UnitCandidateVO(data);
         if(_loc2_)
         {
            App.toolTipMgr.show(_loc2_.getToolTip());
         }
      }

      private function onRollOutHandler(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }
   }

}