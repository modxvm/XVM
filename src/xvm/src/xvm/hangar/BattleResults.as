/**
 * XVM - battle resultes
 * @author Pavel Máca
 */
package xvm.hangar
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.battleResults.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.events.*;
    import xvm.hangar.battleResults.components.*;

    public class BattleResults extends XvmViewBase
    {
        public function BattleResults(view:IView)
        {
            super(view);
        }

        public function get page():net.wg.gui.lobby.battleResults.BattleResults
        {
            return super.view as net.wg.gui.lobby.battleResults.BattleResults;
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            page.view_mc.addEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewChanged);
            page.tabs_mc.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChange);

            Config.networkServicesSettings = new NetworkServicesSettings(Xfw.cmd(XvmCommands.GET_SVC_SETTINGS));
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            page.view_mc.removeEventListener(ViewStackEvent.VIEW_CHANGED, this.onViewChanged);
        }

        private var processedViews:Array = [];

        private function onViewChanged(e:ViewStackEvent):void
        {
            try
            {
                if (processedViews.indexOf(e.linkage) != -1)
                {
                    // TODO: better fix for multiple modding one view
                    return;
                }

                // tabs: CommonStats, TeamStats, DetailsStats
                //Logger.add("View loaded: battleResults." + e.linkage);
                switch (e.linkage)
                {
                    case "CommonStats":
                        CommonView.init(e.view as CommonStats);
                        break;
                }

                processedViews.push(e.linkage);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function onTabIndexChange(e:IndexEvent):void
        {
            page.tabs_mc.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChange);

            // set startPage
            var startPage:Number = Config.config.battleResults.startPage - 1;

            if (page.tabs_mc.dataProvider[startPage] != null)
                page.tabs_mc.selectedIndex = startPage;
            else
                Logger.add("battleResults: startPage \"" + startPage + "\" is out of range.");

            // display win chance
            new WinChances(page); // Winning chance info above players list.
        }
    }
}
