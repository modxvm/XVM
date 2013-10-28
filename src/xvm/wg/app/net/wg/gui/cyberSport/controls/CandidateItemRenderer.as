package net.wg.gui.cyberSport.controls
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.VoiceWave;
   import net.wg.infrastructure.events.VoiceChatEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.cyberSport.vo.UnitCandidateVO;
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
      }

      override public function dispose() : void {
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
         this.voiceWave.dispose();
         this.voiceWave = null;
         this.inviteIndicator = null;
         this.candidateName = null;
         super.dispose();
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            visible = !(data == null);
            if(data)
            {
               this.inviteIndicator.visible = UnitCandidateVO(data).isInvite;
               this.candidateName.htmlText = App.utils.commons.formatPlayerName(this.candidateName,UnitCandidateVO(data).name);
               this.candidateRating.text = UnitCandidateVO(data).rating.toString();
               this.setSpeakers(data.isPlayerSpeaking,true);
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
   }

}