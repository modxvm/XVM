/**
 * XVM - battle resultes
 * @author Pavel Máca
 */
package xvm.battleresults
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.*;
    import net.wg.gui.lobby.battleResults.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import xvm.battleresults.components.*;

    public class BattleResultsXvmView extends XvmViewBase
    {
        private static const UI_COMMON_STATS:String = "xvm.battleresults_ui::UI_CommonStats";

        public function BattleResultsXvmView(view:IView)
        {
            super(view);
        }

        public function get page():net.wg.gui.lobby.battleResults.BattleResults
        {
            return super.view as net.wg.gui.lobby.battleResults.BattleResults;
        }

        override public function onAfterPopulate(e:LifeCycleEvent):void
        {
            page.tabs_mc.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChange);

            Config.networkServicesSettings = new NetworkServicesSettings(Xfw.cmd(XvmCommands.GET_SVC_SETTINGS));
        }

        private function onTabIndexChange(e:IndexEvent):void
        {
            page.tabs_mc.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChange);

            var dp:Array = page.tabs_mc.dataProvider as Array;
            dp[0]["linkage"] = UI_COMMON_STATS;
            page.tabs_mc.dataProvider = new DataProvider(dp);
            page.tabs_mc.selectedIndex = -1;

            // set startPage
            var startPage:Number = Config.config.battleResults.startPage - 1;

            if (page.tabs_mc.dataProvider[startPage] != null)
            {
                page.tabs_mc.selectedIndex = startPage;
            }
            else
            {
                page.tabs_mc.selectedIndex = 0;
                Logger.add("battleResults: startPage \"" + startPage + "\" is out of range.");
            }

            // display win chance
            new WinChances(page); // Winning chance info above players list.
        }
    }
}
