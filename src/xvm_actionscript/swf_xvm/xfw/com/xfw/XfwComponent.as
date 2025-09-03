/**
 * XFW Entry Point
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw
{
    import com.xfw.*;
    import com.xfw.infrastructure.*;
    import flash.display.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    import net.wg.gui.components.containers.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.managers.impl.*;
    import org.idmedia.as3commons.util.*;

    public class XfwComponent extends BaseDAAPIComponent
    {
        private static const SWF_LOAD_TIMEOUT:int = 15000;

        // static methods for Python-Flash communication

        public static function tryLoadUISWF(modName:String, swfName:String, preloads:Array = null):int
        {
            try
            {
                if (_loadedUISWFs[swfName])
                    return _loadedUISWFs[swfName];

                _loadedUISWFs[swfName] = XfwConst.SWF_LOADING;

                if (preloads == null)
                    preloads = [];
                var swf:String = _instance.modsNames[modName];
                if (swf == null) {
                    Logger.add("[XFW/XfwComponent] tryLoadUISWF: WARNING: swf is not found for mod name " + modName);
                    return XfwConst.SWF_LOAD_ERROR;
                }
                swf = swf.replace("\\", "/");
                swf = swf.slice(0, swf.lastIndexOf("/") + 1) + swfName;
                var libs:Vector.<String> = Vector.<String>(preloads).concat(Vector.<String>([swf]));
                App.instance.loaderMgr.loadLibraries(libs);

                return XfwConst.SWF_START_LOADING;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }

            return XfwConst.SWF_LOAD_ERROR;
        }

        // private fields

        private static var _instance:XfwComponent;
        private static var _loadedUISWFs:Dictionary = new Dictionary();

        private var modsNames:Object;
        private var modsList:Vector.<String>;
        private var loadedList:Vector.<String>;
        private var loadStartTime:Number;

        // initialization

        public function XfwComponent()
        {
            _instance = this;
            focusable = false;
            visible = false;
            Xfw.registerCommandProvider(xfw_cmdS);
        }

        // DAAPI Python-Flash interface

        public var xfw_cmd:Function = null;
        private function xfw_cmdS(...rest):*
        {
            return this.xfw_cmd.apply(this, rest);
        }

        // Handle XFW command (must be public to be accessible from Python)
        public function as_xfw_cmd(...rest):*
        {
            return Xfw.as_xfw_cmd.apply(this, rest);
        }

        // overrides

        override protected function onPopulate():void
        {
            //Logger.add("XfwComponent.onPopulate()");
            super.onPopulate();
            App.instance.loaderMgr.addEventListener(LibraryLoaderEvent.LOADED, onLibLoaded, false, 0, true);
            loadMods();
        }

        override protected function onDispose():void
        {
            //Logger.add("XfwComponent.onDispose()");
            _instance = null;
            Xfw.unregisterCommandProvider();
            App.instance.loaderMgr.removeEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);
            App.utils.scheduler.cancelTask(checkLoadComplete);
            super.onDispose();
        }

        // PRIVATE

        private function loadMods():void
        {
            try
            {
                modsList = new Vector.<String>();

                var modsInfo:Object = Xfw.cmd(XfwConst.XFW_COMMAND_GETMODS);
                if (modsInfo == null) {
                    Logger.add("[XFW/XfwComponent] loadMods: no mods were found");
                    return;
                }

                modsNames = modsInfo.names

                for(var modName:String in modsNames)
                {
                    var swfFileName:String = modsNames[modName];

                    if(swfFileName == null)
                    {
                        DebugUtils.LOG_WARNING("[XFW/XfwComponent] loadMods: No SWF found for mod name " + modName);
                        continue
                    }

                    if (modsInfo.loaded != null && modsInfo.loaded.indexOf(swfFileName) >= 0)
                    {
                        continue;
                    }

                    modsList.push(swfFileName);
                }

                if (modsList.length == 0)
                {
                    DebugUtils.LOG_WARNING("[XFW/XfwComponent] loadMods: No SWF mods found");
                    finishInit();
                    return;
                }

                // load mods
                loadStartTime = (new Date()).getTime();
                loadedList = new Vector.<String>;
                modsList = modsList.sort(sortModsList);
                Logger.add("[XFW/XfwComponent] loadMods: Loading swf mods:");
                for each (var x:String in modsList)
                {
                    Logger.add("  " + x);
                }
                App.instance.loaderMgr.loadLibraries(modsList);
                checkLoadComplete();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function sortModsList(a:String, b:String):Number
        {
            if (StringUtils.endsWith(a, '/xvm_lobby.swf'))
                return -1;
            if (StringUtils.endsWith(b, '/xvm_lobby.swf'))
                return 1;
            if (StringUtils.endsWith(a, '/xvm_battle_classic.swf'))
                return -1;
            if (StringUtils.endsWith(b, '/xvm_battle_classic.swf'))
                return 1;
            if (StringUtils.endsWith(a, '/xvm_battle_epicbattle.swf'))
                return -1;
            if (StringUtils.endsWith(b, '/xvm_battle_epicbattle.swf'))
                return 1;
            if (StringUtils.endsWith(a, '/xvm_battle_epicrandom.swf'))
                return -1;
            if (StringUtils.endsWith(b, '/xvm_battle_epicrandom.swf'))
                return 1;
            if (StringUtils.endsWith(a, '/xvm_battle_ranked.swf'))
                return -1;
            if (StringUtils.endsWith(b, '/xvm_battle_ranked.swf'))
                return 1;
            if (StringUtils.endsWith(a, '/xvm_battle_royale.swf'))
                return -1;
            if (StringUtils.endsWith(b, '/xvm_battle_royale.swf'))
                return 1;
            return a < b ? -1 : a > b ? 1 : 0;
        }

        private function onLibLoaded(e:LibraryLoaderEvent):void
        {
            try
            {
                Logger.add("[XFW/XfwComponent] onLibLoaded: " + e.url);

                var swf:String = e.url.replace(/^.*\//, '');
                _loadedUISWFs[swf] = e.loader ? XfwConst.SWF_LOADED : XfwConst.SWF_LOAD_ERROR;

                var fixedUrl:String = (e.url.search(/mods\//) >= 0 ? "../../" : "") + e.url;

                if (modsList == null || modsList.length == 0 || modsList.indexOf(fixedUrl) < 0)
                {
                    if (StringUtils.endsWith(swf.toLowerCase(), '_ui.swf'))
                        Xfw.cmd(XfwConst.XFW_COMMAND_SWF_LOADED, swf);
                    return;
                }
                Xfw.cmd(XfwConst.XFW_COMMAND_SWF_LOADED, swf);
                loadedList.push(swf);

                if (e.loader)
                {
                    this.addChild(e.loader);
                }

                Logger.add("[XFW/XfwComponent] onLibLoaded: Mod " + (e.loader ? "loaded" : "load failed") + ": " + swf);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function checkLoadComplete():void
        {
            //Logger.add("checkLoadComplete: " + modsList);
            var modsLen:int = modsList.length;

            if (modsLen > loadedList.length && ((new Date()).getTime() - loadStartTime) < SWF_LOAD_TIMEOUT)
            {
                App.utils.scheduler.scheduleOnNextFrame(checkLoadComplete);
            }
            else
            {
                if (modsLen > loadedList.length)
                {
                    // there was a timeout
                    for (var i:int = 0; i < modsLen; ++i)
                    {
                        var x:String = modsList[i].replace(/^.*\//, '');
                        if (loadedList.indexOf(x) < 0)
                        {
                            _loadedUISWFs[x] = XfwConst.SWF_LOAD_ERROR;
                            Logger.add("[XFW/XfwComponent] checkLoadComplete: WARNING: mod is not loaded: " + x);
                        }
                    }
                }
                finishInit();
            }
        }

        private function finishInit():void
        {
            Xfw.cmd(XfwConst.XFW_COMMAND_INITIALIZED);
            //XfwUtils.logChilds(stage);
        }
    }
}
