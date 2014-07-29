package net.wg.gui.rally.controls
{
    import flash.display.MovieClip;
    import net.wg.gui.cyberSport.controls.GrayTransparentButton;
    import net.wg.gui.components.controls.VoiceWave;
    import net.wg.gui.prebattle.squad.MessengerUtils;
    import net.wg.infrastructure.events.VoiceChatEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.rally.events.RallyViewsEvent;
    
    public class RallySlotRenderer extends RallySimpleSlotRenderer
    {
        
        public function RallySlotRenderer()
        {
            super();
        }
        
        public static var STATUS_NORMAL:String = "normal";
        
        public static var STATUS_CANCELED:String = "canceled";
        
        public static var STATUS_READY:String = "ready";
        
        public static var STATUS_BATTLE:String = "inBattle";
        
        public static var STATUS_LOCKED:String = "locked";
        
        public static var STATUS_COMMANDER:String = "commander";
        
        public static var STATUSES:Array = [STATUS_NORMAL,STATUS_CANCELED,STATUS_READY,STATUS_BATTLE,STATUS_LOCKED,STATUS_COMMANDER];
        
        public var selfBg:MovieClip;
        
        public var removeBtn:GrayTransparentButton;
        
        public var voiceWave:VoiceWave = null;
        
        public function setStatus(param1:int) : String
        {
            var _loc2_:String = STATUS_NORMAL;
            if(index == 0 && !(param1 == STATUSES.indexOf(STATUS_BATTLE)))
            {
                _loc2_ = STATUS_COMMANDER;
            }
            else if(param1 < STATUSES.length && (param1))
            {
                _loc2_ = STATUSES[param1];
            }
            
            statusIndicator.gotoAndStop(_loc2_);
            return _loc2_;
        }
        
        public function updateVoiceWave() : void
        {
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            this.voiceWave.setMuted((slotData) && (slotData.playerObj)?MessengerUtils.isMuted(slotData.playerObj):false);
        }
        
        public function setSpeakers(param1:Boolean, param2:Boolean = false) : void
        {
            if(param1)
            {
                param2 = false;
            }
            if(this.voiceWave is VoiceWave)
            {
                this.voiceWave.setSpeaking(param1,param2);
            }
            if((slotData) && (slotData.playerObj))
            {
                slotData.playerObj.isPlayerSpeaking = param1;
            }
        }
        
        public function onPlayerSpeak(param1:Number, param2:Boolean) : void
        {
            if((slotData) && (slotData.playerObj) && param1 == slotData.playerObj.dbID)
            {
                this.setSpeakers(param2);
            }
        }
        
        override public function cooldown(param1:Boolean) : void
        {
            super.cooldown(param1);
            this.removeBtn.enabled = param1;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            App.voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
            App.voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
            this.removeBtn.addEventListener(ButtonEvent.CLICK,this.onRemoveClick);
            this.removeBtn.addEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
            this.removeBtn.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            statusIndicator.addEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
            statusIndicator.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            if(commander)
            {
                commander.addEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
                commander.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            }
            vehicleBtn.addEventListener(RallyViewsEvent.CHOOSE_VEHICLE,this.onChooseVehicleClick);
        }
        
        override protected function onDispose() : void
        {
            this.removeBtn.removeEventListener(ButtonEvent.CLICK,this.onRemoveClick);
            this.removeBtn.removeEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
            this.removeBtn.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.removeBtn.dispose();
            this.removeBtn = null;
            vehicleBtn.removeEventListener(RallyViewsEvent.CHOOSE_VEHICLE,this.onChooseVehicleClick);
            statusIndicator.removeEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
            statusIndicator.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            if(commander)
            {
                commander.removeEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
                commander.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            }
            App.voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.speakHandler);
            App.voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.speakHandler);
            this.voiceWave.dispose();
            this.voiceWave = null;
            super.onDispose();
        }
        
        protected function onRemoveClick(param1:ButtonEvent) : void
        {
            if((slotData) && (slotData.playerObj))
            {
                dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LEAVE_SLOT_REQUEST,slotData.playerObj.dbID));
            }
        }
        
        protected function onChooseVehicleClick(param1:RallyViewsEvent) : void
        {
            param1.preventDefault();
            param1.stopImmediatePropagation();
            if((slotData) && (slotData.playerObj) && (slotData.playerObj.himself))
            {
                dispatchEvent(new RallyViewsEvent(RallyViewsEvent.CHOOSE_VEHICLE,slotData.playerObj.dbID));
            }
        }
        
        protected function speakHandler(param1:VoiceChatEvent) : void
        {
            this.onPlayerSpeak(param1.getAccountDBID(),param1.type == VoiceChatEvent.START_SPEAKING);
        }
    }
}
