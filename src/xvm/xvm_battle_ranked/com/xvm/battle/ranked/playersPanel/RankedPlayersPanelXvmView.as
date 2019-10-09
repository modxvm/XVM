/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.ranked.playersPanel
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.ranked.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class RankedPlayersPanelXvmView extends XvmViewBase
    {
        public function RankedPlayersPanelXvmView(view:IView)
        {
            super(view);
        }

        public function get page():RankedBattlePage
        {
            return super.view as RankedBattlePage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);
            init();
        }

        // PRIVATE

        private function init():void
        {
            page.unregisterComponent(BATTLE_VIEW_ALIASES.PLAYERS_PANEL);
            page.xfw_battleStatisticDataController.xfw_componentControllers.splice(page.xfw_battleStatisticDataController.xfw_componentControllers.indexOf(page.playersPanel), 1);
            var idx:int = page.getChildIndex(page.playersPanel);
            page.removeChild(page.playersPanel);
            var component:UI_RankedPlayersPanel = new UI_RankedPlayersPanel();
            component.x = page.playersPanel.x;
            component.y = page.playersPanel.y;
            component.visible = page.playersPanel.visible;
            page.playersPanel = component;
            page.addChildAt(page.playersPanel, idx);
            page.xfw_battleStatisticDataController.registerComponentController(page.playersPanel);
            page.xfw_registerComponent(page.playersPanel, BATTLE_VIEW_ALIASES.PLAYERS_PANEL);
        }
    }
}
