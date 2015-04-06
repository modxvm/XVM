/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.autologin
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.ui.*;
    import flash.utils.*;
    import net.wg.gui.events.*;
    import net.wg.gui.intro.*;
    import net.wg.gui.login.impl.*;
    import net.wg.gui.login.impl.views.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;

    public class AutoLoginXvmView extends XvmViewBase
    {
        private static var ready:Boolean = false;

        public function AutoLoginXvmView(view:IView)
        {
            super(view);
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            init();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            if (loginPage != null)
                loginPage.viewStackLoginForm.removeEventListener(ViewStackEvent.VIEW_CHANGED, autoLogin);
        }

        // PRIVATE

        private function get loginPage():LoginPage
        {
            return super.view as LoginPage;
        }

        private function init():void
        {
            switch (view.as_alias)
            {
                case "introVideo":
                    ready = true;
                    if (Config.config.login.skipIntro == true)
                        skipIntroVideo(view as IntroPage);
                    break;

                case "login":
                    if (loginPage != null)
                        loginPage.viewStackLoginForm.addEventListener(ViewStackEvent.VIEW_CHANGED, autoLogin);
                    break;

                case "lobby":
                    ready = false;
                    break;
            }
        }

        private function skipIntroVideo(intro:IntroPage):void
        {
            intro.videoPlayer.stopPlayback();
        }

        private function autoLogin(e:ViewStackEvent):void
        {
            if (Config.config.login.autologin != true)
                return;

            if (!ready)
                return;
            ready = false;

            if (e.view is SocialForm)
            {
                doAutologin();
            }
            else
            {
                var form:SimpleForm = e.view as SimpleForm;
                if (form)
                {
                    var $this:AutoLoginXvmView = this;
                    setTimeout(function():void
                    {
                        if (form.rememberPwdCheckbox.selected)
                            $this.doAutologin();
                    }, 300);
                }
            }
        }

        private function doAutologin():void
        {
            var $this:AutoLoginXvmView = this;
            setTimeout(function():void
            {
                if ($this.loginPage != null)
                    $this.loginPage.dispatchEvent(new InputEvent(InputEvent.INPUT, new InputDetails(null, Keyboard.ENTER, InputValue.KEY_DOWN)));
            }, 100);
        }
    }
}
