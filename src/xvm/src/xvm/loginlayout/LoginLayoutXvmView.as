/**
 * XVM - login layout
 * @author Mr.A
 */
package xvm.loginlayout
{
    import com.xvm.infrastructure.*;
    import net.wg.gui.components.controls.TextInput;
    import net.wg.gui.login.impl.LoginPage;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import net.wg.infrastructure.interfaces.IView;

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
            initLoginLayout();
        }

        // PRIVATE

        private function initLoginLayout():void
        {
            var login:TextInput = page.form.login as TextInput;
            var pass:TextInput = page.form.pass as TextInput;
            if (!login || !pass)
                return;

            login.textField.restrict = "a-z A-Z 0-9 _ \\- @ .";
            pass.textField.restrict = "a-z A-Z 0-9 _";
        }
    }
}
