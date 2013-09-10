package net.wg.infrastructure.managers 
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class LoaderManager extends net.wg.infrastructure.base.meta.impl.LoaderManagerMeta implements net.wg.infrastructure.base.meta.ILoaderManagerMeta
    {
        public function LoaderManager()
        {
            super();
            this.loaderToToken = new flash.utils.Dictionary(true);
            return;
        }

        public function as_loadView(arg1:Object, arg2:String, arg3:String, arg4:String):void
        {
            var loc1:*=new flash.net.URLRequest(arg1.url);
            var loc2:*=new flash.display.Loader();
            var loc3:*=new flash.system.LoaderContext(false, flash.system.ApplicationDomain.currentDomain);
            loc2.load(loc1, loc3);
            loc2.contentLoaderInfo.addEventListener(flash.events.Event.INIT, this.onSWFLoaded, false, 0, true);
            loc2.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onSWFLoadError, false, 0, true);
            this.loaderToToken[loc2] = new LoadInfo(arg2, arg3, arg4, arg1);
            return;
        }

        protected override function onDispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=this.loaderToToken;
            for (loc1 in loc5) 
            {
                loc3 = this.loaderToToken[loc1];
                loc3.dispose();
                loc2 = loc1 as flash.display.Loader;
                loc2.close();
                loc2.contentLoaderInfo.removeEventListener(flash.events.Event.INIT, this.onSWFLoaded);
                loc2.contentLoaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onSWFLoadError);
                delete this.loaderToToken[loc2];
            }
            return;
        }

        internal function onSWFLoaded(arg1:flash.events.Event):void
        {
            var event:flash.events.Event;
            var info:flash.display.LoaderInfo;
            var loader:flash.display.Loader;
            var data:LoadInfo;
            var config:Object;
            var token:String;
            var alias:String;
            var name:String;
            var view:net.wg.infrastructure.interfaces.IView;

            var loc1:*;
            event = arg1;
            info = flash.display.LoaderInfo(event.currentTarget);
            loader = info.loader;
            info.removeEventListener(flash.events.Event.INIT, this.onSWFLoaded);
            info.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onSWFLoadError);
            data = this.loaderToToken[loader];
            config = data.config;
            token = data.token;
            alias = data.alias;
            name = data.name;
            view = loader.content as net.wg.infrastructure.interfaces.IView;
            if (!view) 
                try 
                    view = net.wg.infrastructure.interfaces.IView(loader.content["main"]);
                catch (e:*)
                {
                };
            if (view) 
            {
                view.as_token = token;
                view.as_config = config;
                view.as_alias = alias;
                view.as_name = name;
                view.loader = loader;
                dispatchEvent(new net.wg.infrastructure.events.LoaderEvent(net.wg.infrastructure.events.LoaderEvent.VIEW_LOADED, config, token, view));
                viewLoadedS(token, view);
            }
            else 
                viewInitializationErrorS(token, config, alias);
            data.dispose();
            delete this.loaderToToken[loader];
            return;
        }

        internal function onSWFLoadError(arg1:flash.events.IOErrorEvent):void
        {
            var loc1:*=flash.display.LoaderInfo(arg1.currentTarget);
            var loc2:*=loc1.loader;
            loc1.removeEventListener(flash.events.Event.INIT, this.onSWFLoaded);
            loc1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onSWFLoadError);
            var loc3:*;
            var loc4:*=(loc3 = this.loaderToToken[loc2]).token;
            var loc5:*=loc3.alias;
            var loc6:*=loc3.config;
            viewLoadErrorS(loc4, loc5, arg1.text);
            loc3.dispose();
            delete this.loaderToToken[loc2];
            dispatchEvent(new net.wg.infrastructure.events.LoaderEvent(net.wg.infrastructure.events.LoaderEvent.VIEW_LOAD_ERROR, loc6));
            loc2.unloadAndStop();
            return;
        }

        internal var loaderToToken:flash.utils.Dictionary;
    }
}


class LoadInfo extends Object
{
    public function LoadInfo(arg1:String, arg2:String, arg3:String, arg4:Object)
    {
        super();
        this.token = arg1;
        this.alias = arg2;
        this.name = arg3;
        this.config = arg4;
        return;
    }

    public function dispose():void
    {
        this.token = null;
        this.alias = null;
        this.name = null;
        this.config = null;
        return;
    }

    public var token:String;

    public var alias:String;

    public var name:String;

    public var config:Object;
}