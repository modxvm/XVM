package net.wg.gui.lobby.header.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.lobby.header.headerButtonBar.HeaderButton;
    
    public class HeaderButtonVo extends DAAPIDataClass
    {
        
        public function HeaderButtonVo(param1:Object)
        {
            super(param1);
        }
        
        private var _linkage:String = "";
        
        private var _data:Object = null;
        
        private var _id:String = "";
        
        private var _direction:String = "";
        
        private var _align:String = "";
        
        private var _isUseFreeSize:Boolean = false;
        
        private var _tooltip:String = "";
        
        private var _headerButton:HeaderButton = null;
        
        private var _enabled:Boolean = false;
        
        public var helpText:String = "";
        
        public var helpDirection:String = "";
        
        public function set linkage(param1:String) : void
        {
            this._linkage = param1;
        }
        
        public function get linkage() : String
        {
            return this._linkage;
        }
        
        public function set data(param1:Object) : void
        {
            this._data = param1;
        }
        
        public function get data() : Object
        {
            return this._data;
        }
        
        public function set id(param1:String) : void
        {
            this._id = param1;
        }
        
        public function get id() : String
        {
            return this._id;
        }
        
        public function set direction(param1:String) : void
        {
            this._direction = param1;
        }
        
        public function get direction() : String
        {
            return this._direction;
        }
        
        public function set align(param1:String) : void
        {
            this._align = param1;
        }
        
        public function get align() : String
        {
            return this._align;
        }
        
        public function set tooltip(param1:String) : void
        {
            this._tooltip = param1;
        }
        
        public function get tooltip() : String
        {
            return this._tooltip;
        }
        
        public function set headerButton(param1:HeaderButton) : void
        {
            this._headerButton = param1;
        }
        
        public function get headerButton() : HeaderButton
        {
            return this._headerButton;
        }
        
        public function get enabled() : Boolean
        {
            return this._enabled;
        }
        
        public function set enabled(param1:Boolean) : void
        {
            this._enabled = param1;
        }
        
        public function get isUseFreeSize() : Boolean
        {
            return this._isUseFreeSize;
        }
        
        public function set isUseFreeSize(param1:Boolean) : void
        {
            this._isUseFreeSize = param1;
        }
    }
}
