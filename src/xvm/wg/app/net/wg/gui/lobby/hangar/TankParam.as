package net.wg.gui.lobby.hangar 
{
    import flash.events.*;
    import flash.text.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class TankParam extends scaleform.clik.controls.ListItemRenderer
    {
        public function TankParam()
        {
            super();
            this._styles = new Styles();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            _stateMap = {"normal":["normal"], "disabled":["disabled"]};
            var loc1:*=new flash.text.StyleSheet();
            loc1.setStyle("h1", {"color":"#B4A983"});
            loc1.setStyle("p", {"color":"#9F9260"});
            var loc2:*=new flash.text.StyleSheet();
            loc2.setStyle("h1", {"color":"#E1DDCE"});
            loc2.setStyle("p", {"color":"#B4A983"});
            var loc3:*=new flash.text.StyleSheet();
            loc3.setStyle("h1", {"color":"#666666"});
            loc3.setStyle("p", {"color":"#666666"});
            this._styles.normal = loc1;
            this._styles.selected = loc2;
            this._styles.disabled = loc3;
            this.tfField.styleSheet = this._styles.normal;
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            if (this._text == arg1) 
            {
                return;
            }
            this._text = arg1;
            invalidate(INVALIDATE_TEXT);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATE_TEXT)) 
            {
                if (this.tfField != null) 
                {
                    this.tfField.htmlText = this._text;
                }
            }
            if (isInvalid(INVALIDATE_VALUE)) 
            {
                if (this.paramField != null) 
                {
                    this.paramField.text = this._value;
                }
            }
            if (this.tfField != null) 
            {
                if (super.enabled) 
                {
                    if (_selected) 
                    {
                        this.tfField.styleSheet = this._styles.selected;
                    }
                    else 
                    {
                        this.tfField.styleSheet = this._styles.normal;
                    }
                }
                else 
                {
                    this.tfField.styleSheet = this._styles.disabled;
                }
                this.tfField.htmlText = this._text;
            }
            return;
        }

        public override function setData(arg1:Object):void
        {
            var loc1:*=null;
            super.setData(arg1);
            if (arg1) 
            {
                loc1 = net.wg.gui.lobby.hangar.ParamsVO(arg1);
                this.param = loc1.param;
                this.text = MENU.tank_params(loc1.text);
                this.selected = loc1.selected;
                invalidate();
            }
            return;
        }

        public function get param():String
        {
            return this._value;
        }

        public function set param(arg1:String):void
        {
            if (this._value == arg1) 
            {
                return;
            }
            this._value = arg1;
            invalidate(INVALIDATE_VALUE);
            return;
        }

        public override function setListData(arg1:scaleform.clik.data.ListData):void
        {
            index = arg1.index;
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
            validateNow();
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            var loc1:*=null;
            super.enabled = arg1;
            mouseChildren = false;
            if (super.enabled) 
            {
                loc1 = "normal";
            }
            else 
            {
                loc1 = "disabled";
            }
            setState(loc1);
            return;
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
            this._styles.dispose();
            if (_data) 
            {
                net.wg.gui.lobby.hangar.ParamsVO(_data).dispose();
                _data = null;
            }
            this._text = null;
            this._value = null;
            this._styles = null;
            this.paramField = null;
            this.tfField = null;
            super.dispose();
            return;
        }

        internal static const INVALIDATE_TEXT:String="inv_text";

        internal static const INVALIDATE_VALUE:String="inv_value";

        internal var _text:String="";

        internal var _value:String="";

        internal var _styles:Styles=null;

        public var paramField:flash.text.TextField;

        public var tfField:flash.text.TextField;
    }
}

import flash.text.*;
import net.wg.infrastructure.interfaces.entity.*;


class Styles extends Object implements net.wg.infrastructure.interfaces.entity.IDisposable
{
    public function Styles()
    {
        super();
        return;
    }

    public function get normal():flash.text.StyleSheet
    {
        return this._normal;
    }

    public function set normal(arg1:flash.text.StyleSheet):void
    {
        this._normal = arg1;
        return;
    }

    public function get selected():flash.text.StyleSheet
    {
        return this._selected;
    }

    public function set selected(arg1:flash.text.StyleSheet):void
    {
        this._selected = arg1;
        return;
    }

    public function get disabled():flash.text.StyleSheet
    {
        return this._disabled;
    }

    public function set disabled(arg1:flash.text.StyleSheet):void
    {
        this._disabled = arg1;
        return;
    }

    public function dispose():void
    {
        this._normal = null;
        this._selected = null;
        this._disabled = null;
        return;
    }

    internal var _normal:flash.text.StyleSheet=null;

    internal var _selected:flash.text.StyleSheet=null;

    internal var _disabled:flash.text.StyleSheet=null;
}