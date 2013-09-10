package net.wg.gui.lobby.settings.components 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.data.managers.*;
    import net.wg.data.managers.impl.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.tooltips.helpers.*;
    import net.wg.gui.lobby.settings.components.evnts.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    import scaleform.gfx.*;
    
    public class KeyInput extends net.wg.gui.components.controls.SoundButton
    {
        public function KeyInput()
        {
            super();
            return;
        }

        internal function AddEventListenerS():void
        {
            this.addEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.onKeyDown);
            App.stage.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleReleaseOutside, false, 0, true);
            this.addEventListener(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE, this.onKeyDown);
            return;
        }

        internal function ClearEventListenerS():void
        {
            if (this.hasEventListener(scaleform.clik.events.ButtonEvent.PRESS)) 
                this.removeEventListener(scaleform.clik.events.ButtonEvent.PRESS, this.onKeyDown);
            if (this.hasEventListener(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE)) 
                this.removeEventListener(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE, this.onKeyDown);
            if (App.stage.hasEventListener(flash.events.MouseEvent.MOUSE_DOWN)) 
                App.stage.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleReleaseOutside, false);
            return;
        }

        internal function __processCode(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            if (arg1 == flash.ui.Keyboard.ESCAPE) 
            {
                this.__inputClose();
                return;
            }
            var loc1:*=App.utils.commons.keyToString(arg1);
            if (this.__isInKeySet(loc1.keyCommand)) 
            {
                this.key = arg1;
                dispatchEvent(new net.wg.gui.lobby.settings.components.evnts.KeyInputEvents(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.CHANGE, this.key));
                this.__inputClose();
            }
            else 
            {
                loc2 = new flash.geom.Point(x + width, y - height - 7);
                loc2 = parent.localToGlobal(loc2);
                loc3 = new net.wg.data.managers.impl.TooltipProps(net.wg.data.constants.Tooltips.TYPE_WARNING, loc2.x, loc2.y, 0, 0, 1500);
                loc4 = App.utils.locale.makeString(TOOLTIPS.SETTING_WINDOW_CONTROLS_KEY_INPUT_WARNING, {"keyName":loc1.keyCommand});
                loc5 = "<font color=\"" + net.wg.gui.components.tooltips.helpers.Utils.instance.COLOR_ALERT + "\">" + loc4 + "</font>";
                App.toolTipMgr.show(loc5, loc3);
                this.__inputClose();
            }
            return;
        }

        internal function __isInKeySet(arg1:String):Boolean
        {
            return this._keys.indexOf(arg1, 0) > -1;
        }

        internal function __inputClose():void
        {
            selected = false;
            invalidate();
            return;
        }

        internal function onButtonSelect(arg1:flash.events.Event):void
        {
            if (this.selected) 
                this.AddEventListenerS();
            else 
                this.ClearEventListenerS();
            return;
        }

        internal function onKeyDown(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.__processCode(arg1.isKeyboard ? arg1.controllerIdx : arg1.buttonIdx);
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc1:*=null;
            var loc2:*=0;
            if (selected) 
            {
                if (arg1.isDefaultPrevented()) 
                    return;
                loc1 = arg1.details;
                loc2 = loc1.controllerIndex;
                if (loc1.value == scaleform.clik.constants.InputValue.KEY_DOWN && selected) 
                    this.__processCode(loc1.code);
                return;
            }
            super.handleInput(arg1);
            return;
        }

        public override function toString():String
        {
            return "[WG KeyInput " + name + "]";
        }

        public override function dispose():void
        {
            this.ClearEventListenerS();
            super.dispose();
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (arg1 == enabled) 
                return;
            buttonMode = arg1;
            super.enabled = arg1;
            return;
        }

        public function get keyCode():Number
        {
            return this._keyCode;
        }

        public function get keyString():String
        {
            return this._keyString;
        }

        public function get keyDefault():Number
        {
            return this._keyDefault;
        }

        public function set keyDefault(arg1:Number):void
        {
            this._keyDefault = arg1;
            return;
        }

        public function get key():Number
        {
            return this._keyCode;
        }

        public function set key(arg1:Number):void
        {
            if (this._keyCode == arg1) 
                return;
            if (arg1 == net.wg.data.constants.KeysMap.KEY_NONE) 
                dispatchEvent(new net.wg.gui.lobby.settings.components.evnts.KeyInputEvents(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.CHANGE, net.wg.data.constants.KeysMap.KEY_NONE));
            this._keyCode = arg1;
            this._keyString = App.utils.commons.keyToString(this._keyCode).keyName;
            invalidateData();
            return;
        }

        public function get keys():Array
        {
            return this._keys;
        }

        public function set keys(arg1:Array):void
        {
            this._keys = arg1;
            this.__keysToUpperCase();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            stage.doubleClickEnabled = true;
            toggle = true;
            this.addEventListener(flash.events.Event.SELECT, this.onButtonSelect);
            buttonMode = enabled;
            mouseEnabled = true;
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                textField.text = this._keyString || "";
                this.alert.visible = this._keyCode == net.wg.data.constants.KeysMap.KEY_NONE && !selected;
            }
            super.draw();
            return;
        }

        protected override function handleMousePress(arg1:flash.events.MouseEvent):void
        {
            var loc4:*=null;
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.mouseIdx : 0;
            var loc3:*=loc1 != null ? loc1.buttonIdx : 0;
            _mouseDown = _mouseDown | 1 << loc2;
            if (enabled) 
            {
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
            else 
                dispatchEvent(new net.wg.gui.lobby.settings.components.evnts.KeyInputEvents(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.DISABLE_PRESS, NaN, true, false));
            return;
        }

        protected override function handleReleaseOutside(arg1:flash.events.MouseEvent):void
        {
            _autoRepeatEvent = null;
            if (contains(arg1.target as flash.display.DisplayObject)) 
                return;
            var loc1:*=arg1 as scaleform.gfx.MouseEventEx;
            var loc2:*=loc1 != null ? loc1.mouseIdx : 0;
            var loc3:*=loc1 != null ? loc1.buttonIdx : 0;
            stage.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.handleReleaseOutside, false);
            _mouseDown = _mouseDown ^ 1 << loc2;
            dispatchEvent(new scaleform.clik.events.ButtonEvent(scaleform.clik.events.ButtonEvent.RELEASE_OUTSIDE, true, false, loc2, loc3, false, false));
            if (!enabled) 
                return;
            if (lockDragStateChange) 
                if (_focused || _displayFocus) 
                    setState(focusIndicator != null ? "kb_release" : "release");
                else 
                    setState("kb_release");
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            if (!enabled) 
                dispatchEvent(new net.wg.gui.lobby.settings.components.evnts.KeyInputEvents(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.DISABLE_OVER, NaN, true, false));
            super.handleMouseRollOver(arg1);
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            if (!enabled) 
                dispatchEvent(new net.wg.gui.lobby.settings.components.evnts.KeyInputEvents(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.DISABLE_OUT, NaN, true, false));
            super.handleMouseRollOut(arg1);
            return;
        }

        internal function __keysToUpperCase():void
        {
            var loc1:*=0;
            while (loc1 < this._keys.length) 
            {
                this._keys[loc1] = String(this._keys[loc1]).toUpperCase();
                ++loc1;
            }
            return;
        }

        public var alert:scaleform.clik.core.UIComponent;

        public var bg:flash.display.MovieClip;

        public var border:flash.display.MovieClip;

        internal var _keys:Array;

        internal var _keyCode:Number;

        internal var _keyString:String;

        internal var _keyDefault:Number;

        internal var errorMsg:String="";
    }
}
