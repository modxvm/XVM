package net.wg.gui.lobby.settings.vo
{
    public class SettingsControlProp extends Object
    {
        
        public function SettingsControlProp(param1:* = null, param2:Array = null, param3:String = null, param4:Boolean = false, param5:Boolean = false, param6:String = null, param7:Boolean = false, param8:Boolean = false, param9:* = null, param10:Boolean = false, param11:* = null) {
            super();
            this.current = param1;
            this.options = param2?param2:[];
            this.type = param3;
            this.hasLabel = param4;
            this.hasValue = param5;
            this.isDependOn = param6;
            this.readOnly = param7;
            this.advanced = param8;
            this.prevVal = param9;
            this.changedVal = param1;
            this.isDataAsSelectedIndex = param10;
            this._default = param11;
        }
        
        private var _current = null;
        
        private var _options:Array = null;
        
        private var _type:String = null;
        
        private var _hasLabel:Boolean = false;
        
        private var _hasValue:Boolean = false;
        
        private var _isDependOn:String = null;
        
        private var _readOnly:Boolean = false;
        
        private var _advanced:Boolean = false;
        
        public var _default = null;
        
        private var _prevVal = null;
        
        private var _changedVal = null;
        
        private var _isDataAsSelectedIndex:Boolean = false;
        
        public function set current(param1:*) : void {
            this.changedVal = param1;
            if(this._current === param1)
            {
                return;
            }
            this._current = param1;
        }
        
        public function get current() : * {
            return this._current;
        }
        
        public function set options(param1:Array) : void {
            if(this._options == param1)
            {
                return;
            }
            this._options = param1;
        }
        
        public function get options() : Array {
            return this._options;
        }
        
        public function set type(param1:String) : void {
            if(this._type == param1)
            {
                return;
            }
            this._type = param1;
        }
        
        public function get type() : String {
            return this._type;
        }
        
        public function set hasLabel(param1:Boolean) : void {
            if(this._hasLabel == param1)
            {
                return;
            }
            this._hasLabel = param1;
        }
        
        public function get hasLabel() : Boolean {
            return this._hasLabel;
        }
        
        public function set hasValue(param1:Boolean) : void {
            if(this._hasValue == param1)
            {
                return;
            }
            this._hasValue = param1;
        }
        
        public function get hasValue() : Boolean {
            return this._hasValue;
        }
        
        public function set isDependOn(param1:String) : void {
            if(this._isDependOn == param1)
            {
                return;
            }
            this._isDependOn = param1;
        }
        
        public function get isDependOn() : String {
            return this._isDependOn;
        }
        
        public function set readOnly(param1:Boolean) : void {
            if(this._readOnly == param1)
            {
                return;
            }
            this._readOnly = param1;
        }
        
        public function get readOnly() : Boolean {
            return this._readOnly;
        }
        
        public function set advanced(param1:Boolean) : void {
            if(this._advanced == param1)
            {
                return;
            }
            this._advanced = param1;
        }
        
        public function get advanced() : Boolean {
            return this._advanced;
        }
        
        public function set prevVal(param1:*) : void {
            this._prevVal = param1;
        }
        
        public function get prevVal() : * {
            return this._prevVal;
        }
        
        public function set changedVal(param1:*) : void {
            if(this._changedVal === param1)
            {
                return;
            }
            this._changedVal = param1;
        }
        
        public function get changedVal() : * {
            return this._changedVal;
        }
        
        public function set isDataAsSelectedIndex(param1:Boolean) : void {
            if(this._isDataAsSelectedIndex == param1)
            {
                return;
            }
            this._isDataAsSelectedIndex = param1;
        }
        
        public function get isDataAsSelectedIndex() : Boolean {
            return this._isDataAsSelectedIndex;
        }
        
        public function clone() : SettingsControlProp {
            return new SettingsControlProp(this.current,this.options,this.type,this.hasLabel,this.hasValue,this.isDependOn,this.readOnly,this.advanced,this.prevVal,this.isDataAsSelectedIndex,this._default);
        }
        
        public function traceValues() : void {
        }
        
        public function clear() : void {
            if(this._options)
            {
                while(this._options.length > 0)
                {
                    this._options.pop();
                }
                this._options = null;
            }
        }
    }
}
