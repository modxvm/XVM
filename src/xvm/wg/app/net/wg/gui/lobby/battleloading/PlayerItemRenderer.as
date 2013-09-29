package net.wg.gui.lobby.battleloading 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.icons.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    
    public class PlayerItemRenderer extends scaleform.clik.controls.ListItemRenderer
    {
        public function PlayerItemRenderer()
        {
            super();
            this.visible = false;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            App.voiceChatMgr.addEventListener(net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING, this.speakHandler);
            App.voiceChatMgr.addEventListener(net.wg.infrastructure.events.VoiceChatEvent.STOP_SPEAKING, this.speakHandler);
            if (hasEventListener(flash.events.MouseEvent.ROLL_OVER)) 
            {
                removeEventListener(flash.events.MouseEvent.ROLL_OVER, handleMouseRollOver);
            }
            if (hasEventListener(flash.events.MouseEvent.ROLL_OUT)) 
            {
                removeEventListener(flash.events.MouseEvent.ROLL_OUT, handleMouseRollOut);
            }
            if (hasEventListener(flash.events.MouseEvent.MOUSE_DOWN)) 
            {
                removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, handleMousePress);
            }
            if (hasEventListener(flash.events.MouseEvent.CLICK)) 
            {
                removeEventListener(flash.events.MouseEvent.CLICK, handleMouseRelease);
            }
            if (hasEventListener(flash.events.MouseEvent.DOUBLE_CLICK)) 
            {
                removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, handleMouseRelease);
            }
            if (hasEventListener(scaleform.clik.events.InputEvent.INPUT)) 
            {
                removeEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput);
            }
            this.updateState();
            return;
        }

        internal function speakHandler(arg1:net.wg.infrastructure.events.VoiceChatEvent):void
        {
            this.onPlayerSpeak(arg1.getAccountDBID(), arg1.type == net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING);
            return;
        }

        public function onPlayerSpeak(arg1:uint, arg2:Boolean):void
        {
            if (data && arg1 == data.id && this.voiceWave) 
            {
                this.voiceWave.setSpeaking(arg2);
            }
            return;
        }

        public override function dispose():void
        {
            App.voiceChatMgr.removeEventListener(net.wg.infrastructure.events.VoiceChatEvent.START_SPEAKING, this.speakHandler);
            App.voiceChatMgr.removeEventListener(net.wg.infrastructure.events.VoiceChatEvent.STOP_SPEAKING, this.speakHandler);
            super.dispose();
            return;
        }

        protected override function draw():void
        {
            this.update();
            super.draw();
            return;
        }

        public override function setData(arg1:Object):void
        {
            this.data = arg1;
            invalidate();
            return;
        }

        internal function update():void
        {
            if (data && initialized) 
            {
                this.selfBg.visible = _selected;
                if (data.label) 
                {
                    label = App.utils.commons.formatPlayerName(textField, data.label, data.clanAbbrev, null, data.isIGR);
                }
                if (!(this.vehicleField == null) && !(data.vehicle == null)) 
                {
                    this.vehicleField.text = data.vehicle;
                }
                if (this.iconLoader != null) 
                {
                    this.iconLoader.visible = true;
                    if (this.iconLoader.source != data.icon) 
                    {
                        this.iconLoader.source = data.icon;
                    }
                }
                if (!(this.squad == null) && this.squad.setSquad && !(data.squad == null)) 
                {
                    this.squad.setSquad(data.squad);
                }
                if (data.enabled != null) 
                {
                    this.enabled = data.enabled;
                }
                if (this.voiceWave != null) 
                {
                    if (data.speak) 
                    {
                        this.voiceWave.setSpeaking(true);
                    }
                    if (data.muted != null) 
                    {
                        this.voiceWave.setMuted(data.muted);
                    }
                }
                if (!(this.playerActionMarker == null) && !(data.vehAction == null) && !(data.team == null)) 
                {
                    this.playerActionMarker.action = data.vehAction;
                    this.playerActionMarker.team = data.team != "team1" ? "enemy" : "myteam";
                }
                this.updateState();
                this.visible = true;
            }
            else 
            {
                this.selfBg.visible = false;
                textField.htmlText = "";
                this.vehicleField.text = "";
                this.iconLoader.visible = false;
                this.enabled = false;
                if (this.voiceWave != null) 
                {
                    this.voiceWave.setSpeaking(false, true);
                    this.voiceWave.setMuted(false);
                }
                if (this.playerActionMarker != null) 
                {
                    this.playerActionMarker.action = 0;
                }
            }
            return;
        }

        protected override function setState(arg1:String):void
        {
            return;
        }

        protected override function updateText():void
        {
            if (!(_label == null) && !(textField == null)) 
            {
                textField.htmlText = _label;
            }
            return;
        }

        internal function updateState():void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=NaN;
            var loc6:*=null;
            var loc1:*=null;
            var loc2:*=false;
            if (_selected || !(data == null) && data.squad > 10) 
            {
                loc2 = true;
                loc1 = App.colorSchemeMgr.getScheme(super.enabled ? "selected" : "selected_dead");
            }
            else if (!(data == null) && data.isTeamKiller) 
            {
                loc1 = App.colorSchemeMgr.getScheme(super.enabled ? "teamkiller" : "teamkiller_dead");
            }
            else 
            {
                loc1 = App.colorSchemeMgr.getScheme(super.enabled ? "normal" : "normal_dead");
            }
            if (loc1) 
            {
                if (data) 
                {
                    label = App.utils.commons.formatPlayerName(textField, data.label, data.clanAbbrev, null, data.isIGR, loc1);
                }
                this.vehicleField.textColor = loc1.rgb;
                if (loc2) 
                {
                    (loc4 = new flash.geom.ColorTransform()).redOffset = 21;
                    loc4.greenOffset = 9;
                    loc4.blueMultiplier = 0.51;
                    loc4.greenMultiplier = 0.87;
                    this.iconLoader.transform.colorTransform = loc4;
                }
                else 
                {
                    loc3 = new flash.geom.Transform(this.iconLoader);
                    loc3.colorTransform = loc1.colorTransform;
                }
            }
            else 
            {
                loc5 = super.enabled ? 16777215 : 5130300;
                loc6 = super.enabled ? new flash.geom.ColorTransform(1, 1, 1, 1, 0, 0, 0, 0) : new flash.geom.ColorTransform(0.8, 0.8, 0.8, 0.5, 0, 0, 0, 0);
                textField.textColor = loc5;
                this.vehicleField.textColor = loc5;
                loc3 = new flash.geom.Transform(this.iconLoader);
                loc3.colorTransform = loc6;
            }
            return;
        }

        protected override function updateAfterStateChange():void
        {
            invalidate();
            return;
        }

        public override function get enabled():Boolean
        {
            return this._enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (this._enabled == arg1) 
            {
                return;
            }
            this._enabled = arg1;
            super.enabled = this._enabled;
            this.updateState();
            return;
        }

        public override function get selected():Boolean
        {
            return _selected;
        }

        public override function set selected(arg1:Boolean):void
        {
            if (_selected == arg1) 
            {
                return;
            }
            _selected = arg1;
            this.updateState();
            dispatchEvent(new flash.events.Event(flash.events.Event.SELECT));
            return;
        }

        public override function toString():String
        {
            return "[WG PlayerItemRenderer " + name;
        }

        public var selfBg:flash.display.Sprite;

        public var vehicleField:flash.text.TextField;

        public var iconLoader:net.wg.gui.components.controls.UILoaderAlt;

        public var squad:net.wg.gui.components.icons.SquadIcon;

        public var voiceWave:net.wg.gui.components.controls.VoiceWave;

        public var playerActionMarker:net.wg.gui.components.icons.PlayerActionMarker;

        internal var _enabled:Boolean=false;
    }
}
