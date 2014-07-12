package net.wg.gui.messenger.controls
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.VoiceWave;
    import net.wg.gui.messenger.data.ChannelMemberVO;
    import flash.geom.Point;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.prebattle.squad.MessengerUtils;
    import flash.events.MouseEvent;
    import net.wg.infrastructure.events.VoiceChatEvent;
    
    public class MemberItemRenderer extends SoundListItemRenderer
    {
        
        public function MemberItemRenderer() {
            super();
        }
        
        private static var TEXT_WIDTH_CORRECTION:Number = 12;
        
        private static var STATUS_ONLINE:String = "online";
        
        private static var STATUS_OFFLINE:String = "offline";
        
        private static var STATUS_IGNORED:String = "ignored";
        
        private static var STATUS_HIMSELF:String = "himself";
        
        public var status:MovieClip;
        
        public var voiceWave:VoiceWave;
        
        protected var model:ChannelMemberVO;
        
        protected var tooltip:String;
        
        override public function setData(param1:Object) : void {
            super.setData(param1);
            if(!param1)
            {
                visible = false;
                this.model = null;
                return;
            }
            visible = true;
            this.model = new ChannelMemberVO(param1);
            label = this.model.userName;
            this.tooltip = this.model.userName;
            invalidateData();
        }
        
        override protected function onDispose() : void {
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
            super.onDispose();
        }
        
        override protected function configUI() : void {
            super.configUI();
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            setState("out");
        }
        
        override protected function draw() : void {
            var _loc1_:Point = null;
            if((isInvalid(InvalidationType.DATA)) && (this.model))
            {
                this.status.gotoAndPlay(this.getStatusFrame());
                this.voiceWave.setMuted(MessengerUtils.isMuted(this.model));
                this.setSpeaking(this.model.isPlayerSpeaking,true);
                if(enabled)
                {
                    _loc1_ = new Point(mouseX,mouseY);
                    _loc1_ = localToGlobal(_loc1_);
                    if(hitTestPoint(_loc1_.x,_loc1_.y,true))
                    {
                        setState("over");
                        App.soundMgr.playControlsSnd(state,soundType,soundId);
                        dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
                    }
                }
            }
            super.draw();
        }
        
        override protected function updateAfterStateChange() : void {
            super.updateAfterStateChange();
            if(this.model)
            {
                textField.textColor = this.model.color;
            }
        }
        
        private function getStatusFrame() : String {
            var _loc1_:String = MessengerUtils.isIgnored(this.model)?STATUS_IGNORED:this.model.himself?STATUS_HIMSELF:STATUS_ONLINE;
            return _loc1_;
        }
        
        override protected function handleMouseRollOver(param1:MouseEvent) : void {
            super.handleMouseRollOver(param1);
            if(this.tooltip)
            {
                App.toolTipMgr.show(this.tooltip);
            }
        }
        
        override protected function handleMouseRollOut(param1:MouseEvent) : void {
            super.handleMouseRollOut(param1);
            App.toolTipMgr.hide();
            if(enabled)
            {
                if(!_focused && !_displayFocus || !(focusIndicator == null))
                {
                    setState("out");
                }
            }
        }
        
        override protected function updateText() : void {
            if(!(_label == null) && !(textField == null))
            {
                textField.text = _label;
                if(this.model)
                {
                    textField.textColor = this.model.color;
                }
                this.truncateText();
            }
        }
        
        private function truncateText() : void {
            var _loc1_:String = null;
            var _loc2_:String = null;
            var _loc3_:uint = 0;
            if(textField.textWidth > textField.width - TEXT_WIDTH_CORRECTION)
            {
                _loc1_ = textField.text.length > 0?textField.text:_label;
                _loc2_ = _loc1_;
                _loc3_ = 1;
                while(_loc2_.length > 0 && _loc3_ > 0)
                {
                    _loc2_ = _loc1_.substring(0,_loc1_.length - _loc3_) + "..";
                    textField.text = _loc2_;
                    if(textField.textWidth > textField.width - TEXT_WIDTH_CORRECTION)
                    {
                        _loc3_++;
                    }
                    else
                    {
                        _loc3_ = 0;
                    }
                }
            }
        }
        
        private function speakHandler(param1:VoiceChatEvent) : void {
            var _loc2_:uint = param1.getAccountDBID();
            var _loc3_:* = param1.type == VoiceChatEvent.START_SPEAKING;
            if((this.model) && this.model.uid == _loc2_)
            {
                this.setSpeaking(_loc3_,false);
            }
        }
        
        private function setSpeaking(param1:Boolean, param2:Boolean = false) : void {
            if(param1)
            {
                param2 = false;
            }
            if(this.voiceWave is VoiceWave)
            {
                this.voiceWave.setSpeaking(param1,param2);
            }
        }
    }
}
