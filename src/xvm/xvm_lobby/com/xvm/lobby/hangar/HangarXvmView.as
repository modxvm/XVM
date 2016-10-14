/**
 * XVM - hangar
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.hangar
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import com.xvm.lobby.hangar.components.*;
    import flash.events.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class HangarXvmView extends XvmViewBase
    {
        public static const ON_HANGAR_AFTER_POPULATE:String = "ON_HANGAR_AFTER_POPULATE";
        public static const ON_HANGAR_BEFORE_DISPOSE:String = "ON_HANGAR_BEFORE_DISPOSE";

        public function HangarXvmView(view:IView)
        {
            super(view);
        }

        public function get page():Hangar
        {
            return super.view as Hangar;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);
            //Logger.addObject(page);

            // fix bottomBg height - original is too high and affects carousel
            page.bottomBg.height = 45; // MESSENGER_BAR_PADDING

            initVehicleParams();

            //Logger.add("ON_HANGAR_AFTER_POPULATE");
            Xvm.dispatchEvent(new Event(ON_HANGAR_AFTER_POPULATE));
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("ON_HANGAR_BEFORE_DISPOSE");
            Xvm.dispatchEvent(new Event(ON_HANGAR_BEFORE_DISPOSE));
            Xfw.removeCommandListener(XvmCommands.AS_UPDATE_CURRENT_VEHICLE, onUpdateCurrentVehicle);
        }

        // PRIVATE

        private function initVehicleParams():void
        {
            Xfw.addCommandListener(XvmCommands.AS_UPDATE_CURRENT_VEHICLE, onUpdateCurrentVehicle);
        }

        private function onUpdateCurrentVehicle(data:Object):Object
        {
            try
            {
                if (!Config.config.minimap.circles._internal)
                    Config.config.minimap.circles._internal = new CMinimapCirclesInternal();
                for (var n:String in data)
                    Config.config.minimap.circles._internal[n] = data[n];

                VehicleParams.updateVehicleParams(page.params);
                App.utils.scheduler.scheduleOnNextFrame(function():void
                {
                    VehicleParams.updateVehicleParams(page.params);
                });
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }

            return null;
        }
    }
}
