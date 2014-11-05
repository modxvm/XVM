package net.wg.gui.components.advanced
{
    import net.wg.gui.components.controls.SoundButton;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.gfx.MouseEventEx;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    
    public class AmmunitionButton extends SoundButton
    {
        
        public function AmmunitionButton()
        {
            super();
        }
        
        override protected function handleMousePress(param1:MouseEvent) : void
        {
            var _loc5_:ButtonEvent = null;
            var _loc2_:MouseEventEx = param1 as MouseEventEx;
            var _loc3_:uint = _loc2_ == null?0:_loc2_.mouseIdx;
            var _loc4_:uint = _loc2_ == null?0:_loc2_.buttonIdx;
            _mouseDown = _mouseDown | 1 << _loc3_;
            if(enabled)
            {
                setState("down");
                if((autoRepeat) && _repeatTimer == null)
                {
                    _autoRepeatEvent = new ButtonEvent(ButtonEvent.CLICK,true,false,_loc3_,_loc4_,false,true);
                    _repeatTimer = new Timer(repeatDelay,1);
                    _repeatTimer.addEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat,false,0,true);
                    _repeatTimer.start();
                }
                _loc5_ = new ButtonEvent(ButtonEvent.PRESS,true,false,_loc3_,_loc4_,false,false);
                dispatchEvent(_loc5_);
            }
        }
        
        override protected function handleMouseRelease(param1:MouseEvent) : void
        {
            var _loc4_:uint = 0;
            var _loc5_:ButtonEvent = null;
            _autoRepeatEvent = null;
            if(!enabled)
            {
                return;
            }
            var _loc2_:MouseEventEx = param1 as MouseEventEx;
            var _loc3_:uint = _loc2_ == null?0:_loc2_.mouseIdx;
            _loc4_ = _loc2_ == null?0:_loc2_.buttonIdx;
            _mouseDown = _mouseDown ^ 1 << _loc3_;
            if(_mouseDown == 0 && (_repeatTimer))
            {
                _repeatTimer.stop();
                _repeatTimer.reset();
                _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat);
                _repeatTimer.removeEventListener(TimerEvent.TIMER,handleRepeat);
                _repeatTimer = null;
            }
            setState("release");
            handleClick(_loc3_);
            if(!_isRepeating && !mouseHandlingLocked)
            {
                _loc5_ = new ButtonEvent(ButtonEvent.CLICK,true,false,_loc3_,_loc4_,false,false);
                dispatchEvent(_loc5_);
            }
            _isRepeating = false;
        }
        
        override protected function handleRelease(param1:uint = 0) : void
        {
            var _loc2_:ButtonEvent = null;
            if(!enabled)
            {
                return;
            }
            setState(focusIndicator == null?"release":"kb_release");
            if(_repeatTimer)
            {
                _repeatTimer.stop();
                _repeatTimer.reset();
                _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat);
                _repeatTimer.removeEventListener(TimerEvent.TIMER,handleRepeat);
                _repeatTimer = null;
            }
            handleClick(param1);
            _pressedByKeyboard = false;
            if(!_isRepeating && !keyboardHandlingLocked)
            {
                _loc2_ = new ButtonEvent(ButtonEvent.CLICK,true,false,param1,0,true,false);
                dispatchEvent(_loc2_);
            }
            _isRepeating = false;
        }
    }
}
