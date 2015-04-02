/**
 * XVM Entry Point
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    XvmLinks;

    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.types.*;
    import com.xvm.utils.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.app.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.managers.*;

    [SWF(width="1", height="1", backgroundColor="#6D6178")]

    public class Xvm extends AbstractView
    {
        // private commands
        private static const _XFW_COMMAND_GETMODS:String = "xfw.getMods";
        private static const _XFW_COMMAND_INITIALIZED:String = "xfw.initialized";

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
            addEventListener(Defines.XFW_EVENT_CMD_RECEIVED, handleXfwCommand);
        }

        // DAAPI Python-Flash interface

        public var xvm_cmd:Function = null;
        public function xvm_cmdS(cmd:String, ...rest):*
        {
            App.utils.asserter.assertNotNull(this.xvm_cmd, "xvm_cmd" + Errors.CANT_NULL);
            rest.unshift(cmd);
            return this.xvm_cmd.apply(this, rest);
        }

        public function as_xvm_cmd(cmd:*, ...rest):*
        {
            //Logger.add("as_xvm_cmd: " + cmd + " " + rest.join(", "));

            try
            {
                switch (cmd)
                {
                    case Defines.XFW_AS_COMMAND_L10N:
                        return Locale.get(rest[0]);

                    default:
                        var e:XfwCmdReceivedEvent = new XfwCmdReceivedEvent(cmd, rest);
                        dispatchEvent(e);
                        return e.retValue;
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
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
                modsList = Vector.<String>(cmd(_XFW_COMMAND_GETMODS));
                if (modsList == null || modsList.length == 0)
                    return;

                App.instance.loaderMgr.addEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);

                // preload swfs
                // TODO: make configurable dependencies
                App.instance.loaderMgr.loadLibraries(Vector.<String>([
                    "contactsListPopover.swf",      // xvm_comments
                    "contactsTreeComponents.swf",   // xvm_comments
                    "messengerControls.swf",        // xvm_comments
                    "serviceMessageComponents.swf", // xvm_svcmsg
                    "TankCarousel.swf",             // xvm_tcarousel
                    "nodesLib.swf",                 // xvm_treeview
                    "profileStatistics.swf",        // xvm_profile
                    "profileTechnique.swf",         // xvm_profile
                    "squadWindow.swf",              // xvm_squad
                    "prebattleComponents.swf",      // xvm_company
                    "companiesListWindow.swf",      // xvm_company
                    "companyWindow.swf",            // xvm_company
                    "battleResults.swf",            // xvm_hangar
                    "battleLoading.swf",            // xvm_hangar
                    "questsTileChainsView.swf"      // xvm_quests
                ]));

                // load xvm mods
                loadStart = (new Date()).getTime();
                loadedList = new Vector.<String>;
                modsList = modsList.map(function(x:String):String { return Defines.WOT_ROOT + x; } );
                App.instance.loaderMgr.loadLibraries(modsList);
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
                cmd(_XFW_COMMAND_INITIALIZED);
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

        private function handleXfwCommand(e:XfwCmdReceivedEvent):void
        {
            //Logger.add("handleXfwCommand: " + e.result.cmd);
            try
            {
                switch (e.cmd)
                {
                    case Defines.XFW_AS_COMMAND_RELOAD_CONFIG:
                        e.stopImmediatePropagation();
                        Logger.add("reload config");
                        Config.load();
                        var message:String = Locale.get("XVM config reloaded");
                        var type:String = "Information";
                        if (Config.stateInfo.warning != null)
                        {
                            message = Locale.get("Config file xvm.xc was not found, using the built-in config");
                            type = "Warning";
                        }
                        else if (Config.stateInfo.error != null)
                        {
                            message = Locale.get("Error loading XVM config") + ":\n" + Utils.encodeHtmlEntities(Config.stateInfo.error);
                            type = "Error";
                        }
                        Xvm.cmd(Defines.XFW_COMMAND_SYSMESSAGE, message, type);
                        Xvm.cmd(_XFW_COMMAND_INITIALIZED);
                        break;

                    case Defines.XVM_AS_COMMAND_SET_SVC_SETTINGS:
                        e.stopImmediatePropagation();
                        Config.networkServicesSettings = new NetworkServicesSettings(e.args[0]);
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
