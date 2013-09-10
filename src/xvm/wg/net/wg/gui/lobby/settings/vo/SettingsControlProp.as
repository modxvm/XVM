package net.wg.gui.lobby.settings.vo 
{
    public class SettingsControlProp extends Object
    {
        public function SettingsControlProp(arg1:*=null, arg2:Array=null, arg3:String=null, arg4:Boolean=false, arg5:Boolean=false, arg6:String=null, arg7:Boolean=false, arg8:Boolean=false, arg9:*=null, arg10:Boolean=false, arg11:*=null)
        {
            super();
            this.current = arg1;
            this.options = arg2 ? arg2 : [];
            this.type = arg3;
            this.hasLabel = arg4;
            this.hasValue = arg5;
            this.isDependOn = arg6;
            this.readOnly = arg7;
            this.advanced = arg8;
            this.lastVal = arg9;
            this.isDataAsSelectedIndex = arg10;
            this._default = arg11;
            return;
        }

        public function set isDependOn(arg1:String):void
        {
            if (this._isDependOn == arg1) 
            {
                return;
            }
            this._isDependOn = arg1;
            return;
        }

        public function get isDependOn():String
        {
            return this._isDependOn;
        }

        public function set readOnly(arg1:Boolean):void
        {
            if (this._readOnly == arg1) 
            {
                return;
            }
            this._readOnly = arg1;
            return;
        }

        public function get readOnly():Boolean
        {
            return this._readOnly;
        }

        public function set advanced(arg1:Boolean):void
        {
            if (this._advanced == arg1) 
            {
                return;
            }
            this._advanced = arg1;
            return;
        }

        public function get advanced():Boolean
        {
            return this._advanced;
        }

        public function set lastVal(arg1:*):void
        {
            if (this._lastVal == arg1) 
            {
                return;
            }
            this._lastVal = arg1;
            return;
        }

        public function get lastVal():*
        {
            return this._lastVal;
        }

        public function set isDataAsSelectedIndex(arg1:Boolean):void
        {
            if (this._isDataAsSelectedIndex == arg1) 
            {
                return;
            }
            this._isDataAsSelectedIndex = arg1;
            return;
        }

        public function get isDataAsSelectedIndex():Boolean
        {
            return this._isDataAsSelectedIndex;
        }

        public function clone():net.wg.gui.lobby.settings.vo.SettingsControlProp
        {
            return new net.wg.gui.lobby.settings.vo.SettingsControlProp(this.current, this.options, this.type, this.hasLabel, this.hasValue, this.isDependOn, this.readOnly, this.advanced, this.lastVal, this.isDataAsSelectedIndex, this._default);
        }

        public function set current(arg1:*):void
        {
            if (this._current === arg1) 
            {
                return;
            }
            this._current = arg1;
            return;
        }

        public function get current():*
        {
            return this._current;
        }

        public function set options(arg1:Array):void
        {
            if (this._options == arg1) 
            {
                return;
            }
            this._options = arg1;
            return;
        }

        public function get options():Array
        {
            return this._options;
        }

        public function set type(arg1:String):void
        {
            if (this._type == arg1) 
            {
                return;
            }
            this._type = arg1;
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set hasLabel(arg1:Boolean):void
        {
            if (this._hasLabel == arg1) 
            {
                return;
            }
            this._hasLabel = arg1;
            return;
        }

        public function get hasLabel():Boolean
        {
            return this._hasLabel;
        }

        public function set hasValue(arg1:Boolean):void
        {
            if (this._hasValue == arg1) 
            {
                return;
            }
            this._hasValue = arg1;
            return;
        }

        public function get hasValue():Boolean
        {
            return this._hasValue;
        }

        internal var _current:*=null;

        internal var _options:Array=null;

        internal var _type:String=null;

        internal var _hasLabel:Boolean=false;

        internal var _hasValue:Boolean=false;

        internal var _isDependOn:String=null;

        internal var _readOnly:Boolean=false;

        internal var _advanced:Boolean=false;

        public var _default:*=null;

        internal var _lastVal:*=null;

        internal var _isDataAsSelectedIndex:Boolean=false;
    }
}
