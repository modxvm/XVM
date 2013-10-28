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

      protected var loader:Loader;

      private var currentSourcePath:String;

      public function setSource(param1:String) : void {
         if(this.currentSourcePath == param1)
         {
            return;
         }
         if(this.loader)
         {
            this.loader.unloadAndStop(true);
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
         this.currentSourcePath = null;
         if(this.loader)
         {
            this.removeLoaderHandlers();
            this.loader.unloadAndStop(true);
            this.loader.parent.removeChild(this.loader);
            this.loader = null;
         }
      }

      public function dispose() : void {
         this.disposeLoader();
      }

      protected function startLoading(param1:String) : void {
         if(!this.loader)
         {
            this.loader = new Loader();
            this.addLoaderHandlers();
            addChild(this.loader);
         }
         this.loader.load(new URLRequest(param1));
      }

      protected function onLoadingComplete() : void {
          
      }

      protected function onLoadingError() : void {
          
      }

      private function addLoaderHandlers() : void {
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadingCompleteHandler,false,0,true);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadingErrorHandler,false,0,true);
      }

      private function removeLoaderHandlers() : void {
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadingCompleteHandler);
         this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadingErrorHandler);
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