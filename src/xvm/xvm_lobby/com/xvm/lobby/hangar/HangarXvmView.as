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
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class HangarXvmView extends XvmViewBase
    {
        public function HangarXvmView(view:IView)
        {
            super(view);
        }

        public function get page():net.wg.gui.lobby.hangar.Hangar
        {
            return super.view as net.wg.gui.lobby.hangar.Hangar;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);
            //Logger.addObject(page);

            // fix bottomBg height - original is too high and affects carousel
            page.bottomBg.height = 45; // MESSENGER_BAR_PADDING

            initVehicleParams();
            initServerInfo();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
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

        // server info

        private function initServerInfo():void
        {
            var cfg:CHangarServerInfo = Config.config.hangar.serverInfo;
            if (!cfg.enabled)
            {
                // TODO:0.9.16
                //page.serverInfo.alpha = page.serverInfoBg.alpha = 0;
                //page.serverInfo.mouseEnabled = page.serverInfoBg.mouseEnabled = false;
                //page.serverInfo.mouseChildren = page.serverInfoBg.mouseChildren = false;
            }
            else
            {
                // TODO:0.9.16
                //page.serverInfo.y += cfg.shiftY;
                //page.serverInfoBg.y += cfg.shiftY;
                //page.serverInfo.alpha = page.serverInfoBg.alpha = cfg.alpha / 100.0;
                //page.serverInfo.rotation = page.serverInfoBg.rotation = cfg.rotation;
            }
        }
    }
}
