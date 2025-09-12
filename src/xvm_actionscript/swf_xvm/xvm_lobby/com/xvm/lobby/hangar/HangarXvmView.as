/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.hangar
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    CLIENT::WG {
        import net.wg.gui.lobby.*;
        import net.wg.infrastructure.managers.impl.*;
    }
    CLIENT::LESTA {
        import net.wg.gui.lobby.hangar.*;
    }

    public class HangarXvmView extends XvmViewBase
    {
        CLIENT::WG {
            public static const HANGAR_GF_NAME:String = 'mono/hangar/main';
        }
        public static const ON_HANGAR_AFTER_POPULATE:String = 'ON_HANGAR_AFTER_POPULATE';
        public static const ON_HANGAR_BEFORE_DISPOSE:String = 'ON_HANGAR_BEFORE_DISPOSE';

        private var _disposed:Boolean = false;

        public function HangarXvmView(view:IView)
        {
            super(view);
        }

        CLIENT::WG {
            public function get page():LobbyPage
            {
                return super.view as LobbyPage;
            }
        }

        CLIENT::LESTA {
            public function get page():Hangar
            {
                return super.view as Hangar;
            }
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);

            CLIENT::WG {
                var mgr:ContainerManagerBase = App.containerMgr as ContainerManagerBase;
                mgr.addEventListener(ContainerManagerEvent.VIEW_ADDED, onContainerViewLifecycleHandler);
                mgr.addEventListener(ContainerManagerEvent.VIEW_REMOVED, onContainerViewLifecycleHandler);
            }

            CLIENT::LESTA {
                // fix bottomBg height and position - original is too high and affects carousel
                page.bottomBg.height = 47; // MESSENGER_BAR_PADDING + 2
                page.bottomBg.y = App.appHeight - 90; // MESSENGER_BAR_PADDING * 2
            }

            Xfw.addCommandListener(XvmCommands.AS_UPDATE_CURRENT_VEHICLE, onUpdateCurrentVehicle);

            // App.utils.scheduler.scheduleOnNextFrame(function():void {
            //     setup();
            // });

            CLIENT::LESTA {
                Xvm.dispatchEvent(new Event(ON_HANGAR_AFTER_POPULATE));
            }
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            super.onBeforeDispose(e);

            // This method is called twice on config reload
            if (_disposed)
                return;
            _disposed = true;

            CLIENT::WG {
                var mgr:ContainerManagerBase = App.containerMgr as ContainerManagerBase;
                mgr.removeEventListener(ContainerManagerEvent.VIEW_ADDED, onContainerViewLifecycleHandler);
                mgr.removeEventListener(ContainerManagerEvent.VIEW_REMOVED, onContainerViewLifecycleHandler);
            }

            CLIENT::LESTA {
                //Logger.add("ON_HANGAR_BEFORE_DISPOSE");
                Xvm.dispatchEvent(new Event(ON_HANGAR_BEFORE_DISPOSE));
            }

            Xfw.removeCommandListener(XvmCommands.AS_UPDATE_CURRENT_VEHICLE, onUpdateCurrentVehicle);
        }

        // PRIVATE

        private function setup():void
        {
        }

        CLIENT::WG {
            private function onContainerViewLifecycleHandler(event:ContainerManagerEvent): void
            {
                var view:IView = event.view;
                var name:String = XfwUtils.normalizeWulfViewName(view.as_config.name);
                if (name != HANGAR_GF_NAME)
                    return;
                var hangarEventName:String = event.type == ContainerManagerEvent.VIEW_ADDED ? ON_HANGAR_AFTER_POPULATE : ON_HANGAR_BEFORE_DISPOSE;
                Xvm.dispatchEvent(new Event(hangarEventName));
            }
        }

        private function onUpdateCurrentVehicle(vehCD:int, data:Object):Object
        {
            try
            {
                if (!Config.config.minimap.circles._internal)
                    Config.config.minimap.circles._internal = new CMinimapCirclesInternal();
                for (var n:String in data)
                    Config.config.minimap.circles._internal[n] = data[n];

                CLIENT::LESTA {
                    VehicleParams.updateVehicleParams(page.params);
                    App.utils.scheduler.scheduleOnNextFrame(function():void
                    {
                        VehicleParams.updateVehicleParams(page.params);
                    });
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }

            return null;
        }
    }
}
