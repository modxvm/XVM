package net.wg.gui.components.controls
{
    import net.wg.gui.interfaces.IButtonIconLoader;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.Loader;
    import scaleform.clik.core.UIComponent;
    import flash.display.DisplayObject;
    import flash.net.URLRequest;
    import scaleform.clik.constants.InvalidationType;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import net.wg.infrastructure.events.LibraryLoaderEvent;
    import net.wg.data.constants.SoundTypes;
    
    public class ButtonIconLoader extends SoundButtonEx implements IButtonIconLoader
    {
        
        public function ButtonIconLoader()
        {
            super();
            soundType = SoundTypes.ICON_BTN;
            this.container.visible = false;
        }
        
        public var container:Sprite;
        
        public var states:MovieClip;
        
        protected var _iconOffsetTop:Number = 0;
        
        protected var _iconOffsetLeft:Number = 0;
        
        protected var loader:Loader;
        
        protected var _iconSource:String;
        
        private var ICON_SOURCE_INVALID:String = "iconSrcInv";
        
        private var LAYOUT_INVALID:String = "layoutInv";
        
        private var ICON_LOADED_INVALID:String = "iconLoadInv";
        
        private var iconWasLoaded:Boolean = false;
        
        public var newScaleX:Number = 1;
        
        public var newScaleY:Number = 1;
        
        override protected function initialize() : void
        {
            super.initialize();
            if(this.states)
            {
                _labelHash = UIComponent.generateLabelHash(this.states);
            }
        }
        
        private function initItems() : void
        {
            var _loc3_:DisplayObject = null;
            this.newScaleX = this.scaleX;
            this.newScaleY = this.scaleY;
            var _loc1_:Number = this.numChildren;
            this.setActualScale(1,1);
            var _loc2_:Number = 0;
            while(_loc2_ < _loc1_)
            {
                _loc3_ = this.getChildAt(_loc2_);
                if(_loc3_ != this.container)
                {
                    _loc3_.scaleX = this.newScaleX;
                    _loc3_.scaleY = this.newScaleY;
                }
                _loc2_++;
            }
        }
        
        override protected function onDispose() : void
        {
            if(this.loader)
            {
                this.removeIconListeners(this.loader.contentLoaderInfo);
                this.loader.unloadAndStop();
                this.loader.unload();
                this.container.removeChild(this.loader);
                this.loader = null;
            }
            super.onDispose();
        }
        
        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
        }
        
        public function get iconSource() : String
        {
            return this._iconSource;
        }
        
        public function set iconSource(param1:String) : void
        {
            if(this._iconSource != param1)
            {
                this._iconSource = param1;
                invalidate(this.ICON_SOURCE_INVALID);
            }
        }
        
        public function get iconOffsetTop() : Number
        {
            return this._iconOffsetTop;
        }
        
        public function set iconOffsetTop(param1:Number) : void
        {
            this._iconOffsetTop = param1;
            invalidate(this.LAYOUT_INVALID);
        }
        
        public function get iconOffsetLeft() : Number
        {
            return this._iconOffsetLeft;
        }
        
        public function set iconOffsetLeft(param1:Number) : void
        {
            this._iconOffsetLeft = param1;
            invalidate(this.LAYOUT_INVALID);
        }
        
        override public function gotoAndPlay(param1:Object, param2:String = null) : void
        {
            if(this.states)
            {
                this.states.gotoAndPlay(param1,param2);
            }
            else
            {
                super.gotoAndPlay(param1,param2);
            }
        }
        
        override public function gotoAndStop(param1:Object, param2:String = null) : void
        {
            if(this.states)
            {
                this.states.gotoAndStop(param1,param2);
            }
            else
            {
                super.gotoAndStop(param1,param2);
            }
        }
        
        override protected function configUI() : void
        {
            if(this.states)
            {
                constraintsDisabled = true;
                preventAutosizing = true;
                this.initItems();
            }
            super.configUI();
        }
        
        override protected function draw() : void
        {
            var _loc1_:URLRequest = null;
            super.draw();
            if(isInvalid(this.ICON_SOURCE_INVALID))
            {
                if(this.loader)
                {
                    this.loader.unload();
                    this.removeIconListeners(this.loader.contentLoaderInfo);
                    this.container.removeChild(this.loader);
                    this.loader = null;
                }
                if(!(this._iconSource == null) && !(this._iconSource == ""))
                {
                    _loc1_ = new URLRequest(this._iconSource);
                    this.loader = new Loader();
                    this.addIconListeners(this.loader.contentLoaderInfo);
                    this.iconWasLoaded = false;
                    this.container.visible = false;
                    this.loader.load(_loc1_);
                    this.container.addChild(this.loader);
                }
            }
            if((isInvalid(InvalidationType.SIZE)) || (isInvalid(this.LAYOUT_INVALID)))
            {
                this.configIcon();
            }
            if((isInvalid(this.ICON_LOADED_INVALID)) && (this.iconWasLoaded))
            {
                this.container.visible = true;
            }
        }
        
        protected function addIconListeners(param1:LoaderInfo) : void
        {
            param1.addEventListener(Event.COMPLETE,this.iconLoadingCompleteHandler);
            param1.addEventListener(IOErrorEvent.IO_ERROR,this.iconLoadingIOErrorHandler);
        }
        
        protected function configIcon() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            var _loc3_:* = NaN;
            var _loc4_:* = NaN;
            if((this.container) && (this.loader))
            {
                _loc1_ = 0;
                _loc2_ = 0;
                _loc3_ = 1;
                _loc4_ = 1;
                if(!this.states)
                {
                    _loc3_ = 1 / this.scaleX;
                    _loc4_ = 1 / this.scaleY;
                }
                _loc1_ = Math.floor(((this.width - this.loader.width) / 2 + this._iconOffsetLeft) * _loc3_);
                _loc2_ = Math.floor(((this.height - this.loader.height) / 2 + this._iconOffsetTop) * _loc4_);
                this.container.x = _loc1_;
                this.container.y = _loc2_;
                this.container.scaleX = _loc3_;
                this.container.scaleY = _loc4_;
            }
        }
        
        override public function get width() : Number
        {
            return this.states?super.width * this.newScaleX:super.width;
        }
        
        override public function get height() : Number
        {
            return this.states?super.height * this.newScaleY:super.height;
        }
        
        private function removeIconListeners(param1:LoaderInfo) : void
        {
            param1.removeEventListener(Event.COMPLETE,this.iconLoadingCompleteHandler);
            param1.removeEventListener(IOErrorEvent.IO_ERROR,this.iconLoadingIOErrorHandler);
        }
        
        protected function iconLoadingIOErrorHandler(param1:IOErrorEvent) : void
        {
            dispatchEvent(this.getNewLoadingEvent(LibraryLoaderEvent.ICON_LOADING_FAILED,loaderInfo.loader,loaderInfo.url));
            this.removeIconListeners(LoaderInfo(param1.target));
        }
        
        protected function iconLoadingCompleteHandler(param1:Event) : void
        {
            var _loc2_:LoaderInfo = LoaderInfo(param1.target);
            this.removeIconListeners(_loc2_);
            dispatchEvent(this.getNewLoadingEvent(LibraryLoaderEvent.ICON_LOADED,_loc2_.loader,_loc2_.url));
            this.iconWasLoaded = true;
            invalidate(this.LAYOUT_INVALID,this.ICON_LOADED_INVALID);
        }
        
        private function getNewLoadingEvent(param1:String, param2:Loader, param3:String) : LibraryLoaderEvent
        {
            return new LibraryLoaderEvent(param1,param2,param3,true,true);
        }
    }
}
