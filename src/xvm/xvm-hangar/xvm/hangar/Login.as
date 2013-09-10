/**
 * XVM - login page
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.hangar
{
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.login.impl.LoginPage;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import xvm.hangar.components.PingServers.*;

    public class Login extends XvmModBase
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
            try
            {
                //Logger.addObject("onAfterPopulate: " + view.as_alias);
                setTimeout(setVersion, 1);
                initPing();

                // ------------------ DEBUG ------------------
                //var mc = main.createEmptyMovieClip("widgetsHolder", main.getNextHighestDepth());
                //WidgetsFactory.initialize(mc, "sirmax2",
                //    [ com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog.DEFAULT_WIDGET_SETTINGS ]);
                //var wsd = new com.xvm.Components.Widgets.Settings.WidgetsSettingsDialog(main, "sirmax2");
                // ------------------ DEBUG ------------------
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
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

        private function initPing():void
        {
            var cfg:CPingServers = Config.config.login.pingServers;
            PingServers.initFeature(cfg);
            if (cfg.enabled)
                page.addChild(new PingServersView(cfg));
        }
    }

}
