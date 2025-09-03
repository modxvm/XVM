/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.epicrandom.playersPanel
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.epicRandom.views.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;

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

            var bsdController:BattleStatisticDataController = XfwAccess.getPrivateField(page, 'battleStatisticDataController')
            var cController:Vector.<IBattleComponentDataController> = XfwAccess.getPrivateField(bsdController, '_componentControllers');
            cController.splice(cController.indexOf(page.epicRandomPlayersPanel), 1);

            var idx:int = page.getChildIndex(page.epicRandomPlayersPanel);
            page.removeChild(page.epicRandomPlayersPanel);
            var component:UI_EpicRandomPlayersPanel = new UI_EpicRandomPlayersPanel();
            component.x = page.epicRandomPlayersPanel.x;
            component.y = page.epicRandomPlayersPanel.y;
            component.visible = page.epicRandomPlayersPanel.visible;
            page.epicRandomPlayersPanel = component;
            page.addChildAt(page.epicRandomPlayersPanel, idx);
            bsdController.registerComponentController(page.epicRandomPlayersPanel);
            XfwAccess.getPrivateField(page, 'registerComponent')(page.epicRandomPlayersPanel, BATTLE_VIEW_ALIASES.PLAYERS_PANEL);
        }
    }
}
