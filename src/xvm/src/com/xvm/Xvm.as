/**
 * XVM Entry Point
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm
{
    XvmLinks;

    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.io.*;
    import com.xvm.types.*;
    import com.xvm.utils.*;
    import flash.display.*;
    import flash.events.Event;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.helpers.*;

    [SWF(width="1", height="1", backgroundColor="#6D6178")]

    public class Xvm extends AbstractView
    {
        // private commands
        private static const _XPM_COMMAND_GETMODS:String = "xpm.getMods";
        private static const _XPM_COMMAND_INITIALIZED:String = "xpm.initialized";

        // static methods for Python-Flash communication

        public static function cmd(cmd:String, ...rest):*
        {
            App.utils.asserter.assertNotNull(_instance, "Xvm" + Errors.CANT_NULL);
            rest.unshift(cmd);
            return _instance.xvm_cmdS.apply(_instance, rest);
        }

        public static function addEventListener(type:String, listener:Function):void
        {
            _instance.addEventListener(type, listener);
        }

        public static function removeEventListener(type:String, listener:Function):void
        {
            _instance.removeEventListener(type, listener);
        }

        public static function dispatchEvent(e:Event):void
        {
            _instance.dispatchEvent(e);
        }

        public static var _instance:Xvm;

        // private fields

        private var modsList:Vector.<String>;
        private var loadedList:Vector.<String>;
        private var loadStart:Number;

        // initialization

        public function Xvm():void
        {
            _instance = this;
            focusable = false;
            addEventListener(Defines.XPM_EVENT_CMD_RECEIVED, handleXpmCommand);
        }

        // DAAPI Python-Flash interface

        public var xvm_cmd:Function = null;
        public function xvm_cmdS(cmd:String, ...rest):*
        {
            App.utils.asserter.assertNotNull(this.xvm_cmd, "xvm_cmd" + Errors.CANT_NULL);
            rest.unshift(cmd);
            return this.xvm_cmd.apply(this, rest);
        }

        public function as_xvm_cmd(cmd:*, ...rest):void
        {
            //Logger.add("as_xvm_cmd: " + cmd + " " + rest.join(", "));
            dispatchEvent(new ObjectEvent(Defines.XPM_EVENT_CMD_RECEIVED, { cmd: cmd, args: rest }));
        }

        // overrides

        override protected function onPopulate():void
        {
            //Logger.add("onPopulate");
            super.onPopulate();

            Config.load();
            LoadMods();
        }

        override protected function nextFrameAfterPopulateHandler():void
        {
            //Logger.add("nextFrameAfterPopulateHandler");
            if (this.parent != App.instance)
                (App.instance as MovieClip).addChild(this);
        }

        private function LoadMods():void
        {
            try
            {
                modsList = Vector.<String>(cmd(_XPM_COMMAND_GETMODS));
                if (modsList == null || modsList.length == 0)
                    return;

                (App.libraryLoader as LibraryLoader).addEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);

                // preload swfs
                App.libraryLoader.load(Vector.<String>([ // TODO make configurable dependencies
                    "contactsWindow.swf",           // xvm-comments
                    "serviceMessageComponents.swf", // xvm-svcmsg
                    "TankCarousel.swf",             // xvm-tcarousel
                    "nodesLib.swf",                 // xvm-treeview
                    "profileStatistics.swf",        // xvm-profile
                    "profileTechnique.swf",         // xvm-profile
                    "squadWindow.swf",              // xvm-squad
                    "prebattleComponents.swf",      // xvm-company
                    "companiesListWindow.swf",      // xvm-company
                    "companyWindow.swf",            // xvm-company
                    "battleResults.swf",            // xvm-hangar
                    "battleLoading.swf"             // xvm-hangar
                ]));

                // load xvm mods
                loadStart = (new Date()).getTime();
                loadedList = new Vector.<String>;
                modsList = modsList.map(function(x:String):String { return Defines.XVMMODS_ROOT + x.replace(/^.*\//, ''); } );
                App.libraryLoader.load(modsList);
                checkLoadComplete();
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function onLibLoaded(e:LibraryLoaderEvent):void
        {
            try
            {
                if (modsList.indexOf(e.url.replace(/^gui\/flash\//i, '')) < 0)
                    return;
                loadedList.push(e.url.replace(/^.*\//, ''));
                Logger.add("[XVM] Mod " + (e.loader == null ? "load failed" : "loaded") + ": " + e.url.replace(/^.*\//, ''));
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function checkLoadComplete():void
        {
            //Logger.add("checkLoadComplete");

            if (modsList.length > loadedList.length && ((new Date()).getTime() - loadStart) < 5000)
            {
                App.utils.scheduler.envokeInNextFrame(checkLoadComplete);
            }
            else
            {
                cmd(_XPM_COMMAND_INITIALIZED);
                if (modsList.length > loadedList.length)
                {
                    for (var i:int = 0; i < modsList.length; ++i)
                    {
                        var x:String = modsList[i].replace(/^.*\//, '');
                        if (loadedList.indexOf(x) < 0)
                            Logger.add("WARNING: mod is not loaded: " + x);
                    }
                }
            }
        }

        private function handleXpmCommand(e:ObjectEvent):void
        {
            //Logger.add("handleXpmCommand: " + e.result.cmd);
            try
            {
                switch (e.result.cmd)
                {
                    case Defines.XVM_AS_COMMAND_SET_SVC_SETTINGS:
                        Config.networkServicesSettings = new NetworkServicesSettings(e.result.args[0]);
                        break;
                    case Defines.XPM_AS_COMMAND_RELOAD_CONFIG:
                        Logger.add("reload config");
                        Config.load();
                        var message:String = Locale.get("XVM config reloaded");
                        var type:String = "Information";
                        if (Config.stateInfo.warning != null)
                        {
                            message = Locale.get("xvm.xc was not found, using the built-in config");
                            type = "Warning";
                        }
                        else if (Config.stateInfo.error != null)
                        {
                            message = Locale.get("Error loading XVM config") + ":\n" + Utils.encodeHtmlEntities(Config.stateInfo.error);
                            type = "Error";
                        }
                        Xvm.cmd(Defines.XPM_COMMAND_SYSMESSAGE, message, type);
                        break;
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }
    }
}
