/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.epicRandom.views.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class EpicRandomPlayersPanelXvmView extends XvmViewBase
    {
        public function EpicRandomPlayersPanelXvmView(view:IView)
        {
            super(view);
        }

        public function get page():EpicRandomPage
        {
            return super.view as EpicRandomPage;
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
            page.xfw_battleStatisticDataController.componentControllers.splice(page.xfw_battleStatisticDataController.componentControllers.indexOf(page.epicRandomPlayersPanel), 1);
            var idx:int = page.getChildIndex(page.epicRandomPlayersPanel);
            page.removeChild(page.epicRandomPlayersPanel);
            var component:UI_EpicRandomPlayersPanel = new UI_EpicRandomPlayersPanel();
            component.x = page.epicRandomPlayersPanel.x;
            component.y = page.epicRandomPlayersPanel.y;
            component.visible = page.epicRandomPlayersPanel.visible;
            page.epicRandomPlayersPanel = component;
            page.addChildAt(page.epicRandomPlayersPanel, idx);
            page.xfw_battleStatisticDataController.registerComponentController(page.epicRandomPlayersPanel);
            page.xfw_registerComponent(page.epicRandomPlayersPanel, BATTLE_VIEW_ALIASES.PLAYERS_PANEL);
        }
    }
}
