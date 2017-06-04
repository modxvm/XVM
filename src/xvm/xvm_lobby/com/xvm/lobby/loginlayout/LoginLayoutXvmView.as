/**
 * XVM - login layout
 * @author Mr.A
 */
package com.xvm.lobby.loginlayout
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.gui.events.*;
    import net.wg.gui.login.impl.*;
    import net.wg.gui.login.impl.ev.*;
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
            super.onAfterPopulate(e);
            page.loginViewStack.addEventListener(LoginViewStackEvent.VIEW_CHANGED, onViewChanged, false, 0, true);
            setupForm(page.loginViewStack.currentView as SimpleForm);
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            super.onBeforeDispose(e);
            page.loginViewStack.removeEventListener(LoginViewStackEvent.VIEW_CHANGED, onViewChanged);
        }

        // PRIVATE

        private function onViewChanged(e:LoginViewStackEvent):void
        {
            setupForm(e.view as SimpleForm);
        }

        private function setupForm(form:SimpleForm):void
        {
            if (form && form.login && form.pass)
            {
                form.login.textField.restrict = "a-z A-Z 0-9 _ \\- @ .";
                form.pass.textField.restrict = "a-z A-Z 0-9 _";
            }
        }
    }
}
