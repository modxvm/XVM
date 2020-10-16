package com.xvm.wg
{
    import flash.events.EventDispatcher;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IImageData;
    import flash.display.Loader;
    import net.wg.infrastructure.interfaces.IImage;
    import net.wg.data.constants.ImageCacheTypes;
    import flash.events.Event;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;

    internal class ImageData extends EventDispatcher implements IDisposable, IImageData
    {

        private static const BYTE_PER_PIXEL:int = 4;

        private static const CONTENT_TYPE_SWF:String = "application/x-shockwave-flash";

        private var _loader:Loader = null;

        private var _weakBitmapData:WeakRef = null;

        private var _ready:Boolean = false;

        private var _size:uint = 0;

        private var _permanent:Boolean = false;

        private var _source:String = "";

        private var _cacheType:int = 1;

        function ImageData(param1:String, param2:int)
        {
            super();
            this._source = param1;
            this._cacheType = param2;
            var _loc3_:URLRequest = new URLRequest(param1);
            var _loc4_:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
            this._loader = new Loader();
            this.addLoaderListeners();
            this._loader.load(_loc3_, _loc4_);
        }

        public function dispose() : void
        {
            if(this._ready)
            {
                this._weakBitmapData.dispose();
                this._weakBitmapData = null;
            }
            else
            {
                this.removeLoaderListeners();
                this._loader.close();
                this._loader = null;
            }
        }

        public function isLockData() : Boolean
        {
            if(this._ready)
            {
                return this._weakBitmapData.isLock;
            }
            return true;
        }

        public function lockData() : Boolean
        {
            return this._weakBitmapData.lock();
        }

        public function unlockData() : void
        {
            if(!this._permanent)
            {
                this._weakBitmapData.unlock();
            }
        }

        public function get source() : String
        {
            return this._source;
        }

        public function get size() : uint
        {
            return this._size;
        }

        public function get valid() : Boolean
        {
            if(this._ready)
            {
                return this._weakBitmapData.target != null;
            }
            return true;
        }

        public function get ready() : Boolean
        {
            return this._ready;
        }

        public function get cacheType() : int
        {
            return this._cacheType;
        }

        public function showTo(param1:IImage) : void
        {
            param1.bitmapData = this._weakBitmapData.target;
        }

        public function removeFrom(param1:IImage) : void
        {
            param1.bitmapData = null;
            if(this._cacheType == ImageCacheTypes.NOT_USE_CACHE)
            {
                this.dispose();
            }
        }

        private function onLoaderCompleteHandler(param1:Event) : void
        {
            this.removeLoaderListeners();
            App.utils.asserter.assert(this._loader.contentLoaderInfo.contentType != CONTENT_TYPE_SWF, "Content loader is not image: " + this._source);
            var _loc2_:BitmapData = Bitmap(this._loader.content).bitmapData;
            this._weakBitmapData = new WeakRef(_loc2_, true);
            this._size = _loc2_.width * _loc2_.height * BYTE_PER_PIXEL;
            this._loader.unload();
            this._loader = null;
            this._ready = true;
            dispatchEvent(new Event(Event.COMPLETE));
        }

        private function onLoaderIOErrorHandler(param1:IOErrorEvent) : void
        {
            this.removeLoaderListeners();
            DebugUtils.LOG_ERROR(param1.toString());
            dispatchEvent(param1);
            this._weakBitmapData = new WeakRef(null);
            this._loader = null;
            this._ready = true;
        }

        private function addLoaderListeners() : void
        {
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoaderCompleteHandler);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onLoaderIOErrorHandler);
        }

        private function removeLoaderListeners() : void
        {
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoaderCompleteHandler);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoaderIOErrorHandler);
        }

        public function get permanent() : Boolean
        {
            return this._permanent;
        }

        public function set permanent(param1:Boolean) : void
        {
            this._permanent = param1;
        }
    }
}