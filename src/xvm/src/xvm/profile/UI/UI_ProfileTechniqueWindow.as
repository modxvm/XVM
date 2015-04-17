/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile.UI
{
    import com.xfw.*;
    import com.xvm.types.dossier.*;
    import net.wg.gui.components.windows.*;
    import net.wg.gui.lobby.window.*;
    import xvm.profile.components.*;

    public dynamic class UI_ProfileTechniqueWindow extends ProfileTechniqueWindow_UI
    {
        //private const WINDOW_EXTRA_WIDTH:int = 45;
        //private const WINDOW_EXTRA_HEIGHT:int = 35;

        private var technique:Technique;

        public function UI_ProfileTechniqueWindow()
        {
            //Logger.add("UI_ProfileTechniqueWindow");
            super();
        }

        override protected function configUI():void
        {
            super.configUI();
            /*
            try
            {
                // resize window
                var pw:ProfileWindow = view as ProfileWindow;
                if (pw != null)
                {
                    if (Config.config.userInfo.showExtraDataInProfile)
                    {
                        pw.btnAddToFriends.y += WINDOW_EXTRA_HEIGHT;
                        pw.btnAddToIgnore.y += WINDOW_EXTRA_HEIGHT;
                        pw.btnCreatePrivateChannel.y += WINDOW_EXTRA_HEIGHT;
                        pw.background.width += WINDOW_EXTRA_WIDTH;
                        pw.background.height += WINDOW_EXTRA_HEIGHT;
                        pw.setSize(pw.width + WINDOW_EXTRA_WIDTH, pw.height + WINDOW_EXTRA_HEIGHT);
                        App.utils.scheduler.envokeInNextFrame(function():void
                        {
                            var co:int = ProfileConstants.WINDOW_CENTER_OFFSET + WINDOW_EXTRA_WIDTH / 2;
                            pw.tabNavigator.centerOffset = co;
                            var sw:ProfileSummaryWindow = pw.tabNavigator.viewStack.currentView as ProfileSummaryWindow;
                            if (sw != null)
                                sw.centerOffset = co;
                        });
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            */
        }

        override protected function onPopulate():void
        {
            super.onPopulate();

            var profileWindow:ProfileWindow = this.dropTarget.parent.parent as ProfileWindow;
            if (profileWindow == null)
            {
                Logger.add("WARNING: [UI_ProfileTechniqueWindow] Cannot find ProfileWindow");
                return;
            }

            // get player name from window title
            var playerName:String = WGUtils.GetPlayerName((profileWindow.window as Window).title);

            // get player id from the view name.
            var playerId:int = parseInt(profileWindow.as_name.replace("profileWindow_", ""));

            technique = new TechniqueWindow(this, playerName, playerId)
            addChild(technique);
        }

        public function as_responseVehicleDossierXvm(data:Object):void
        {
            if(_baseDisposed)
                return;
            try
            {
                technique.as_responseVehicleDossierXvm(new VehicleDossier(data));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
