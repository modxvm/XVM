package com.xvm.wg
{
    //import net.wg.infrastructure.base.meta.impl.ImageManagerMeta;
    import net.wg.infrastructure.managers.IImageManager;
    import flash.utils.Dictionary;
    import net.wg.infrastructure.managers.ILoaderManager;
    import net.wg.data.constants.ImageCacheTypes;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import net.wg.infrastructure.events.LoaderEvent;
    import net.wg.infrastructure.interfaces.IImageData;
    //import org.idmedia.as3commons.util.StringUtils;

    public class ImageManagerWG extends ImageManagerMetaWG implements IImageManager
    {
        // <xvm>
        private static var _imageMgr:IImageManager = null;
        public static function get imageMgr():IImageManager
        {
            if (!_imageMgr)
            {
                _imageMgr = App.imageMgr || new ImageManagerWG();
            }
            return _imageMgr;
        }

        private static const MAX_CACHE_SIZE:int = 8 * 1024 * 1024; // 8 MB // 8 MB default in GUI_SETTINGS
        private static const MIN_CACHE_SIZE:int = 1 * 1024 * 1024; // 1 MB // 1 MB default in GUI_SETTINGS
        /// </xvm>

        private var _webCache:Dictionary = null;

        private var _cache:Dictionary = null;

        private var _queue:Vector.<ImageData> = null;

        private var _init:Boolean = false;

        private var _loaderMgr:ILoaderManager = null;

        private var _cacheSize:uint = 0;

        private var _maxCacheSize:int = 0;

        private var _minCacheSize:int = 0;

        public function ImageManagerWG()
        {
            super();
            this._webCache = new Dictionary();
            this._cache = new Dictionary();
            this._queue = new Vector.<ImageData>();
        }

        /// <xvm>
        override protected function onPopulate():void
        {
            super.onPopulate();
            as_setImageCacheSettings(MAX_CACHE_SIZE, MIN_CACHE_SIZE);
        }
        /// </xvm>

        override protected function loadImages(param1:Array) : void
        {
            var _loc3_:String = null;
            var _loc2_:ImageData = null;
            for each(_loc3_ in param1)
            {
                if(this._webCache.hasOwnProperty(_loc3_))
                {
                    _loc2_ = ImageData(this._webCache[_loc3_]);
                    if(!_loc2_.isLockData())
                    {
                        if(!_loc2_.lockData())
                        {
                            _loc2_.dispose();
                            _loc2_ = new ImageData(_loc3_, ImageCacheTypes.USE_WEB_CACHE);
                        }
                    }
                }
                else
                {
                    _loc2_ = new ImageData(_loc3_, ImageCacheTypes.USE_WEB_CACHE);
                }
                _loc2_.permanent = true;
                this._webCache[_loc3_] = _loc2_;
            }
            param1.splice(0, param1.length);
        }

        override protected function unloadImages(param1:Array) : void
        {
            var _loc3_:String = null;
            var _loc2_:ImageData = null;
            for each(_loc3_ in param1)
            {
                if(this._webCache.hasOwnProperty(_loc3_))
                {
                    _loc2_ = this._webCache[_loc3_];
                    _loc2_.permanent = false;
                    if(_loc2_.ready)
                    {
                        _loc2_.unlockData();
                    }
                    else
                    {
                        _loc2_.addEventListener(Event.COMPLETE, this.onLoaderCompleteHandler);
                        _loc2_.addEventListener(IOErrorEvent.IO_ERROR, this.onLoaderIoErrorHandler);
                    }
                }
                else
                {
                    App.utils.asserter.assert(false, "Unload a non-existent data: " + _loc3_);
                }
            }
        }

        public function as_setImageCacheSettings(param1:int, param2:int) : void
        {
            this._maxCacheSize = param1;
            this._minCacheSize = param2;
            this.initCache();
        }

        public override final function dispose() : void
        {
            var _loc1_:ImageData = null;
            if(this._init)
            {
                this._loaderMgr.removeEventListener(LoaderEvent.VIEW_LOADING, this.onLoaderMgrViewLoadingHandler);
                this._loaderMgr = null;
            }
            this._queue.splice(0, this._queue.length);
            this._queue = null;
            for each(_loc1_ in this._webCache)
            {
                delete this._webCache[_loc1_.source];
                _loc1_.dispose();
            }
            this._webCache = null;
            for each(_loc1_ in this._cache)
            {
                delete this._cache[_loc1_.source];
                _loc1_.dispose();
            }
            this._cache = null;
        }

        public function getImageData(param1:String, param2:int = 1) : IImageData
        {
            var _loc3_:ImageData = null;
            if(param1 == null || param1.length == 0) // orig: if(StringUtils.isEmpty(param1))
            {
                return null;
            }
            _loc3_ = this.getLoader(param1, param2);
            if(!_loc3_.ready)
            {
                _loc3_.addEventListener(Event.COMPLETE, this.onLoaderCompleteHandler);
                _loc3_.addEventListener(IOErrorEvent.IO_ERROR, this.onLoaderIoErrorHandler);
            }
            return _loc3_;
        }

        private function getLoader(param1:String, param2:int = 1) : ImageData
        {
            App.utils.asserter.assert(this._init, "ImageManager not been initialized");
            var _loc3_:ImageData = null;
            if(param2 == ImageCacheTypes.USE_WEB_CACHE && this._webCache.hasOwnProperty(param1))
            {
                _loc3_ = ImageData(this._webCache[param1]);
            }
            else if(param2 == ImageCacheTypes.USE_CACHE && this._cache.hasOwnProperty(param1))
            {
                _loc3_ = ImageData(this._cache[param1]);
            }
            if(_loc3_)
            {
                if(!_loc3_.isLockData())
                {
                    if(_loc3_.lockData())
                    {
                        this.pushQueue(_loc3_);
                    }
                    else
                    {
                        _loc3_.dispose();
                        _loc3_ = this.createImageLoader(param1, param2);
                    }
                }
            }
            else
            {
                _loc3_ = this.createImageLoader(param1, param2);
            }
            return _loc3_;
        }

        private function createImageLoader(param1:String, param2:int = 1) : ImageData
        {
            var _loc3_:ImageData = new ImageData(param1, param2);
            if(param2 == ImageCacheTypes.USE_WEB_CACHE)
            {
                this._webCache[param1] = _loc3_;
            }
            else if(param2 == ImageCacheTypes.USE_CACHE)
            {
                this._cache[param1] = _loc3_;
            }
            return _loc3_;
        }

        private function pushQueue(param1:ImageData) : void
        {
            if(param1.cacheType != ImageCacheTypes.NOT_USE_CACHE)
            {
                App.utils.asserter.assert(this._minCacheSize > param1.size, "Image size exceeds the buffer cache: " + param1.source + " " + this._minCacheSize);
            }
            if(param1.cacheType == ImageCacheTypes.USE_CACHE)
            {
                this._queue.push(param1);
                this._cacheSize = this._cacheSize + param1.size;
            }
        }

        private function clearCache() : void
        {
            var _loc1_:ImageData = null;
            var _loc3_:String = null;
            var _loc2_:Vector.<String> = new Vector.<String>();
            while(this._cacheSize > this._minCacheSize)
            {
                _loc1_ = this._queue.shift();
                this._cacheSize = this._cacheSize - _loc1_.size;
                _loc1_.unlockData();
            }
            for each(_loc1_ in this._cache)
            {
                if(!_loc1_.valid)
                {
                    _loc2_.push(_loc1_.source);
                    _loc1_.dispose();
                }
            }
            for each(_loc3_ in _loc2_)
            {
                delete this._cache[_loc3_];
            }
        }

        private function initCache() : void
        {
            if(!this._init)
            {
                this._init = true;
                this._loaderMgr = App.instance.loaderMgr;
                this._loaderMgr.addEventListener(LoaderEvent.VIEW_LOADING, this.onLoaderMgrViewLoadingHandler);
            }
        }

        private function onLoaderCompleteHandler(param1:Event) : void
        {
            var _loc2_:ImageData = ImageData(param1.target);
            _loc2_.removeEventListener(Event.COMPLETE, this.onLoaderCompleteHandler);
            _loc2_.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoaderIoErrorHandler);
            if(!_loc2_.permanent)
            {
                this.pushQueue(_loc2_);
            }
        }

        private function onLoaderIoErrorHandler(param1:IOErrorEvent) : void
        {
            var _loc2_:ImageData = ImageData(param1.target);
            _loc2_.removeEventListener(Event.COMPLETE, this.onLoaderCompleteHandler);
            _loc2_.removeEventListener(IOErrorEvent.IO_ERROR, this.onLoaderIoErrorHandler);
        }

        private function onLoaderMgrViewLoadingHandler(param1:LoaderEvent) : void
        {
            if(this._cacheSize > this._maxCacheSize)
            {
                this.clearCache();
            }
        }
    }
}

