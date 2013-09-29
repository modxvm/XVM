package net.wg.gui.messenger.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.messenger.data.*;
    import net.wg.gui.prebattle.squad.*;
    import net.wg.infrastructure.events.*;
    import scaleform.clik.constants.*;
    
    public class MemberItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function MemberItemRenderer()
        {
            super();
            return;
        }

        public override function setData(arg1:Object):void
        {
            super.setData(arg1);
            if (!arg1) 
            {
                visible = false;
                this.model = null;
                return;
            }
            visible = true;
            this.model = new net.wg.gui.messenger.data.ChannelMemberVO(arg1);
            label = this.model.userName;
            this.tooltip = this.model.userName;
            invalidateData();
            return;
        }

        public override function dispose():void
        {
            if (this.model) 
            {
                this.model.dispose();
                this.model = null;
            }
            App.voiceChatMgr.removeEventListener(net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING, this.speakHandler);
            App.voiceChatMgr.removeEventListener(net.wg.infrastructure.events.VoiceChatEvent.STOP_SPEAKING, this.speakHandler);
            super.dispose();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            App.voiceChatMgr.addEventListener(net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING, this.speakHandler);
            App.voiceChatMgr.addEventListener(net.wg.infrastructure.events.VoiceChatEvent.STOP_SPEAKING, this.speakHandler);
            setState("out");
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && this.model) 
            {
                this.status.gotoAndPlay(this.getStatusFrame());
                this.voiceWave.setMuted(net.wg.gui.prebattle.squad.MessengerUtils.isMuted(this.model));
                this.setSpeaking(this.model.isPlayerSpeaking, true);
                if (enabled) 
                {
                    loc1 = new flash.geom.Point(mouseX, mouseY);
                    loc1 = localToGlobal(loc1);
                    if (hitTestPoint(loc1.x, loc1.y, true)) 
                    {
                        setState("over");
                        App.soundMgr.playControlsSnd(state, soundType, soundId);
                        dispatchEvent(new flash.events.MouseEvent(flash.events.MouseEvent.ROLL_OVER));
                    }
                }
            }
            super.draw();
            return;
        }

        protected override function updateAfterStateChange():void
        {
            super.updateAfterStateChange();
            if (this.model) 
            {
                textField.textColor = this.model.color;
            }
            return;
        }

        internal function getStatusFrame():String
        {
            var loc1:*=net.wg.gui.prebattle.squad.MessengerUtils.isIgnored(this.model) ? STATUS_IGNORED : this.model.himself ? STATUS_HIMSELF : STATUS_ONLINE;
            return loc1;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(arg1);
            if (this.tooltip) 
            {
                App.toolTipMgr.show(this.tooltip);
            }
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOut(arg1);
            App.toolTipMgr.hide();
            if (enabled) 
            {
                if (!_focused && !_displayFocus || !(focusIndicator == null)) 
                {
                    setState("out");
                }
            }
            return;
        }

        protected override function updateText():void
        {
            if (!(_label == null) && !(textField == null)) 
            {
                textField.text = _label;
                this.truncateText();
            }
            return;
        }

        internal function truncateText():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            if (textField.textWidth > textField.width - TEXT_WIDTH_CORRECTION) 
            {
                loc1 = textField.text.length > 0 ? textField.text : _label;
                loc2 = loc1;
                loc3 = 1;
                while (loc2.length > 0 && loc3 > 0) 
                {
                    loc2 = loc1.substring(0, loc1.length - loc3) + "..";
                    textField.text = loc2;
                    if (textField.textWidth > textField.width - TEXT_WIDTH_CORRECTION) 
                    {
                        ++loc3;
                        continue;
                    }
                    loc3 = 0;
                }
            }
            return;
        }

        internal function speakHandler(arg1:net.wg.infrastructure.events.VoiceChatEvent):void
        {
            var loc1:*=arg1.getAccountDBID();
            var loc2:*=arg1.type == net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING;
            if (this.model && this.model.uid == loc1) 
            {
                this.setSpeaking(loc2, false);
            }
            return;
        }

        internal function setSpeaking(arg1:Boolean, arg2:Boolean=false):void
        {
            if (arg1) 
            {
                arg2 = false;
            }
            if (this.voiceWave is net.wg.gui.components.controls.VoiceWave) 
            {
                this.voiceWave.setSpeaking(arg1, arg2);
            }
            return;
        }

        internal static const TEXT_WIDTH_CORRECTION:Number=12;

        internal static const STATUS_ONLINE:String="online";

        internal static const STATUS_OFFLINE:String="offline";

        internal static const STATUS_IGNORED:String="ignored";

        internal static const STATUS_HIMSELF:String="himself";

        public var status:flash.display.MovieClip;

        public var voiceWave:net.wg.gui.components.controls.VoiceWave;

        protected var model:net.wg.gui.messenger.data.ChannelMemberVO;

        protected var tooltip:String;
    }
}
