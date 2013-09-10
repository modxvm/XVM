package net.wg.gui.components.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.controls.*;
    
    public class SoundButton extends scaleform.clik.controls.Button implements net.wg.infrastructure.interfaces.entity.ISoundable
    {
        public function SoundButton()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            if (this.hitMc != null) 
                this.hitArea = this.hitMc;
            buttonMode = true;
            if (App.soundMgr != null) 
                App.soundMgr.addSoundsHdlrs(this);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        public override function toString():String
        {
            return "[WG SoundButton " + name + "]";
        }

        public final function getSoundType():String
        {
            return this.soundType;
        }

        public final function getSoundId():String
        {
            return this.soundId;
        }

        public final function getStateOverSnd():String
        {
            return net.wg.data.constants.SoundManagerStates.SND_OVER;
        }

        public final function getStateOutSnd():String
        {
            return net.wg.data.constants.SoundManagerStates.SND_OUT;
        }

        public final function getStatePressSnd():String
        {
            return net.wg.data.constants.SoundManagerStates.SND_PRESS;
        }

        public function beginButtonRepeat():void
        {
            if (autoRepeat && _repeatTimer == null) 
            {
                _repeatTimer = new flash.utils.Timer(repeatDelay, 1);
                _repeatTimer.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, beginRepeat, false, 0, true);
                _repeatTimer.start();
            }
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (arg1 == enabled) 
                return;
            if (this.focusable && this.focused && !arg1) 
                this.focused = 0;
            super.enabled = arg1;
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            return;
        }

        public var soundType:String="normal";

        public var soundId:String="";

        public var hitMc:flash.display.MovieClip;
    }
}
