package net.wg.gui.lobby.profile.components 
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class SimpleLoader extends flash.display.Sprite implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function SimpleLoader()
        {
            super();
            return;
        }

        public function setSource(arg1:String):void
        {
            if (this.currentSourcePath == arg1) 
                return;
            if (this.loader) 
                this.loader.unloadAndStop(true);
            this.currentSourcePath = arg1;
            if (arg1 && !(arg1 == "")) 
                this.startLoading(arg1);
            else 
                this.clear();
            return;
        }

        public function clear():void
        {
            this.disposeLoader();
            return;
        }

        public function disposeLoader():void
        {
            this.currentSourcePath = null;
            if (this.loader) 
            {
                this.removeLoaderHandlers();
                this.loader.unloadAndStop(true);
                this.loader.parent.removeChild(this.loader);
                this.loader = null;
            }
            return;
        }

        public function dispose():void
        {
            this.disposeLoader();
            return;
        }

        protected function startLoading(arg1:String):void
        {
            if (!this.loader) 
            {
                this.loader = new flash.display.Loader();
                this.addLoaderHandlers();
                addChild(this.loader);
            }
            this.loader.load(new flash.net.URLRequest(arg1));
            return;
        }

        protected function onLoadingComplete():void
        {
            return;
        }

        protected function onLoadingError():void
        {
            return;
        }

        internal function addLoaderHandlers():void
        {
            this.loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.loadingCompleteHandler, false, 0, true);
            this.loader.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.loadingErrorHandler, false, 0, true);
            return;
        }

        internal function removeLoaderHandlers():void
        {
            this.loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, this.loadingCompleteHandler);
            this.loader.contentLoaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.loadingErrorHandler);
            return;
        }

        internal function loadingErrorHandler(arg1:flash.events.IOErrorEvent):void
        {
            this.onLoadingError();
            DebugUtils.LOG_DEBUG(flash.utils.getQualifiedClassName(this) + " : couldn\'t load extra icon!", this.currentSourcePath);
            dispatchEvent(new flash.events.Event(LOAD_ERROR));
            return;
        }

        internal function loadingCompleteHandler(arg1:flash.events.Event):void
        {
            this.onLoadingComplete();
            dispatchEvent(new flash.events.Event(LOADED));
            return;
        }

        public static const LOADED:String="sourceLoaded";

        public static const LOAD_ERROR:String="sourceLoadError";

        protected var loader:flash.display.Loader;

        internal var currentSourcePath:String;
    }
}
