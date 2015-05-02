/**
 * XVM - login layout
 * @author Mr.A
 */
package xvm.loginlayout
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.gui.events.*;
    import net.wg.gui.login.impl.*;
    import net.wg.gui.login.impl.views.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class LoginLayoutXvmView extends XvmViewBase
    {
        public function LoginLayoutXvmView(view:IView)
        {
            super(view);
        }

        public function get page():LoginPage
        {
            return super.view as LoginPage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            page.viewStackLoginForm.addEventListener(ViewStackEvent.VIEW_CHANGED, onViewChanged);
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            page.viewStackLoginForm.removeEventListener(ViewStackEvent.VIEW_CHANGED, onViewChanged);
        }

        // PRIVATE

        private function onViewChanged(e:ViewStackEvent):void
        {
            var form:SimpleForm = e.view as SimpleForm;
            if (form == null || form.login == null || form.pass == null)
                return;
            form.login.textField.restrict = "a-z A-Z 0-9 _ \\- @ .";
            form.pass.textField.restrict = "a-z A-Z 0-9 _";
        }
    }
}
