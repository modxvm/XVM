/**
 * XVM - login page
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.hangar.views
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.utils.*;
    import net.wg.gui.login.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

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
            page.version.appendText("   XVM " + Config.config.__xvmVersion + " (WoT " + Config.config.__wotVersion + ")");
        }
    }

}
