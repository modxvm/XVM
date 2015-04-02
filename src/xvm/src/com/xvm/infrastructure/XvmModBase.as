/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.infrastructure
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.components.containers.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.managers.impl.*;

    public class XvmModBase extends Sprite implements IXvmMod
    {
        // IXvmMod

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

        /**
         * This .ctor() must be private. Please, do not override it.
         */
        public function XvmModBase()
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
                    addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function _onConfigLoaded(e:Event):void
        {
            dispatchEvent(e);
        }

        private function _onAddedToStage(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
            init();
        }

        private function init():void
        {
            try
            {
                Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, this._onConfigLoaded);
                this.entryPoint();
                this.postInit();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function postInit():void
        {
            // view can be already loaded
            var mgr:ContainerManager = App.containerMgr as ContainerManager;
            for each (var c:IManagedContainer in mgr.containersMap)
            {
                var vc:MainViewContainer = c as MainViewContainer;
                if (vc != null)
                {
                    var n:int = vc.numChildren;
                    for (var i:int = 0; i < n; ++i)
                    {
                        var view:IView = vc.getChildAt(i) as IView;
                        if (view != null)
                            processView(view, true);
                    }
                }
            }

            App.containerMgr.loader.addEventListener(LoaderEvent.VIEW_LOADED, onViewLoaded);
        }

        private function onViewLoaded(e:LoaderEvent):void
        {
            processView(e.view, false);
        }

        private function processView(view:IView, populated:Boolean):void
        {
            //Logger.add("processView: " + view.as_alias);
            try
            {
                if (views == null)
                    return;

                if (view == null)
                    return;

                var alias:String = view.as_alias;
                if (!views.hasOwnProperty(alias))
                    return;

                Logger.add(logPrefix + " processView: " + alias);

                var cls:Class = views[alias] as Class;
                if (cls == null)
                    return;

                var mod:IXvmView = new cls(view);
                if (mod != null)
                {
                    addEventListener(Defines.XVM_EVENT_CONFIG_LOADED,
                        function(e:Event):void { Utils.safeCall(mod, mod.onConfigLoaded, [e]); });
                    if (populated)
                    {
                        mod.onBeforePopulate(null);
                        mod.onAfterPopulate(null);
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
