/**
 * XVM - login page
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.hangar.views
{
    import com.xvm.*;
    import com.xvm.io.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.utils.*;
    import net.wg.gui.login.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.hangar.*;

    public class Login extends XvmViewBase
    {
        public function Login(view:IView)
        {
            super(view);
        }

        public function get page():LoginPage
        {
            return super.view as LoginPage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.addObject("onAfterPopulate: " + view.as_alias);
            setTimeout(setVersion, 1);

            ExternalInterface.addCallback(Cmd.RESPOND_UPDATECURRENTVEHICLE, onUpdateCurrentVehicle);

            // ------------------ DEBUG ------------------
            //var mc = main.createEmptyMovieClip("widgetsHolder", main.getNextHighestDepth());
            //WidgetsFactory.initialize(mc, "sirmax2",
            //    [ com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog.DEFAULT_WIDGET_SETTINGS ]);
            //var wsd = new com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog(main, "sirmax2");
            // ------------------ DEBUG ------------------
        }

        public override function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforeDispose: " + view.as_alias);
        }

        // PRIVATE

        private function setVersion():void
        {
            page.version.appendText("   XVM " + Defines.XVM_VERSION + " (WoT " + Defines.WOT_VERSION + ")");
        }

        private function onUpdateCurrentVehicle(json_str:String, cnt:Number = 0):void
        {
            try
            {
                if (cnt > 60)
                    return;

                var stage:Stage = App.stage;
                var ok:Boolean = stage.hasEventListener(Cmd.RESPOND_UPDATECURRENTVEHICLE);
                //Logger.add("c=" + cnt + " ok=" + ok);
                if (!ok)
                {
                    App.utils.scheduler.scheduleTask(function():void { onUpdateCurrentVehicle(json_str, cnt + 1); }, 1000);
                    return;
                }

                var data:Object = JSONx.parse(json_str);
                for (var n:String in data)
                    Config.config.minimap.circles._internal[n] = data[n];

                stage.dispatchEvent(new Event(Cmd.RESPOND_UPDATECURRENTVEHICLE));
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }
    }

}
