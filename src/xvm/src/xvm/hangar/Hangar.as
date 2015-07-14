/**
 * XVM - hangar
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.hangar
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.hangar.components.*;

    public class Hangar extends XvmViewBase
    {
        public function Hangar(view:IView)
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

            initVehicleParams();
            initServerInfo();
        }

        // PRIVATE

        private function initVehicleParams():void
        {
            Xfw.addCommandListener(XvmCommands.AS_UPDATE_CURRENT_VEHICLE, onUpdateCurrentVehicle);
        }

        // TODO: try without serialization
        private function onUpdateCurrentVehicle(json_str:String):Object
        {
            try
            {
                var data:Object = JSONx.parse(json_str);
                if (!Config.config.minimap.circles._internal)
                    Config.config.minimap.circles._internal = new CMinimapCirclesInternal();
                for (var n:String in data)
                    Config.config.minimap.circles._internal[n] = data[n];

                VehicleParams.updateVehicleParams(page.params);
                App.utils.scheduler.envokeInNextFrame(function():void
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
            page.serverInfo.visible = page.serverInfoBg.visible = cfg.enabled;
            page.serverInfo.alpha = page.serverInfoBg.alpha = cfg.alpha / 100.0;
            page.serverInfo.rotation = page.serverInfoBg.rotation = cfg.rotation;
        }
    }
}
