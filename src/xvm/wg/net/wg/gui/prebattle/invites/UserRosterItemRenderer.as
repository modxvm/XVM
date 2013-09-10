package net.wg.gui.prebattle.invites 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.prebattle.squad.*;
    
    public class UserRosterItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function UserRosterItemRenderer()
        {
            super();
            toggle = true;
            selectable = true;
            allowDeselect = false;
            this.visible = false;
            _state = "up";
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(arg1);
            App.toolTipMgr.show(data.displayName);
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOut(arg1);
            App.toolTipMgr.hide();
            return;
        }

        protected override function configUI():void
        {
            if (this.focusIndicatorA) 
                focusIndicator = this.focusIndicatorA;
            super.configUI();
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            this.voiceWave.validateNow();
            return;
        }

        protected override function draw():void
        {
            var loc2:*=null;
            var loc1:*=isInvalid("update_data") && data;
            if (loc1 && enabled) 
            {
                loc2 = new flash.geom.Point(mouseX, mouseY);
                loc2 = localToGlobal(loc2);
                if (hitTestPoint(loc2.x, loc2.y, true)) 
                {
                    setState("over");
                    App.soundMgr.playControlsSnd(state, soundType, soundId);
                    dispatchEvent(new flash.events.MouseEvent(flash.events.MouseEvent.ROLL_OVER));
                }
            }
            super.draw();
            if (loc1) 
                this.afterSetData();
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1 == null) 
            {
                this.visible = false;
                return;
            }
            if (arg1.hasOwnProperty("uid") && !(arg1.uid == null)) 
            {
                this.visible = true;
                this.data = arg1;
                invalidate("update_data");
            }
            return;
        }

        public override function set label(arg1:String):void
        {
            arg1 = this.cutText(arg1);
            super.label = arg1;
            return;
        }

        internal function afterSetData():void
        {
            if (this.status == null) 
                return;
            this.status.visible = false;
            if (data == null) 
                return;
            this.label = data.displayName;
            if (data.hasOwnProperty("chatRoster") && net.wg.gui.prebattle.squad.MessengerUtils.isIgnored(data)) 
            {
                this.status.gotoAndPlay("ignored");
                this.status.visible = true;
                if (data.colors[1] != null) 
                    textField.textColor = data.colors[1];
            }
            else 
            {
                if (data.hasOwnProperty("himself") && data.himself) 
                {
                    if (data.hasOwnProperty("colors") && !(data.colors[0] == null)) 
                        textField.textColor = data.colors[0];
                    this.status.gotoAndPlay("himself");
                }
                else if (data.hasOwnProperty("online") && data.online) 
                {
                    if (data.colors[0] != null) 
                        textField.textColor = data.colors[0];
                    this.status.gotoAndPlay("online");
                }
                else 
                {
                    if (data.hasOwnProperty("colors") && !(data.colors[1] == null)) 
                        textField.textColor = data.colors[1];
                    this.status.gotoAndPlay("offline");
                }
                this.status.visible = true;
            }
            if (data.hasOwnProperty("chatRoster")) 
                this.updateVoiceWave();
            invalidate();
            return;
        }

        protected override function updateAfterStateChange():void
        {
            if (data == null) 
                return;
            var loc1:*=false;
            var loc2:*=false;
            if (data.hasOwnProperty("chatRoster")) 
            {
                loc1 = net.wg.gui.prebattle.squad.MessengerUtils.isMuted(data);
                loc2 = net.wg.gui.prebattle.squad.MessengerUtils.isIgnored(data);
            }
            if (!initialized || data == null) 
                return;
            this.updateVoiceWave();
            if (data.hasOwnProperty("colors") && data.hasOwnProperty("online")) 
                if (loc2) 
                    if (data.colors[1] != null) 
                        textField.textColor = data.colors[1];
                else if (data.online) 
                    if (data.colors[0] != null) 
                        textField.textColor = data.colors[0];
                else if (data.colors[1] != null) 
                    textField.textColor = data.colors[1];
            super.updateAfterStateChange();
            return;
        }

        protected function updateVoiceWave():void
        {
            this.voiceWave.visible = App.voiceChatMgr.isVOIPEnabledS();
            this.voiceWave.setMuted(net.wg.gui.prebattle.squad.MessengerUtils.isMuted(data));
            this.voiceWave.validateNow();
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

        public var focusIndicatorA:flash.display.MovieClip;

        public var status:flash.display.MovieClip;

        public var voiceWave:net.wg.gui.components.controls.VoiceWave;
    }
}
