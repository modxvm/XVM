/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw.infrastructure
{
    import com.xfw.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.components.containers.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.managers.impl.*;

    public class XfwModBase extends Sprite implements IXfwMod
    {
        // IXfwMod

        public virtual function get logPrefix():String
        {
            return this.toString();
        }

        public virtual function get views():Object
        {
            return null;
        }

        public virtual function entryPoint():void
        {
            // empty
        }

        // PRIVATE

        public function XfwModBase()
        {
            //Logger.add(getQualifiedClassName(this));
            try
            {
                if (stage != null)
                {
                    init();
                }
                else
                {
                    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function onAddedToStage(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            init();
        }

        protected function init():void
        {
            try
            {
                this.entryPoint();
                this.postInit();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function postInit():void
        {
            // view can be already loaded
            var mgr:ContainerManagerBase = App.containerMgr as ContainerManagerBase;
            for each (var c:ISimpleManagedContainer in mgr.containersMap)
            {
                var vc:MainViewContainer = c as MainViewContainer;
                if (vc != null)
                {
                    var n:int = vc.numChildren;
                    for (var i:int = 0; i < n; ++i)
                    {
                        var view:IView = vc.getChildAt(i) as IView;
                        if (view != null)
                            processView(view, view.isDAAPIInited);
                    }
                }
            }

            mgr.loader.addEventListener(LoaderEvent.VIEW_LOADED, onViewLoaded);
        }

        private function onViewLoaded(e:LoaderEvent):void
        {
            processView(e.view, false);
        }

        protected function processView(view:IView, populated:Boolean):Vector.<IXfwView>
        {
            //Logger.add("processView: " + view.as_config.alias);
            try
            {
                if (views == null)
                    return null;

                if (view == null)
                    return null;

                var alias:String = view.as_config.alias;
                if (!(alias in views))
                    return null;

                Logger.add(logPrefix + " processView: " + alias);

                var mods_classes:Array = views[alias] as Array;
                if (mods_classes == null || mods_classes.length == 0)
                    return null;

                var mods:Vector.<IXfwView> = new Vector.<IXfwView>();

                var modsClassesLen:int = mods_classes.length;
                for (var i:int = 0; i < modsClassesLen; ++i)
                {
                    try
                    {
                        var mod_class:Class = mods_classes[i] as Class;
                        var mod:IXfwView = new mod_class(view);
                        if (mod != null)
                        {
                            if (populated)
                            {
                                mod.onBeforePopulate(null);
                                mod.onAfterPopulate(null);
                            }
                            mods.push(mod);
                        }
                    }
                    catch (ex:Error)
                    {
                        Logger.err(ex);
                    }
                }

                return mods;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return null;
        }
    }
}
