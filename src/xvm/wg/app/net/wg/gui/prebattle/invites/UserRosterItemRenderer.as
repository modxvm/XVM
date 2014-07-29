package net.wg.gui.prebattle.invites
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.VoiceWave;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import net.wg.gui.prebattle.squad.MessengerUtils;
    
    public class UserRosterItemRenderer extends SoundListItemRenderer
    {
        
        public function UserRosterItemRenderer()
        {
            super();
            toggle = true;
            selectable = true;
            allowDeselect = false;
            this.visible = false;
            _state = "up";
        }
        
        public var focusIndicatorA:MovieClip;
        
        public var status:MovieClip;
        
        public var voiceWave:VoiceWave;
        
        override protected function handleMouseRollOver(param1:MouseEvent) : void
        {
            super.handleMouseRollOver(param1);
            App.toolTipMgr.show(data.displayName);
        }
        
        override protected function handleMouseRollOut(param1:MouseEvent) : void
        {
            super.handleMouseRollOut(param1);
            App.toolTipMgr.hide();
        }
        
        override protected function configUI() : void
        {
            if(this.focusIndicatorA)
            {
                focusIndicator = this.focusIndicatorA;
            }
            super.configUI();
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            this.voiceWave.validateNow();
        }
        
        override protected function draw() : void
        {
            var _loc2_:Point = null;
            var _loc1_:Boolean = (isInvalid("update_data")) && (data);
            if((_loc1_) && (enabled))
            {
                _loc2_ = new Point(mouseX,mouseY);
                _loc2_ = localToGlobal(_loc2_);
                if(hitTestPoint(_loc2_.x,_loc2_.y,true))
                {
                    setState("over");
                    App.soundMgr.playControlsSnd(state,soundType,soundId);
                    dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
                }
            }
            super.draw();
            if(_loc1_)
            {
                this.afterSetData();
            }
        }
        
        override public function setData(param1:Object) : void
        {
            if(param1 == null)
            {
                this.visible = false;
                return;
            }
            if((param1.hasOwnProperty("uid")) && !(param1.uid == null))
            {
                this.visible = true;
                this.data = param1;
                invalidate("update_data");
            }
        }
        
        override public function set label(param1:String) : void
        {
            var param1:String = this.cutText(param1);
            super.label = param1;
        }
        
        private function afterSetData() : void
        {
            if(this.status == null)
            {
                return;
            }
            this.status.visible = false;
            if(data == null)
            {
                return;
            }
            this.label = data.displayName;
            if((data.hasOwnProperty("chatRoster")) && ((MessengerUtils.isIgnored(data)) || (MessengerUtils.isMuted(data))))
            {
                this.status.gotoAndPlay("ignored");
                this.status.visible = true;
                if(data.colors[1] != null)
                {
                    textField.textColor = data.colors[1];
                }
            }
            else
            {
                if((data.hasOwnProperty("himself")) && (data.himself))
                {
                    if((data.hasOwnProperty("colors")) && !(data.colors[0] == null))
                    {
                        textField.textColor = data.colors[0];
                    }
                    this.status.gotoAndPlay("himself");
                }
                else if((data.hasOwnProperty("online")) && (data.online))
                {
                    if(data.colors[0] != null)
                    {
                        textField.textColor = data.colors[0];
                    }
                    this.status.gotoAndPlay("online");
                }
                else
                {
                    if((data.hasOwnProperty("colors")) && !(data.colors[1] == null))
                    {
                        textField.textColor = data.colors[1];
                    }
                    this.status.gotoAndPlay("offline");
                }
                
                this.status.visible = true;
            }
            if(data.hasOwnProperty("chatRoster"))
            {
                this.updateVoiceWave();
            }
            invalidate();
        }
        
        override protected function updateAfterStateChange() : void
        {
            if(data == null)
            {
                return;
            }
            var _loc1_:* = false;
            var _loc2_:* = false;
            if(data.hasOwnProperty("chatRoster"))
            {
                _loc1_ = MessengerUtils.isMuted(data);
                _loc2_ = MessengerUtils.isIgnored(data);
            }
            if(!initialized || data == null)
            {
                return;
            }
            this.updateVoiceWave();
            if((data.hasOwnProperty("colors")) && (data.hasOwnProperty("online")))
            {
                if((_loc2_) || (_loc1_))
                {
                    if(data.colors[1] != null)
                    {
                        textField.textColor = data.colors[1];
                    }
                }
                else if(data.online)
                {
                    if(data.colors[0] != null)
                    {
                        textField.textColor = data.colors[0];
                    }
                }
                else if(data.colors[1] != null)
                {
                    textField.textColor = data.colors[1];
                }
                
                
            }
            super.updateAfterStateChange();
        }
        
        protected function updateVoiceWave() : void
        {
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            this.voiceWave.setMuted(MessengerUtils.isMuted(data));
            this.voiceWave.validateNow();
        }
        
        private function cutText(param1:String) : String
        {
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
    }
}
