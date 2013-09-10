package net.wg.infrastructure.helpers 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.events.*;
    
    public class LibraryLoader extends flash.events.EventDispatcher
    {
        public function LibraryLoader(arg1:flash.display.DisplayObjectContainer)
        {
            super();
            this.container = arg1;
            this.loaders = new Vector.<flash.display.Loader>();
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.loaders;
            for each (loc1 in loc3) 
            {
                this.removeListeners(loc1.contentLoaderInfo);
                loc1.unloadAndStop(true);
            }
            this.loaders.splice(0, this.loaders.length);
            this.loaders = null;
            this.container = null;
            DebugUtils.LOG_DEBUG("LibraryLoader disposed");
            return;
        }

        public function load(arg1:__AS3__.vec.Vector.<String>):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            this.librariesList = arg1;
            App.utils.asserter.assertNotNull(arg1, "librariesList" + net.wg.data.constants.Errors.CANT_NULL);
            if (arg1.length) 
            {
                loc4 = new flash.system.LoaderContext(false, flash.system.ApplicationDomain.currentDomain);
                var loc5:*=0;
                var loc6:*=arg1;
                for each (loc1 in loc6) 
                {
                    DebugUtils.LOG_DEBUG("LibraryLoader load", loc1);
                    loc2 = new flash.net.URLRequest(loc1);
                    (loc3 = new flash.display.Loader()).load(loc2, loc4);
                    this.addListeners(loc3.contentLoaderInfo);
                    this.loaders.push(loc3);
                }
            }
            return;
        }

        internal function onLibLoaded(arg1:flash.events.Event):void
        {
            var loc1:*=flash.display.LoaderInfo(arg1.currentTarget);
            this.removeListeners(loc1);
            DebugUtils.LOG_DEBUG("Library loaded", loc1.url);
            loc1.loader.visible = false;
            this.container.addChild(loc1.loader);
            dispatchEvent(new net.wg.infrastructure.events.LibraryLoaderEvent(net.wg.infrastructure.events.LibraryLoaderEvent.LOADED, loc1.loader, loc1.url));
            this.checkLoadComplete();
            return;
        }

        internal function onLibLoadError(arg1:flash.events.IOErrorEvent):void
        {
            var loc1:*=flash.display.LoaderInfo(arg1.currentTarget);
            this.removeListeners(loc1);
            DebugUtils.LOG_DEBUG("Library load error", loc1.url);
            this.checkLoadComplete();
            return;
        }

        internal function checkLoadComplete():void
        {
            var loc1:*;
            var loc2:*=((loc1 = this).processedCounter + 1);
            loc1.processedCounter = loc2;
            if (this.processedCounter == this.librariesList.length) 
                DebugUtils.LOG_DEBUG("Libraries loading has been completed.");
            return;
        }

        internal function addListeners(arg1:flash.display.LoaderInfo):void
        {
            arg1.addEventListener(flash.events.Event.INIT, this.onLibLoaded);
            arg1.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onLibLoadError);
            return;
        }

        internal function removeListeners(arg1:flash.display.LoaderInfo):void
        {
            arg1.removeEventListener(flash.events.Event.INIT, this.onLibLoaded);
            arg1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onLibLoadError);
            return;
        }

        internal var container:flash.display.DisplayObjectContainer;

        internal var librariesList:__AS3__.vec.Vector.<String>=null;

        internal var processedCounter:int=0;

        internal var loaders:__AS3__.vec.Vector.<flash.display.Loader>=null;
    }
}
