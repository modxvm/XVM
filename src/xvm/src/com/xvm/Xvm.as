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
    import flash.display.*;
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

        // public commands
        private static const XPM_COMMAND_LOADFILE:String = "xpm.loadFile";

        // static methods for Python-Flash communication

        public static function cmd(cmd:String, ...rest):*
        {
            App.utils.asserter.assertNotNull(_instance, "Xvm" + Errors.CANT_NULL);
            rest.unshift(cmd);
            return _instance.xvm_cmdS.apply(_instance, rest);
        }

        public static var _instance:Xvm;

        // private fields

        private var modsList:Vector.<String>;
        private var loadedCount:Number;
        private var loadStart:Number;

        // initialization

        public function Xvm():void
        {
            _instance = this;
            focusable = false;
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
            dispatchEvent(new ObjectEvent(Defines.E_CMD_RECEIVED, x));
        }

        // overrides

        override protected function onPopulate():void
        {
            //Logger.add("onPopulate");
            super.onPopulate();

            VehicleInfo.populateData();
            Config.load(this, onConfigLoaded);
        }

        override protected function nextFrameAfterPopulateHandler():void
        {
            //Logger.add("nextFrameAfterPopulateHandler");
            if (this.parent != App.instance)
                (App.instance as MovieClip).addChild(this);
        }

        private function onConfigLoaded():void
        {
            LoadMods();
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
                    "nodesLib.swf",                 // xvm-treeview
                    "TankCarousel.swf",             // xvm-tcarousel
                    "serviceMessageComponents.swf", // xvm-svcmsg
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
                loadedCount = 0;
                loadStart = (new Date()).getTime();
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
                loadedCount++;
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

            if (modsList.length > loadedCount && ((new Date()).getTime() - loadStart) < 5000)
            {
                App.utils.scheduler.envokeInNextFrame(checkLoadComplete);
                return;
            }
            cmd(_XPM_COMMAND_INITIALIZED);
        }
    }
}
