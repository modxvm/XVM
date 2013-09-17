/**
 * AutoLogin XVM mod
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.intro.IntroPage;
    import net.wg.gui.login.impl.LoginPage;
    import net.wg.infrastructure.managers.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.gui.components.common.*;
    import net.wg.infrastructure.events.*;
    import com.xvm.*;
    import scaleform.clik.events.ButtonEvent;

    public class XVMAutoLogin extends Sprite
    {
        private var sent:Boolean;

        public function XVMAutoLogin():void
        {
            //Logger.add("XVMAutoLogin: .ctor() stage=" + String(stage));
            try
            {
                sent = false;
                if (stage)
                {
                    init();
                }
                else
                {
                    addEventListener(Event.ADDED_TO_STAGE, init);
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function init(e:Event = null):void
        {
            //Logger.add("XVMAutoLogin: init()");
            removeEventListener(Event.ADDED_TO_STAGE, init);

            // entry point

            try
            {
                // view can be already loaded
                var mgr:ContainerManager = App.containerMgr as ContainerManager;
                for each (var c:IManagedContainer in mgr.containersMap)
                {
                    var vc:MainViewContainer = c as MainViewContainer;
                    if (vc != null)
                    {
                        for (var i:int = 0; i < vc.numChildren; ++i)
                        {
                            var v:IView = vc.getChildAt(i) as IView;
                            if (v != null)
                                processView(v, true);
                        }
                    }
                }
                App.containerMgr.loader.addEventListener(LoaderEvent.VIEW_LOADED, onViewLoaded);
            }
            catch (e:*)
            {
                Logger.add(e.getStackTrace());
            }
        }

        private function onViewLoaded(e:LoaderEvent):void
        {
            processView(e.view);
        }

        private function processView(view:IView, populated:Boolean = false):void
        {
            //Logger.add("Process view: " + view.as_alias);
            try
            {
                switch (view.as_alias)
                {
                    case "introVideo":
                        if (Config.config.login.skipIntro == true)
                            skipIntroVideo(view as IntroPage);
                        break;

                    case "login":
                        if (Config.config.login.autologin == true)
                            autoLogin(view as LoginPage);
                        break;

                    case "lobby":
                        sent = true;
                        break;
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function skipIntroVideo(intro:IntroPage):void
        {
            intro.videoPlayer.stopPlayback();
        }

        private function autoLogin(page:LoginPage):void
        {
            //Logger.add("draw: sent=" + sent);
            if (sent)
                return;
            sent = true;

            App.utils.scheduler.envokeInNextFrame(function():void
                { page.form.submit.dispatchEvent(new ButtonEvent(ButtonEvent.CLICK)); });
        }
    }
}
