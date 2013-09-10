package net.wg.gui.prebattle.squad 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.prebattle.constants.*;
    import net.wg.gui.prebattle.data.*;
    import net.wg.infrastructure.events.*;
    import scaleform.clik.utils.*;
    
    public class SquadItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function SquadItemRenderer()
        {
            super();
            soundType = "squad";
            return;
        }

        public override function set label(arg1:String):void
        {
            arg1 = this.cutText(arg1);
            super.label = arg1;
            return;
        }

        internal function cutText(arg1:String):String
        {
            var loc1:*=null;
            var loc2:*=0;
            textField.text = arg1;
            if (textField.getLineLength(1) != -1) 
            {
                loc1 = arg1;
                loc2 = textField.getLineLength(0);
                loc1 = loc1.substr(0, loc2 - 2);
                loc1 = loc1 + "..";
                textField.text = loc1;
            }
            return textField.text;
        }

        public function get model():net.wg.gui.prebattle.data.PlayerPrbInfoVO
        {
            return data as net.wg.gui.prebattle.data.PlayerPrbInfoVO;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1 == null) 
            {
                visible = false;
                this.data = null;
                return;
            }
            if (!visible) 
                visible = true;
            this.data = arg1;
            invalidate(UPDATE_STATUS);
            return;
        }

        protected override function configUI():void
        {
            textField.wordWrap = true;
            super.configUI();
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            App.voiceChatMgr.addEventListener(net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING, this.speakHandler);
            App.voiceChatMgr.addEventListener(net.wg.infrastructure.events.VoiceChatEvent.STOP_SPEAKING, this.speakHandler);
            constraints.addElement("status", this.status, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement("vehicleNameField", this.vehicleNameField, scaleform.clik.utils.Constraints.ALL);
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            App.voiceChatMgr.removeEventListener(net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING, this.speakHandler);
            App.voiceChatMgr.removeEventListener(net.wg.infrastructure.events.VoiceChatEvent.STOP_SPEAKING, this.speakHandler);
            this.voiceWave.dispose();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(UPDATE_STATUS) && this.model) 
            {
                this.afterSetData();
                this.setSpeakers(this.model.isPlayerSpeaking, true);
            }
            return;
        }

        protected function afterSetData():void
        {
            if (this.status) 
                this.status.visible = false;
            else 
                return;
            if (this.model == null) 
                return;
            var loc4:*;
            this.vehicleNameField.alpha = loc4 = 1;
            textField.alpha = loc4;
            var loc1:*=this.model.getStateString();
            if (loc1 != net.wg.gui.prebattle.constants.PrebattleStateString.UNKNOWN) 
            {
                this.statusString = loc1;
                this.status.gotoAndPlay(loc1);
                if (this.model.isOffline()) 
                {
                    this.vehicleNameField.alpha = loc4 = 0.9;
                    textField.alpha = loc4;
                }
                this.status.visible = true;
                if (this.hitTestPoint(mouseX, mouseY, true)) 
                    this.showToolTips();
            }
            var loc2:*=4290295975;
            var loc3:*=loc2;
            this.updateVoiceWave();
            this.label = this.model.fullName;
            loc3 = this.model.getCurrentColor();
            if (!isNaN(loc3)) 
            {
                textField.textColor = loc3;
                this.vehicleNameField.textColor = loc3;
            }
            this.updateAfterStateChange();
            return;
        }

        protected override function updateAfterStateChange():void
        {
            super.updateAfterStateChange();
            if (!initialized || this.model == null) 
                return;
            this.vehicleNameField.text = this.model.vShortName;
            this.updateVoiceWave();
            var loc1:*=this.model.getCurrentColor();
            if (!isNaN(loc1)) 
            {
                textField.textColor = loc1;
                this.vehicleNameField.textColor = loc1;
            }
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(arg1);
            this.showToolTips();
            if (enabled) 
                this.playSound("over");
            return;
        }

        protected function showToolTips():void
        {
            var loc1:*=this.model.accID != -1 ? this.getToolTipData() : MESSENGER.DIALOGS_TEAMCHANNEL_BUTTONS_INVITE;
            if (loc1 && loc1.length > 0) 
                App.toolTipMgr.show(loc1);
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOut(arg1);
            App.toolTipMgr.hide();
            if (enabled) 
                this.playSound("out");
            return;
        }

        protected override function handleMousePress(arg1:flash.events.MouseEvent):void
        {
            super.handleMousePress(arg1);
            if (enabled) 
                this.playSound("press");
            return;
        }

        protected function getToolTipData():String
        {
            if (this.statusString && this.statusString == net.wg.gui.prebattle.constants.PrebattleStateString.OFFLINE_READY) 
                this.statusString = net.wg.gui.prebattle.constants.PrebattleStateString.OFFLINE;
            return this.statusString == null ? null : "#messenger:dialogs/squadChannel/tooltips/status/" + this.statusString;
        }

        internal function playSound(arg1:String):void
        {
            App.soundMgr.playControlsSnd(arg1, soundType, soundId);
            return;
        }

        internal function speakHandler(arg1:net.wg.infrastructure.events.VoiceChatEvent):void
        {
            this.onPlayerSpeak(arg1.getAccountDBID(), arg1.type == net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING);
            return;
        }

        public function onPlayerSpeak(arg1:uint, arg2:Boolean):void
        {
            if (this.model && arg1 == this.model.uid) 
                this.setSpeakers(arg2);
            return;
        }

        protected function updateVoiceWave():void
        {
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            this.voiceWave.setMuted(net.wg.gui.prebattle.squad.MessengerUtils.isMuted(this.model));
            return;
        }

        protected function setSpeakers(arg1:Boolean, arg2:Boolean=false):void
        {
            if (arg1) 
                arg2 = false;
            if (this.voiceWave is net.wg.gui.components.controls.VoiceWave) 
                this.voiceWave.setSpeaking(arg1, arg2);
            return;
        }

        
        {
            UPDATE_STATUS = "updateStatus";
        }

        public var status:flash.display.MovieClip;

        public var vehicleNameField:flash.text.TextField;

        public var voiceWave:net.wg.gui.components.controls.VoiceWave;

        protected var statusString:String=null;

        internal static var UPDATE_STATUS:String="updateStatus";
    }
}
