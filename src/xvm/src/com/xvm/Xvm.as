/**
 * XVM Entry Point
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm
{
    XvmLinks;

    import flash.display.*;
    import flash.events.*;
    import flash.net.URLRequest;
    import flash.utils.*;
    import flash.system.*;
    import com.xvm.*;
    import com.xvm.io.*;
    import net.wg.infrastructure.base.AbstractView;

    [SWF(width="1", height="1", backgroundColor="#000000")]

    public class Xvm extends AbstractView
    {
        public function Xvm():void
        {
            focusable = false;
            Config.load(this, init);
        }

        override protected function nextFrameAfterPopulateHandler():void
        {
            //Logger.add("nextFrameAfterPopulateHandler");
            if (this.parent != App.instance)
                (App.instance as MovieClip).addChild(this);
            visible = false;
        }

        private function init(e:Event = null):void
        {
            if (!stage)
            {
                addEventListener(Event.ADDED_TO_STAGE, init);
                return;
            }
            removeEventListener(Event.ADDED_TO_STAGE, init);

            // entry point

            VehicleInfo.populateData();
            Cmd.getMods(this, onGetModsComplete);
        }

        private function onGetModsComplete(mods:String):void
        {
            // TODO: dispose loader
            try
            {
                if (mods == null)
                    return;

                var list:Array = JSONx.parse(mods) as Array;
                if (list == null || list.length == 0)
                    return;

                var ctx:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);

                var preload:Array = [ // TODO make configurable dependencies
                    "prebattleComponents.swf",      // xvm-company
                    "companiesListWindow.swf",      // xvm-company
                    "companyWindow.swf",            // xvm-company
                    "squadWindow.swf",              // xvm-squad
                    "battleResults.swf",            // xvm-hangar
                    "battleLoading.swf",            // xvm-hangar
                    "hangar.swf",                   // xvm-hangar
                    "TankCarousel.swf",             // xvm-tcarousel
                    "nodesLib.swf",                 // xvm-treeview
                    "serviceMessageComponents.swf", // xvm-svcmsg
                    "profileStatistics.swf",        // xvm-profile
                    "profileTechnique.swf"          // xvm-profile
                ];
                for (var x:int = 0; x < preload.length; ++x)
                {
                    var swf:String = (preload[x] as String).replace(/^.*\//, '');
                    Logger.add("[XVM] Preloading swf: " + swf);
                    var requestSwf:URLRequest = new URLRequest(swf);
                    var loaderSwf:Loader = new Loader();
                    loaderSwf.contentLoaderInfo.addEventListener(Event.INIT, onLibLoaded);
                    loaderSwf.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLibLoadError);
                    loaderSwf.load(requestSwf, ctx);
                }

                for (var i:int = 0; i < list.length; ++i)
                {
                    var mod:String = (list[i] as String).replace(/^.*\//, '');
                    Logger.add("[XVM] Loading mod: " + mod);
                    var request:URLRequest = new URLRequest(Defines.XVMMODS_ROOT + mod);
                    var loader:Loader = new Loader();
                    loader.contentLoaderInfo.addEventListener(Event.INIT, onLibLoaded);
                    loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLibLoadError);
                    loader.load(request, ctx);
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function onLibLoaded(e:Event):void
        {
            try
            {
                var loaderInfo:LoaderInfo = LoaderInfo(e.currentTarget);
                loaderInfo.removeEventListener(Event.INIT, onLibLoaded);
                loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLibLoadError);
                //Logger.add("[XVM] Mod loaded: " + loaderInfo.url.replace(/^.*\//, ''));
                var loader:Loader = loaderInfo.loader;
                loader.visible = false;
                //loader.addEventListener(Event.UNLOAD, onLibUnload);
                stage.addChild(loader);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function onLibLoadError(e:IOErrorEvent):void
        {
            try
            {
                var loaderInfo:LoaderInfo = LoaderInfo(e.currentTarget);
                loaderInfo.removeEventListener(Event.INIT, onLibLoaded);
                loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLibLoadError);
                Logger.add("[XVM] Mod load error: " + e.text);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function onLibUnload(e:Event):void
        {
            Logger.add("unload: " + String(e.target));
        }
    }
}
