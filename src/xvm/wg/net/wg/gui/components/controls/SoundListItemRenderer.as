package net.wg.gui.components.controls 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    import scaleform.gfx.*;
    
    public class SoundListItemRenderer extends scaleform.clik.controls.ListItemRenderer implements net.wg.infrastructure.interfaces.entity.ISoundable
    {
        public function SoundListItemRenderer()
        {
            super();
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            super.enabled = arg1;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            buttonMode = true;
            if (App.soundMgr) 
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

        public function set useRightButton(arg1:Boolean):void
        {
            if (this._useRightButton == arg1) 
                return;
            this._useRightButton = arg1;
            return;
        }

        public function get useRightButton():Boolean
        {
            return this._useRightButton;
        }

        protected override function handleMousePress(arg1:flash.events.MouseEvent):void
        {
            if (this._useRightButton) 
                this.handleMousePressEx(arg1);
            else 
                super.handleMousePress(arg1);
            return;
        }

        protected override function handleMouseRelease(arg1:flash.events.MouseEvent):void
        {
            if (this._useRightButton) 
                this.handleMouseReleaseEx(arg1);
            else 
                super.handleMouseRelease(arg1);
            return;
        }

        protected override function handleReleaseOutside(arg1:flash.events.MouseEvent):void
        {
            if (this._useRightButton) 
                this.handleReleaseOutsideEx(arg1);
            else 
                super.handleReleaseOutside(arg1);
            return;
        }

        protected function handleMousePressEx(arg1:flash.events.MouseEvent):void
        {
            var loc4:*=null;
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.mouseIdx : 0;
            var loc3:*=loc1 != null ? loc1.buttonIdx : 0;
            _mouseDown = _mouseDown | 1 << loc2;
            if (enabled) 
            {
                if (loc3 == 0) 
                    setState("down");
                if (autoRepeat && _repeatTimer == null) 
                {
                    _autoRepeatEvent = new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.CLICK, true, false, loc2, loc3, false, true);
                    _repeatTimer = new flash.utils.Timer(repeatDelay, 1);
                    _repeatTimer.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, beginRepeat, false, 0, true);
                    _repeatTimer.start();
                }
                loc4 = new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.PRESS, true, false, loc2, loc3, false, false);
                dispatchEvent(loc4);
            }
            return;
        }

        protected function handleMouseReleaseEx(arg1:flash.events.MouseEvent):void
        {
            var loc3:*=0;
            var loc4:*=null;
            _autoRepeatEvent = null;
            if (!enabled) 
                return;
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.mouseIdx : 0;
            loc3 = loc1 != null ? loc1.buttonIdx : 0;
            _mouseDown = _mouseDown ^ 1 << loc2;
            if (_mouseDown == 0 && _repeatTimer) 
            {
                _repeatTimer.stop();
                _repeatTimer.reset();
                _repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, beginRepeat);
                _repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER, handleRepeat);
                _repeatTimer = null;
            }
            if (loc3 == 0) 
            {
                setState("release");
                handleClick(loc2);
            }
            if (!_isRepeating) 
            {
                loc4 = new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.CLICK, true, false, loc2, loc3, false, false);
                dispatchEvent(loc4);
            }
            _isRepeating = false;
            return;
        }

        protected function handleReleaseOutsideEx(arg1:flash.events.MouseEvent):void
        {
            var loc3:*=0;
            _autoRepeatEvent = null;
            if (contains(arg1.target as flash.display.DisplayObject)) 
                return;
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.mouseIdx : 0;
            loc3 = loc1 != null ? loc1.buttonIdx : 0;
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.handleReleaseOutside, false);
            _mouseDown = _mouseDown ^ 1 << loc2;
            dispatchEvent(new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE));
            if (!enabled) 
                return;
            if (lockDragStateChange && loc3 == 0) 
                if (_focused || _displayFocus) 
                    setState(focusIndicator != null ? "kb_release" : "release");
                else 
                    setState("kb_release");
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            return;
        }

        public var soundType:String="itemRenderer";

        public var soundId:String="";

        internal var _useRightButton:Boolean=false;
    }
}
