package net.wg.gui.components.advanced
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.system.ApplicationDomain;


   public class ButtonIconLoader extends SoundButtonEx
   {
          
      public function ButtonIconLoader() {
         super();
      }

      protected var loader:Loader;

      public var container:MovieClip;

      private var _iconSource:String;

      protected var _externalSource:Boolean = false;

      public function get externalSource() : Boolean {
         return this._externalSource;
      }

      public function set externalSource(param1:Boolean) : void {
         this._externalSource = param1;
      }

      public function get iconSource() : String {
         return this._iconSource;
      }

      public function set iconSource(param1:String) : void {
         if((param1 == "" || param1 == null || param1 == this._iconSource) && !this._externalSource)
         {
            return;
         }
         this._iconSource = param1;
         this.initLoader();
      }

      protected function completeHandler(param1:Event) : void {
         if((this.loader) && (this.container.contains(this.loader)))
         {
            this.container.removeChild(this.loader);
         }
         this.loader.scaleX = 1 / scaleX;
         this.loader.scaleY = 1 / scaleY;
         this.loader.x = Math.floor((this.container.width - this.loader.width) / 2);
         this.loader.y = Math.floor((this.container.height - this.loader.height) / 2);
         this.container.addChild(this.loader);
      }

      private function initLoader() : void {
         this.loader = new Loader();
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeHandler);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         var _loc1_:URLRequest = new URLRequest(this.iconSource);
         var _loc2_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         this.loader.load(_loc1_,_loc2_);
      }

      private function loaderDispose() : void {
         if(this.loader)
         {
            this.loader.unloadAndStop(true);
            this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.completeHandler);
            this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
            if((this.container) && (this.container.contains(this.loader)))
            {
               this.container.removeChild(this.loader);
            }
            this.loader = null;
         }
      }

      private function ioErrorHandler(param1:IOErrorEvent) : void {
         DebugUtils.LOG_ERROR(this + " can\'t find source file : ",this._iconSource);
      }

      override protected function onDispose() : void {
         this.loaderDispose();
         super.onDispose();
      }
   }

}