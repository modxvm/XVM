/**
 * XVM - hangar
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.hangar.views
{
    import com.xvm.*;
    import com.xvm.io.*;
    import com.xvm.infrastructure.*;
    import flash.events.*;
    import flash.external.*;
    import flash.utils.*;
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
            page.params.list.itemRenderer = TankParamItemRenderer;
            App.stage.addEventListener(Cmd.RESPOND_UPDATECURRENTVEHICLE, onUpdateCurrentVehicle);
        }

        private function onUpdateCurrentVehicle(event:Event):void
        {
            VehicleParams.updateVehicleParams(page.params);
            App.utils.scheduler.envokeInNextFrame(function():void
            {
                VehicleParams.updateVehicleParams(page.params);
            });
        }
    }

}
