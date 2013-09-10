/**
 * XVM - login page
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package testmod.xvm
{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.utils.*;
    import net.wg.gui.login.impl.LoginPage;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.infrastructure.base.meta.ILoginPageMeta
    import net.wg.infrastructure.events.LifeCycleEvent;
    import com.xvm.Logger;
    import com.xvm.Defines;

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
            //Logger.addObject("onAfterPopulate: " + view.as_alias);
            setTimeout(setVersion, 1);
        }

        public override function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforeDispose: " + view.as_alias);
        }

        // PRIVATE

        private function setVersion():void
        {
            page.version.appendText("   XVM testmod " + Defines.XVM_VERSION);
        }
    }

}
