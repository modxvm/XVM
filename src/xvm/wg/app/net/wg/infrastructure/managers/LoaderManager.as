package net.wg.infrastructure.managers
{
    import net.wg.infrastructure.base.meta.impl.LoaderManagerMeta;
    import flash.utils.Dictionary;
    import net.wg.data.Aliases;
    import flash.net.URLRequest;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.system.ApplicationDomain;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import net.wg.infrastructure.events.LoaderEvent;
    import net.wg.infrastructure.interfaces.IView;
    import flash.display.LoaderInfo;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    
    public class LoaderManager extends LoaderManagerMeta implements ILoaderManager
    {
        
        public function LoaderManager()
        {
            super();
            this.loaderToToken = new Dictionary(true);
        }
        
        private var loaderToToken:Dictionary;
        
        private var firstTimeLoadLobby:Boolean = false;
        
        public function as_loadView(param1:Object, param2:String, param3:String, param4:String) : void
        {
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
            this.dispatchLoaderEvent(LoaderEvent.VIEW_LOADING,param1,param2);
        }
        
        public function stopLoadingByAliases(param1:Array) : Array
        {
            var _loc3_:* = undefined;
            var _loc4_:Loader = null;
            var _loc5_:LoadInfo = null;
            var _loc6_:* = 0;
            var _loc2_:Array = [];
            for(_loc3_ in this.loaderToToken)
            {
                _loc4_ = Loader(_loc3_);
                _loc5_ = this.loaderToToken[_loc4_];
                _loc6_ = param1.indexOf(_loc5_.alias);
                if(_loc6_ != -1)
                {
                    param1.splice(_loc6_,1);
                    _loc2_.push(_loc5_.token);
                    _loc3_.contentLoaderInfo.removeEventListener(Event.INIT,this.onSWFLoaded,false);
                    _loc3_.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError,false);
                    _loc4_.unloadAndStop(true);
                    _loc5_.dispose();
                    delete this.loaderToToken[_loc3_];
                    true;
                }
            }
            return _loc2_;
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:Object = null;
            var _loc2_:Loader = null;
            var _loc3_:LoadInfo = null;
            for(_loc1_ in this.loaderToToken)
            {
                _loc3_ = this.loaderToToken[_loc1_];
                _loc3_.dispose();
                _loc2_ = _loc1_ as Loader;
                _loc2_.close();
                _loc2_.contentLoaderInfo.removeEventListener(Event.INIT,this.onSWFLoaded);
                _loc2_.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError);
                delete this.loaderToToken[_loc2_];
                true;
            }
        }
        
        private function dispatchLoaderEvent(param1:String, param2:Object, param3:String, param4:IView = null) : void
        {
            dispatchEvent(new LoaderEvent(param1,param2,param3,param4));
        }
        
        private function onSWFLoaded(param1:Event) : void
        {
            var event:Event = param1;
            var info:LoaderInfo = LoaderInfo(event.currentTarget);
            var loader:Loader = info.loader;
            info.removeEventListener(Event.INIT,this.onSWFLoaded);
            info.removeEventListener(IOErrorEvent.IO_ERROR,this.onSWFLoadError);
            var data:LoadInfo = this.loaderToToken[loader];
            var config:Object = data.config;
            var token:String = data.token;
            var alias:String = data.alias;
            var view:IView = loader.content as IView;
            if(!view)
            {
                try
                {
                    view = IView(loader.content["main"]);
                    this.removeExtraInstances(loader);
                }
                catch(e:*)
                {
                }
            }
            if(view)
            {
                this.applyViewData(view,data,loader);
                this.dispatchLoaderEvent(LoaderEvent.VIEW_LOADED,config,token,view);
                viewLoadedS(token,view);
            }
            else
            {
                viewInitializationErrorS(token,config,alias);
            }
            data.dispose();
            delete this.loaderToToken[loader];
            true;
        }
        
        private function applyViewData(param1:IView, param2:LoadInfo, param3:Loader) : void
        {
            param1.as_token = param2.token;
            param1.as_config = param2.config;
            param1.as_alias = param2.alias;
            param1.as_name = param2.name;
            param1.loader = param3;
        }
        
        private function removeExtraInstances(param1:Loader) : void
        {
            var _loc4_:DisplayObject = null;
            var _loc2_:int = DisplayObjectContainer(param1.content).numChildren;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_)
            {
                _loc4_ = DisplayObjectContainer(param1.content).getChildAt(_loc3_);
                if(_loc4_.name != "main")
                {
                    App.utils.commons.releaseReferences(_loc4_);
                }
                _loc3_++;
            }
        }
        
        private function onSWFLoadError(param1:IOErrorEvent) : void
        {
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
            delete this.loaderToToken[_loc3_];
            true;
            dispatchEvent(new LoaderEvent(LoaderEvent.VIEW_LOAD_ERROR,_loc7_));
            _loc3_.unloadAndStop();
        }
    }
}
class LoadInfo extends Object
{
    
    function LoadInfo(param1:String, param2:String, param3:String, param4:Object)
    {
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
    
    public function dispose() : void
    {
        this.token = null;
        this.alias = null;
        this.name = null;
        this.config = null;
    }
}
