package net.wg.infrastructure.helpers
{
   import flash.events.EventDispatcher;
   import flash.display.DisplayObjectContainer;
   import __AS3__.vec.Vector;
   import flash.display.Loader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import net.wg.data.constants.Errors;
   import flash.system.ApplicationDomain;
   import flash.events.Event;
   import flash.display.LoaderInfo;
   import net.wg.infrastructure.events.LibraryLoaderEvent;
   import flash.events.IOErrorEvent;


   public class LibraryLoader extends EventDispatcher
   {
          
      public function LibraryLoader(param1:DisplayObjectContainer) {
         super();
         this.container = param1;
         this.loaders = new Vector.<Loader>();
      }

      private var container:DisplayObjectContainer;

      private var librariesList:Vector.<String> = null;

      private var processedCounter:int = 0;

      private var loaders:Vector.<Loader> = null;

      public function dispose() : void {
         var _loc1_:Loader = null;
         for each (_loc1_ in this.loaders)
         {
            this.removeListeners(_loc1_.contentLoaderInfo);
            _loc1_.unloadAndStop(true);
         }
         this.loaders.splice(0,this.loaders.length);
         this.loaders = null;
         this.container = null;
         DebugUtils.LOG_DEBUG("LibraryLoader disposed");
      }

      public function load(param1:Vector.<String>) : void {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         var _loc4_:Loader = null;
         var _loc5_:LoaderContext = null;
         this.librariesList = param1;
         App.utils.asserter.assertNotNull(param1,"librariesList" + Errors.CANT_NULL);
         if(param1.length)
         {
            _loc5_ = new LoaderContext(false,ApplicationDomain.currentDomain);
            for each (_loc2_ in param1)
            {
               DebugUtils.LOG_DEBUG("LibraryLoader load",_loc2_);
               _loc3_ = new URLRequest(_loc2_);
               _loc4_ = new Loader();
               _loc4_.load(_loc3_,_loc5_);
               this.addListeners(_loc4_.contentLoaderInfo);
               this.loaders.push(_loc4_);
            }
         }
      }

      private function onLibLoaded(param1:Event) : void {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         this.removeListeners(_loc2_);
         DebugUtils.LOG_DEBUG("Library loaded",_loc2_.url);
         _loc2_.loader.visible = false;
         this.container.addChild(_loc2_.loader);
         dispatchEvent(new LibraryLoaderEvent(LibraryLoaderEvent.LOADED,_loc2_.loader,_loc2_.url));
         this.checkLoadComplete();
      }

      private function onLibLoadError(param1:IOErrorEvent) : void {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         this.removeListeners(_loc2_);
         DebugUtils.LOG_DEBUG("Library load error",_loc2_.url);
         this.checkLoadComplete();
      }

      private function checkLoadComplete() : void {
         _loc1_.processedCounter = this.processedCounter+1;
         if(this.processedCounter == this.librariesList.length)
         {
            DebugUtils.LOG_DEBUG("Libraries loading has been completed.");
         }
      }

      private function addListeners(param1:LoaderInfo) : void {
         param1.addEventListener(Event.INIT,this.onLibLoaded);
         param1.addEventListener(IOErrorEvent.IO_ERROR,this.onLibLoadError);
      }

      private function removeListeners(param1:LoaderInfo) : void {
         param1.removeEventListener(Event.INIT,this.onLibLoaded);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this.onLibLoadError);
      }
   }

}