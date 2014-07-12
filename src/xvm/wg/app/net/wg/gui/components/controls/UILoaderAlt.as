package net.wg.gui.components.controls
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Loader;
    import flash.events.Event;
    import scaleform.clik.events.ComponentEvent;
    import net.wg.gui.events.UILoaderEvent;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.events.IOErrorEvent;
    
    public class UILoaderAlt extends Sprite implements IDisposable
    {
        
        public function UILoaderAlt() {
            super();
            this._width = width;
            this._height = height;
            this.loader = new Loader();
            addChild(this.loader);
            this.background.visible = false;
            scaleX = scaleY = 1;
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadComplete);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this.loader.contentLoaderInfo.addEventListener(Event.UNLOAD,this.onUnloadComplete);
            this.hideLoader = true;
        }
        
        private static var CONTENT_TYPE_SWF:String = "application/x-shockwave-flash";
        
        public var background:Sprite;
        
        public var hideLoader:Boolean = false;
        
        public var enableInitCallback:Boolean = false;
        
        private var _autoSize:Boolean = true;
        
        private var _source:String;
        
        private var _loadFailed:Boolean;
        
        private var _previousContentUnloaded:Boolean;
        
        private var _loadInProgress:Boolean;
        
        private var _sourceAlt:String;
        
        private var _maintainAspectRatio:Boolean = true;
        
        private var _unloadInProgress:Boolean;
        
        private var _sizeRetries:int;
        
        private var _width:Number;
        
        private var _height:Number;
        
        private var loader:Loader;
        
        private var _invalid:Boolean = false;
        
        public function setSourceSize(param1:Number, param2:Number) : void {
            this.loader.width = param1;
            this.loader.height = param2;
            this.loader.scaleX = this.loader.scaleY = Math.min(this._height / param2,this._width / param1);
        }
        
        public final function dispose() : void {
            this.onDispose();
        }
        
        protected function onDispose() : void {
            if(this.loader)
            {
                this.removeLoaderListener();
                this.unload();
                removeChild(this.loader);
                this.loader = null;
            }
            if(this.background)
            {
                removeChild(this.background);
                this.background = null;
            }
            removeEventListener(Event.ADDED_TO_STAGE,this.handleStageChange);
            removeEventListener(Event.ENTER_FRAME,this.handleEnterFrameValidation);
            removeEventListener(Event.RENDER,this.updateSize);
        }
        
        override public function get visible() : Boolean {
            return super.visible;
        }
        
        override public function set visible(param1:Boolean) : void {
            super.visible = param1;
            dispatchEvent(new ComponentEvent(param1?ComponentEvent.SHOW:ComponentEvent.HIDE));
        }
        
        public function get autoSize() : Boolean {
            return this._autoSize;
        }
        
        public function set autoSize(param1:Boolean) : void {
            this._autoSize = param1;
        }
        
        public function get source() : String {
            return this._source;
        }
        
        public function set source(param1:String) : void {
            this._loadFailed = false;
            if(!param1 || param1 == this._source)
            {
                return;
            }
            this.startLoad(param1);
        }
        
        public function get sourceAlt() : String {
            return this._sourceAlt;
        }
        
        public function set sourceAlt(param1:String) : void {
            if(!param1 || this._sourceAlt == param1)
            {
                return;
            }
            this._sourceAlt = param1;
            if(this._loadFailed)
            {
                this.startLoad(this._sourceAlt);
            }
        }
        
        public function get originalWidth() : Number {
            return this._width;
        }
        
        public function get originalHeight() : Number {
            return this._height;
        }
        
        public function get maintainAspectRatio() : Boolean {
            return this._maintainAspectRatio;
        }
        
        public function set maintainAspectRatio(param1:Boolean) : void {
            this._maintainAspectRatio = param1;
        }
        
        public function unload() : void {
            if(this._loadInProgress)
            {
                this.loader.close();
            }
            this._unloadInProgress = true;
            if(this.loader.contentLoaderInfo.contentType == CONTENT_TYPE_SWF)
            {
                this.loader.unloadAndStop(true);
            }
            else
            {
                this.loader.unload();
            }
            this._source = null;
            this._sizeRetries = 0;
        }
        
        public function invalidate() : void {
            if(!this._invalid)
            {
                this._invalid = true;
                if(stage == null)
                {
                    addEventListener(Event.ADDED_TO_STAGE,this.handleStageChange,false,0,true);
                }
                else
                {
                    addEventListener(Event.ENTER_FRAME,this.handleEnterFrameValidation,false,0,true);
                    addEventListener(Event.RENDER,this.updateSize,false,0,true);
                    stage.invalidate();
                }
            }
            else if(stage != null)
            {
                stage.invalidate();
            }
            
        }
        
        protected function handleStageChange(param1:Event) : void {
            if(param1.type == Event.ADDED_TO_STAGE)
            {
                removeEventListener(Event.ADDED_TO_STAGE,this.handleStageChange,false);
                addEventListener(Event.RENDER,this.updateSize,false,0,true);
                if(stage != null)
                {
                    stage.invalidate();
                }
            }
        }
        
        protected function handleEnterFrameValidation(param1:Event) : void {
            this.updateSize();
        }
        
        private function toggleVisible(param1:Boolean) : void {
            if(this.hideLoader)
            {
                this.loader.visible = param1;
            }
        }
        
        public function updateSize(param1:Event = null) : void {
            var _loc2_:* = NaN;
            removeEventListener(Event.ADDED_TO_STAGE,this.handleStageChange);
            removeEventListener(Event.ENTER_FRAME,this.handleEnterFrameValidation);
            removeEventListener(Event.RENDER,this.updateSize);
            if(this._autoSize)
            {
                if(this.loader.width <= 0)
                {
                    if(this._sizeRetries < 10)
                    {
                        this._sizeRetries++;
                        this.invalidate();
                    }
                    else
                    {
                        DebugUtils.LOG_DEBUG("Warning: " + this + "cannot be autoSized because content width is <= 0!");
                    }
                    return;
                }
                if(this._maintainAspectRatio)
                {
                    _loc2_ = Math.min(this._height / this.loader.height,this._width / this.loader.width);
                    this.loader.width = Math.round(this.loader.width * _loc2_);
                    this.loader.height = Math.round(this.loader.height * _loc2_);
                }
                else
                {
                    this.loader.width = Math.round(this.loader.width * this._width / this.loader.width);
                    this.loader.height = Math.round(this.loader.height * this._height / this.loader.height);
                }
            }
            else
            {
                width = this.loader.width;
                height = this.loader.height;
                this.loader.scaleX = 1 / scaleX;
                this.loader.scaleY = 1 / scaleY;
            }
            this.toggleVisible(true);
            this.hideLoader = false;
            dispatchEvent(new UILoaderEvent(UILoaderEvent.COMPLETE));
            this._invalid = false;
        }
        
        private function startLoad(param1:String) : void {
            this._source = param1;
            if(!this._previousContentUnloaded)
            {
                this.loader.unload();
            }
            this.toggleVisible(false);
            this._loadInProgress = true;
            this._previousContentUnloaded = false;
            var _loc2_:URLRequest = new URLRequest(param1);
            var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
            this.loader.load(_loc2_,_loc3_);
        }
        
        private function onLoadComplete(param1:Event) : void {
            this._loadFailed = false;
            this._loadInProgress = false;
            this.updateSize();
        }
        
        private function onIOError(param1:IOErrorEvent) : void {
            if(!this._loadFailed && (this._sourceAlt))
            {
                this._loadFailed = true;
                this.startLoad(this._sourceAlt);
            }
            else
            {
                dispatchEvent(new UILoaderEvent(UILoaderEvent.IOERROR));
                this._loadInProgress = false;
            }
        }
        
        public function startLoadAlt() : void {
            this.startLoad(this._sourceAlt);
        }
        
        private function onUnloadComplete(param1:Event) : void {
            this._previousContentUnloaded = true;
            this._unloadInProgress = false;
        }
        
        private function removeLoaderListener() : void {
            this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoadComplete);
            this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
            this.loader.contentLoaderInfo.removeEventListener(Event.UNLOAD,this.onUnloadComplete);
        }
    }
}
