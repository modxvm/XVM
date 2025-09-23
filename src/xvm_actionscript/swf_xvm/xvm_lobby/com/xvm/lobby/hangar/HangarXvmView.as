/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.hangar
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.lobby.*;
    import com.xvm.lobby.events.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    CLIENT::WG {
        import net.wg.data.constants.generated.*;
        import net.wg.gui.lobby.*;
        import net.wg.infrastructure.managers.impl.*;
    }
    CLIENT::LESTA {
        import net.wg.gui.lobby.hangar.*;
    }

    public class HangarXvmView extends XvmViewBase
    {
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

            Xfw.addCommandListener(XvmCommands.AS_UPDATE_CURRENT_VEHICLE, onUpdateCurrentVehicle);

            CLIENT::WG {
                Xfw.addCommandListener(LobbyCommands.AS_UPDATE_HANGAR_STATE, onUpdateHangarState);
            }

            CLIENT::LESTA {
                // fix bottomBg height and position - original is too high and affects carousel
                page.bottomBg.height = 47; // MESSENGER_BAR_PADDING + 2
                page.bottomBg.y = App.appHeight - 90; // MESSENGER_BAR_PADDING * 2

                Xvm.dispatchEvent(new HangarStateEvent(HangarStateEvent.ON_CHANGED, true));
            }
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            super.onBeforeDispose(e);

            // This method is called twice on config reload
            if (_disposed)
                return;
            _disposed = true;

            Xfw.removeCommandListener(XvmCommands.AS_UPDATE_CURRENT_VEHICLE, onUpdateCurrentVehicle);

            CLIENT::WG {
                Xfw.removeCommandListener(LobbyCommands.AS_UPDATE_HANGAR_STATE, onUpdateHangarState);
            }

            CLIENT::LESTA {
                //Logger.add("ON_HANGAR_BEFORE_DISPOSE");
                Xvm.dispatchEvent(new HangarStateEvent(HangarStateEvent.ON_CHANGED, false));
            }
        }

        // PRIVATE

        private function setup():void
        {
        }

        CLIENT::WG {
            private function onUpdateHangarState(isHangar:Boolean, isEvent:Boolean):Object
            {
                Xvm.dispatchEvent(new HangarStateEvent(HangarStateEvent.ON_CHANGED, isHangar, isEvent));
                return null;
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
