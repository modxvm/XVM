/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.battleloading
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.*;
    import flash.utils.*;
    import net.wg.gui.lobby.battleloading.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import org.idmedia.as3commons.util.StringUtils;
    import xvm.battleloading.components.*;

    public class BattleLoadingXvmView extends XvmViewBase
    {
        public function BattleLoadingXvmView(view:IView)
        {
            super(view);
        }

        public function get page():BattleLoading
        {
            return super.view as BattleLoading;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);

            Config.networkServicesSettings = new NetworkServicesSettings(Xfw.cmd(XvmCommands.GET_SVC_SETTINGS));

            logBriefConfigurationInfo();

            waitInit();
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

        private function waitInit():void
        {
            if (!page.initialized || App.utils.classFactory.getClass("xvm.battleloading_ui::UI_LeftItemRenderer") == null)
            {
                var $this:* = this;
                setTimeout(function():void { $this.waitInit(); }, 1);
            }
            else
            {
                init();
            }
        }

        private function init():void
        {
            try
            {
                BattleLoadingHelper.InitRenderers(page);

                // Components
                new WinChances(page); // Winning chance info above players list.
                new Clock(page);  // Realworld time at right side of TipField.
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
