package net.wg.gui.lobby.header.headerButtonBar
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.interfaces.IHeaderButtonContentItem;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import scaleform.clik.utils.Padding;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.header.events.HeaderEvents;
    import net.wg.gui.lobby.header.LobbyHeader;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    public class HeaderButtonContentItem extends UIComponent implements IHeaderButtonContentItem
    {
        
        public function HeaderButtonContentItem()
        {
            this._screen = LobbyHeader.NARROW_SCREEN;
            this._minScreenPadding = new Padding(0,16,0,16);
            this._additionalScreenPadding = new Padding(0,10,0,10);
            super();
            this._readyToShow = false;
            this._hideDisplayObjList = new Vector.<DisplayObject>(0);
        }
        
        public var bounds:Sprite = null;
        
        private var _data:Object = null;
        
        private var _readyToShow:Boolean = false;
        
        private var _boundsWidth:Number = 0;
        
        private var _screen:String;
        
        private var _forceInvalidSize:Boolean = false;
        
        protected var _wideScreenPrc:Number = 0;
        
        protected var _maxScreenPrc:Number = 0;
        
        private var _availableWidth:Number = 0;
        
        protected var _hideDisplayObjList:Vector.<DisplayObject> = null;
        
        protected var _minScreenPadding:Padding;
        
        protected var _additionalScreenPadding:Padding;
        
        protected var TEXT_FIELD_MARGIN:Number = 4;
        
        protected var ARROW_MARGIN:Number = 10;
        
        protected var ICON_MARGIN:Number = 5;
        
        protected var useFontSize:Number = 13;
        
        protected var _narrowFontSize:Number = 13;
        
        protected var _widthFontSize:Number = 13;
        
        protected var _maxFontSize:Number = 13;
        
        protected var needUpdateFontSize:Boolean = true;
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.updateData();
                invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateSize();
            }
        }
        
        protected function updateSize() : void
        {
            if(!(this.bounds.width == this._boundsWidth) || (this._forceInvalidSize))
            {
                this._forceInvalidSize = false;
                this._boundsWidth = this.bounds.width;
                dispatchEvent(new HeaderEvents(HeaderEvents.HBC_SIZE_UPDATED,this.bounds.width,this.leftPadding,this.rightPadding));
            }
        }
        
        override protected function onDispose() : void
        {
            this._data = null;
            super.onDispose();
        }
        
        public function get data() : Object
        {
            return this._data;
        }
        
        public function set data(param1:Object) : void
        {
            this._data = param1;
            this.updateVisibility();
            this.updateFonts();
            invalidateData();
        }
        
        protected function updateData() : void
        {
            if(this.data)
            {
                this.readyToShow = true;
            }
        }
        
        protected function get leftPadding() : Number
        {
            return this._minScreenPadding.left + this._additionalScreenPadding.left * this._wideScreenPrc ^ 0;
        }
        
        protected function get rightPadding() : Number
        {
            return this._minScreenPadding.right + this._additionalScreenPadding.right * this._wideScreenPrc ^ 0;
        }
        
        public function get readyToShow() : Boolean
        {
            return this._readyToShow;
        }
        
        public function set readyToShow(param1:Boolean) : void
        {
            this._readyToShow = param1;
        }
        
        public function updateScreen(param1:String, param2:Number, param3:Number) : void
        {
            if(this._screen != param1)
            {
                this._screen = param1;
                this.updateVisibility();
                this.updateFonts();
                this._forceInvalidSize = true;
            }
            if(!(this._wideScreenPrc == param2) || !(this._maxScreenPrc == param3))
            {
                this._wideScreenPrc = param2;
                this._maxScreenPrc = param3;
                this._forceInvalidSize = true;
            }
            invalidateData();
        }
        
        public function setAvailableWidth(param1:Number) : void
        {
            this.availableWidth = param1 - this.leftPadding - this.rightPadding;
            if(this.availableWidth > 0)
            {
                this.updateData();
                this.updateSize();
            }
        }
        
        private function getFontSizeByScreen() : Number
        {
            var _loc1_:Number = this.useFontSize;
            switch(this.screen)
            {
                case LobbyHeader.NARROW_SCREEN:
                    _loc1_ = this._narrowFontSize;
                    break;
                case LobbyHeader.WIDE_SCREEN:
                    _loc1_ = this._widthFontSize;
                    break;
                case LobbyHeader.MAX_SCREEN:
                    _loc1_ = this._maxFontSize;
                    break;
            }
            return _loc1_;
        }
        
        private function updateVisibility() : Boolean
        {
            var _loc1_:* = this._screen == LobbyHeader.MAX_SCREEN;
            var _loc2_:Boolean = this._hideDisplayObjList.length > 0 && !(this._hideDisplayObjList[0].visible == _loc1_);
            var _loc3_:Number = 0;
            while(_loc3_ < this._hideDisplayObjList.length)
            {
                this._hideDisplayObjList[_loc3_].visible = _loc1_;
                _loc3_++;
            }
            return _loc2_;
        }
        
        private function updateFonts() : void
        {
            var _loc1_:Number = this.useFontSize;
            this.useFontSize = this.getFontSizeByScreen();
            this.needUpdateFontSize = !(_loc1_ == this.useFontSize);
        }
        
        protected function updateFontSize(param1:TextField, param2:Number) : void
        {
            var _loc3_:TextFormat = param1.getTextFormat();
            _loc3_.size = param2;
            param1.setTextFormat(_loc3_);
        }
        
        public function get screen() : String
        {
            return this._screen;
        }
        
        protected function isNeedUpdateFont() : Boolean
        {
            return this.needUpdateFontSize;
        }
        
        public function get availableWidth() : Number
        {
            return this._availableWidth;
        }
        
        public function set availableWidth(param1:Number) : void
        {
            this._availableWidth = param1;
        }
    }
}
