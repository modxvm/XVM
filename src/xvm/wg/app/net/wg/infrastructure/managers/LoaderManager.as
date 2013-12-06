package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.base.meta.impl.LoaderManagerMeta;
   import net.wg.infrastructure.base.meta.ILoaderManagerMeta;
   import flash.utils.Dictionary;
   import net.wg.data.Aliases;
   import flash.net.URLRequest;
   import flash.display.Loader;
   import flash.system.LoaderContext;
   import flash.system.ApplicationDomain;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.display.LoaderInfo;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.events.LoaderEvent;


   public class LoaderManager extends LoaderManagerMeta implements ILoaderManagerMeta
   {
          
      public function LoaderManager() {
         super();
         this.loaderToToken = new Dictionary(true);
      }

      private var loaderToToken:Dictionary;

      private var firstTimeLoadLobby:Boolean = false;

      public function as_loadView(param1:Object, param2:String, param3:String, param4:String) : void {
         if(param3 == Aliases.LOBBY && !this.firstTimeLoadLobby)
         {
            App.libraryLoader.load(Vector.<String>(["toolTips.swf"]));
            this.firstTimeLoadLobby = true;
         }
         var _loc5_:URLRequest = new URLRequest(param1.url);
         var _loc6_:Loader = new Loader();
         var _loc7_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         _loc6_.load(_loc5_,_loc7_);
         _loc6_.contentLoaderInfo.addEventListener(Event.INIT,this.onSWFLoaded,false,0,true);
         _loc6_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError,false,0,true);
         this.loaderToToken[_loc6_] = new LoadInfo(param2,param3,param4,param1);
      }

      override protected function onDispose() : void {
         var _loc1_:Object = null;
         var _loc2_:Loader = null;
         var _loc3_:LoadInfo = null;
         for (_loc1_ in this.loaderToToken)
         {
            _loc3_ = this.loaderToToken[_loc1_];
            _loc3_.dispose();
            _loc2_ = _loc1_ as Loader;
            _loc2_.close();
            _loc2_.contentLoaderInfo.removeEventListener(Event.INIT,this.onSWFLoaded);
            _loc2_.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError);
            delete this.loaderToToken[[_loc2_]];
         }
      }

      private function onSWFLoaded(param1:Event) : void {
         var event:Event = param1;
         var info:LoaderInfo = LoaderInfo(event.currentTarget);
         var loader:Loader = info.loader;
         info.removeEventListener(Event.INIT,this.onSWFLoaded);
         info.removeEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError);
         var data:LoadInfo = this.loaderToToken[loader];
         var config:Object = data.config;
         var token:String = data.token;
         var alias:String = data.alias;
         var name:String = data.name;
         var view:IView = loader.content as IView;
         if(!view)
         {
            try
            {
               view = IView(loader.content["main"]);
            }
            catch(e:*)
            {
            }
         }
         if(view)
         {
            view.as_token = token;
            view.as_config = config;
            view.as_alias = alias;
            view.as_name = name;
            view.loader = loader;
            dispatchEvent(new LoaderEvent(LoaderEvent.VIEW_LOADED,config,token,view));
            viewLoadedS(token,view);
         }
         else
         {
            viewInitializationErrorS(token,config,alias);
         }
         data.dispose();
         delete this.loaderToToken[[loader]];
      }

      private function onSWFLoadError(param1:IOErrorEvent) : void {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         var _loc3_:Loader = _loc2_.loader;
         _loc2_.removeEventListener(Event.INIT,this.onSWFLoaded);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError);
         var _loc4_:LoadInfo = this.loaderToToken[_loc3_];
         var _loc5_:String = _loc4_.token;
         var _loc6_:String = _loc4_.alias;
         var _loc7_:Object = _loc4_.config;
         viewLoadErrorS(_loc5_,_loc6_,param1.text);
         _loc4_.dispose();
         delete this.loaderToToken[[_loc3_]];
         dispatchEvent(new LoaderEvent(LoaderEvent.VIEW_LOAD_ERROR,_loc7_));
         _loc3_.unloadAndStop();
      }
   }

}

   class LoadInfo extends Object
   {
          
      function LoadInfo(param1:String, param2:String, param3:String, param4:Object) {
         super();
         this.token = param1;
         this.alias = param2;
         this.name = param3;
         this.config = param4;
      }

      public var token:String;

      public var alias:String;

      public var name:String;

      public var config:Object;

      public function dispose() : void {
         this.token = null;
         this.alias = null;
         this.name = null;
         this.config = null;
      }
   }
