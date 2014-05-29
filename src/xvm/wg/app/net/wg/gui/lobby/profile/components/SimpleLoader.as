package net.wg.gui.lobby.profile.components
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import flash.display.Loader;
   import flash.net.URLRequest;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.utils.getQualifiedClassName;


   public class SimpleLoader extends Sprite implements IDisposable
   {
          
      public function SimpleLoader() {
         super();
      }

      public static const LOADED:String = "sourceLoaded";

      public static const LOAD_ERROR:String = "sourceLoadError";

      private static const CONTENT_TYPE_SWF:String = "application/x-shockwave-flash";

      private var _loader:Loader;

      private var currentSourcePath:String;

      public function setSource(param1:String) : void {
         if(this.currentSourcePath == param1)
         {
            return;
         }
         if(this._loader)
         {
            this.unloadLoader();
         }
         this.currentSourcePath = param1;
         if((param1) && !(param1 == ""))
         {
            this.startLoading(param1);
         }
         else
         {
            this.clear();
         }
      }

      public function clear() : void {
         this.disposeLoader();
      }

      public function disposeLoader() : void {
         if(this._loader)
         {
            this.removeLoaderHandlers();
            this.unloadLoader();
            this._loader.parent.removeChild(this._loader);
            this._loader = null;
         }
         this.currentSourcePath = null;
      }

      public final function dispose() : void {
         this.onDispose();
      }

      protected function onDispose() : void {
         this.disposeLoader();
      }

      protected function startLoading(param1:String) : void {
         if(!this._loader)
         {
            this._loader = new Loader();
            this.addLoaderHandlers();
            addChild(this._loader);
         }
         this._loader.load(new URLRequest(param1));
      }

      protected function onLoadingComplete() : void {
          
      }

      protected function onLoadingError() : void {
          
      }

      protected function get loader() : Loader {
         return this._loader;
      }

      private function unloadLoader() : void {
         if(this._loader.contentLoaderInfo.contentType == CONTENT_TYPE_SWF)
         {
            this._loader.unloadAndStop(true);
         }
         else
         {
            this._loader.unload();
         }
      }

      private function addLoaderHandlers() : void {
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadingCompleteHandler,false,0,true);
         this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadingErrorHandler,false,0,true);
      }

      private function removeLoaderHandlers() : void {
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadingCompleteHandler);
         this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadingErrorHandler);
      }

      private function loadingErrorHandler(param1:IOErrorEvent) : void {
         this.onLoadingError();
         DebugUtils.LOG_DEBUG(getQualifiedClassName(this) + " : couldn\'t load extra icon!",this.currentSourcePath);
         dispatchEvent(new Event(LOAD_ERROR));
      }

      private function loadingCompleteHandler(param1:Event) : void {
         this.onLoadingComplete();
         dispatchEvent(new Event(LOADED));
      }
   }

}