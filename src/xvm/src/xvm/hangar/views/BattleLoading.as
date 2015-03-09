/**
 * XVM - login page
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.hangar.views
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.io.*;
    import com.xvm.types.*;
    import com.xvm.utils.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.*;
    import net.wg.gui.lobby.battleloading.*;
    import xvm.hangar.components.BattleLoading.*;
    import xvm.hangar.UI.battleLoading.*;

    public class BattleLoading extends XvmViewBase
    {
        //private static const CMD_XVM_COMMENTS_GET_COMMENTS:String = "xvm_comments.get_comments";

        public function BattleLoading(view:IView)
        {
            super(view);
        }

        public function get page():net.wg.gui.lobby.battleloading.BattleLoading
        {
            return super.view as net.wg.gui.lobby.battleloading.BattleLoading;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);

            Config.networkServicesSettings = new NetworkServicesSettings(Xvm.cmd(Defines.XVM_COMMAND_GET_SVC_SETTINGS));

            logBriefConfigurationInfo();

            //updateComments();

            waitInit();
        }

        // TODO: load comments only for players in the current battle
        /*
        private function updateComments():void
        {
            try
            {
                var json_str:String = Xvm.cmd(CMD_XVM_COMMENTS_GET_COMMENTS);
                //Logger.addObject(json_str);
                var o:Object = JSONx.parse(json_str);
                var comments:Object = (o != null && o.hasOwnProperty("players")) ? o.players : null;
                //Logger.addObject(comments);
                Macros.RegisterCommentsData(comments);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }
        */

        private function waitInit():void
        {
            if (!page.initialized)
            {
                App.utils.scheduler.envokeInNextFrame(waitInit);
                return;
            }

            init();
        }

        public override function onBeforeDispose(e:LifeCycleEvent):void
        {
            //Logger.add("onBeforeDispose: " + view.as_alias);
        }

        // PRIVATE

        private function logBriefConfigurationInfo():void
        {
            Logger.add(
                "[BattleLoading]\n" +
                "                               XVM_VERSION=" + Defines.XVM_VERSION + " for WoT " + Defines.WOT_VERSION +"\n" +
                "                               gameRegion=" + Config.gameRegion + "\n" +
                "                               configVersion=" + Config.config.configVersion + "\n" +
                "                               autoReloadConfig=" + Config.config.autoReloadConfig + "\n" +
                "                               useStandardMarkers=" + Config.config.markers.useStandardMarkers + "\n" +
                "                               servicesActive=" + Config.networkServicesSettings.servicesActive + "\n" +
                "                               statBattle=" + Config.networkServicesSettings.statBattle);
        }

        private function init():void
        {
            try
            {
                initRenderers();

                // Components
                new WinChances(page); // Winning chance info above players list.
                new TipField(page);   // Information field below players list.
                new Clock(page);  // Realworld time at right side of TipField.
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function initRenderers():void
        {
            page.form.team1List.validateNow();
            page.form.team2List.validateNow();
            page.form.team1List.itemRenderer = UI_LeftItemRenderer;
            page.form.team2List.itemRenderer = UI_RightItemRenderer;
            App.utils.scheduler.envokeInNextFrame(function():void
            {
                page.form.team1List.itemRenderer = UI_LeftItemRenderer;
                page.form.team2List.itemRenderer = UI_RightItemRenderer;
            });
        }
    }
}
