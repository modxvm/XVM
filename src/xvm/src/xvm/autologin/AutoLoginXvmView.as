/**
 * XVM - lobby
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.autologin
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.display.Stage;
    import net.wg.gui.components.controls.SoundButton;
    import net.wg.gui.intro.*;
    import net.wg.gui.login.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.UIComponent;
    import scaleform.clik.events.*;

    public class AutoLoginXvmView extends XvmViewBase
    {
        private static var ready:Boolean = false;

        public function AutoLoginXvmView(view:IView)
        {
            super(view);
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            initAutoLogin();
        }

        private function initAutoLogin():void
        {
            switch (view.as_alias)
            {
                case "introVideo":
                    ready = true;
                    if (Config.config.login.skipIntro == true)
                        skipIntroVideo(view as IntroPage);
                    break;

                case "login":
                    if (Config.config.login.autologin == true)
                        autoLogin(view as LoginPage);
                    if (Config.config.login.confirmOldReplays == true)
                        confirmOldReplays(view as LoginPage);
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

        private function autoLogin(page:LoginPage):void
        {
            //Logger.add("draw: sent=" + sent);
            if (!ready)
                return;
            ready = false;

            App.utils.scheduler.envokeInNextFrame(function():void
                { page.form.submit.dispatchEvent(new ButtonEvent(ButtonEvent.CLICK)); });
        }

        private function confirmOldReplays(page:LoginPage):void
        {
            var submit:SoundButton = page.stage.focus as SoundButton;
            if (!submit)
                return;
            if (submit.label != DIALOGS.REPLAYNOTIFICATION_SUBMIT)
                return;
            (page.form as UIComponent).visible = false;
            submit.dispatchEvent(new ButtonEvent(ButtonEvent.CLICK));
        }
    }

}
