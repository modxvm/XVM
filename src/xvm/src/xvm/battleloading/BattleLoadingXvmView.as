/**
 * XVM - login page
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.hangar
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.*;
    import net.wg.gui.lobby.battleloading.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.hangar.battleLoading.components.*;

    public class BattleLoadingXvmView extends XvmViewBase
    {
        public function BattleLoadingXvmView(view:IView)
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

            Config.networkServicesSettings = new NetworkServicesSettings(Xfw.cmd(XvmCommands.GET_SVC_SETTINGS));

            logBriefConfigurationInfo();

            waitInit();
        }

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
                "                               XVM_VERSION=" + Config.config.__xvmVersion + " for WoT " + Config.config.__wotVersion +"\n" +
                "                               gameRegion=" + Config.config.region + "\n" +
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
                Logger.err(ex);
            }
        }

        private function initRenderers():void
        {
            page.form.team1List.validateNow();
            page.form.team2List.validateNow();
            page.form.team1List.itemRendererName = "xvm.hangar_ui.battleLoading::UI_LeftItemRenderer";
            page.form.team2List.itemRendererName = "xvm.hangar_ui.battleLoading::UI_RightItemRenderer";
            App.utils.scheduler.envokeInNextFrame(function():void
            {
                page.form.team1List.itemRendererName = "xvm.hangar_ui.battleLoading::UI_LeftItemRenderer";
                page.form.team2List.itemRendererName = "xvm.hangar_ui.battleLoading::UI_RightItemRenderer";
            });
        }
    }
}
