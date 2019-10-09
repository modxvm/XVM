/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 * @author Pavel Máca
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.battleresults
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

    public class BattleResultsXvmView extends XvmViewBase
    {
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
            super.onAfterPopulate(e);
            page.tabs_mc.addEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChange, false, 0, true);
            Config.setNetworkServicesSettings(new NetworkServicesSettings(Xfw.cmd(XvmCommands.GET_SVC_SETTINGS)));
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            super.onBeforeDispose(e);
        }

        private function onTabIndexChange(e:IndexEvent):void
        {
            page.tabs_mc.removeEventListener(IndexEvent.INDEX_CHANGE, this.onTabIndexChange);

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
        }
    }
}
