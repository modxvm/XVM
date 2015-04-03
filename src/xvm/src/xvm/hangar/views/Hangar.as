/**
 * XVM - hangar
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.hangar.views
{
    import com.xfw.*;
    import com.xfw.io.*;
    import com.xvm.infrastructure.*;
    import flash.external.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.hangar.components.TankParams.*;

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
        }

        // PRIVATE

        private function initVehicleParams():void
        {
            ExternalInterface.addCallback(Cmd.RESPOND_UPDATECURRENTVEHICLE, onUpdateCurrentVehicle);
        }

        private function onUpdateCurrentVehicle(json_str:String):void
        {
            try
            {
                var data:Object = JSONx.parse(json_str);
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
        }
    }
}
