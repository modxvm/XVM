package net.wg.gui.components.controls 
{
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    
    public class RadioButton extends scaleform.clik.controls.RadioButton implements net.wg.infrastructure.interfaces.entity.ISoundable
    {
        public function RadioButton()
        {
            super();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            _label = "";
            toggle = true;
            allowDeselect = false;
            buttonMode = true;
            if (_group == null) 
                groupName = null;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            App.soundMgr.addSoundsHdlrs(this);
            return;
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

        public override function dispose():void
        {
            removeEventListener(flash.events.Event.ADDED, addToAutoGroup, false);
            removeEventListener(flash.events.Event.REMOVED, addToAutoGroup, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, handleMouseRollOver, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, handleMouseRollOut, false);
            removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, handleMousePress, false);
            removeEventListener(flash.events.MouseEvent.CLICK, handleMouseRelease, false);
            removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, handleMouseRelease, false);
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput, false);
            if (_repeatTimer) 
            {
                _repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, beginRepeat, false);
                _repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER, handleRepeat, false);
            }
            super.dispose();
            return;
        }

        public var soundType:String="radioButton";

        public var soundId:String="";
    }
}
