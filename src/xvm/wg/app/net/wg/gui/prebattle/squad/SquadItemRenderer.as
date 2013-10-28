package net.wg.gui.prebattle.squad
{
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.VoiceWave;
   import net.wg.gui.prebattle.data.PlayerPrbInfoVO;
   import net.wg.infrastructure.events.VoiceChatEvent;
   import scaleform.clik.utils.Constraints;
   import net.wg.gui.prebattle.constants.PrebattleStateString;
   import flash.events.MouseEvent;


   public class SquadItemRenderer extends SoundListItemRenderer
   {
          
      public function SquadItemRenderer() {
         super();
         soundType = "squad";
      }

      private static var UPDATE_STATUS:String = "updateStatus";

      public var vehicleLevelField:TextField;

      public var status:MovieClip;

      public var vehicleNameField:TextField;

      public var voiceWave:VoiceWave;

      protected var statusString:String = null;

      override public function set label(param1:String) : void {
         var param1:String = this.cutText(param1);
         super.label = param1;
      }

      private function cutText(param1:String) : String {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         textField.text = param1;
         if(textField.getLineLength(1) != -1)
         {
            _loc2_ = param1;
            _loc3_ = textField.getLineLength(0);
            _loc2_ = _loc2_.substr(0,_loc3_ - 2);
            _loc2_ = _loc2_ + "..";
            textField.text = _loc2_;
         }
         return textField.text;
      }

      public function get model() : PlayerPrbInfoVO {
         return data as PlayerPrbInfoVO;
      }

      override public function setData(param1:Object) : void {
         if(param1 == null)
         {
            visible = false;
            this.data = null;
            return;
         }
         if(!visible)
         {
            visible = true;
         }
         this.data = param1;
         invalidate(UPDATE_STATUS);
      }

      override protected function configUI() : void {
         textField.wordWrap = true;
         super.configUI();
         this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
         App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
         App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
         constraints.addElement("status",this.status,Constraints.ALL);
         constraints.addElement("vehicleNameField",this.vehicleNameField,Constraints.ALL);
      }

      override public function dispose() : void {
         super.dispose();
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
         App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
         this.voiceWave.dispose();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(UPDATE_STATUS)) && (this.model))
         {
            this.afterSetData();
            this.setSpeakers(this.model.isPlayerSpeaking,true);
         }
      }

      protected function afterSetData() : void {
         if(this.status)
         {
            this.status.visible = false;
            if(this.model == null)
            {
               return;
            }
            textField.alpha = this.vehicleNameField.alpha = 1;
            var _loc1_:* = this.model.getStateString();
            if(_loc1_ != PrebattleStateString.UNKNOWN)
            {
               this.statusString = _loc1_;
               this.status.gotoAndPlay(_loc1_);
               if(this.model.isOffline())
               {
                  textField.alpha = this.vehicleNameField.alpha = 0.9;
               }
               this.status.visible = true;
               if(this.hitTestPoint(mouseX,mouseY,true))
               {
                  this.showToolTips();
               }
            }
            var _loc2_:* = 4.290295975E9;
            var _loc3_:* = _loc2_;
            this.updateVoiceWave();
            this.label = this.model.fullName;
            _loc3_ = this.model.getCurrentColor();
            if(!isNaN(_loc3_))
            {
               textField.textColor = _loc3_;
               this.vehicleNameField.textColor = _loc3_;
               this.vehicleLevelField.textColor = _loc3_;
            }
            if(!(this.model.vLevel == null) && !(this.model.vLevel == ""))
            {
               this.vehicleLevelField.text = this.model.vLevel;
            }
            else
            {
               this.vehicleLevelField.text = "";
            }
            this.updateAfterStateChange();
            return;
         }
      }

      override protected function updateAfterStateChange() : void {
         super.updateAfterStateChange();
         if(!initialized || this.model == null)
         {
            return;
         }
         if(!(this.model.vLevel == null) && !(this.model.vLevel == ""))
         {
            this.vehicleLevelField.text = this.model.vLevel;
         }
         else
         {
            this.vehicleLevelField.text = "";
         }
         this.vehicleNameField.text = this.model.vShortName;
         this.updateVoiceWave();
         var _loc1_:Number = this.model.getCurrentColor();
         if(!isNaN(_loc1_))
         {
            textField.textColor = _loc1_;
            this.vehicleNameField.textColor = _loc1_;
            this.vehicleLevelField.textColor = _loc1_;
         }
      }

      override protected function handleMouseRollOver(param1:MouseEvent) : void {
         super.handleMouseRollOver(param1);
         this.showToolTips();
      }

      protected function showToolTips() : void {
         var _loc1_:String = this.model.accID == -1?MESSENGER.DIALOGS_TEAMCHANNEL_BUTTONS_INVITE:this.getToolTipData();
         if((_loc1_) && _loc1_.length > 0)
         {
            App.toolTipMgr.show(_loc1_);
         }
      }

      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }

      protected function getToolTipData() : String {
         if((this.statusString) && this.statusString == PrebattleStateString.OFFLINE_READY)
         {
            this.statusString = PrebattleStateString.OFFLINE;
         }
         return this.statusString != null?"#messenger:dialogs/squadChannel/tooltips/status/" + this.statusString:null;
      }

      private function speakHandler(param1:VoiceChatEvent) : void {
         this.onPlayerSpeak(param1.getAccountDBID(),param1.type == VoiceChatEvent.START_SPEAKING);
      }

      public function onPlayerSpeak(param1:Number, param2:Boolean) : void {
         if((this.model) && param1 == this.model.uid)
         {
            this.setSpeakers(param2);
         }
      }

      protected function updateVoiceWave() : void {
         this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
         this.voiceWave.setMuted(MessengerUtils.isMuted(this.model));
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
      }
   }

}