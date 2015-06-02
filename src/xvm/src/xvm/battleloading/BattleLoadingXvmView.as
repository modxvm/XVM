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
        private static const _name:String = "xvm_battleloading";
        private static const _ui_name:String = _name + "_ui.swf";

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

            App.instance.loaderMgr.addEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);

            if (Xfw.try_load_ui_swf(_name, _ui_name) == XfwConst.SWF_ALREADY_LOADED)
                waitInit();
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            if (!Config.networkServicesSettings.statCompany)
                return;

            App.instance.loaderMgr.removeEventListener(LibraryLoaderEvent.LOADED, onLibLoaded);
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

        private function onLibLoaded(e:LibraryLoaderEvent):void
        {
            if (StringUtils.endsWith(e.url.toLowerCase(), _ui_name))
            {
                waitInit();
            }
        }

        private function waitInit():void
        {
            if (!page.initialized)
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
