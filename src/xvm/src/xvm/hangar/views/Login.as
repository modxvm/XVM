/**
 * XVM - login page
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.hangar.views
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.login.impl.LoginPage;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.infrastructure.events.LifeCycleEvent;
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
    }

}
