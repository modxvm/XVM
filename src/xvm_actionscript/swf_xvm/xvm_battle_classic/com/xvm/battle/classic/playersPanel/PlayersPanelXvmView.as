/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.classic.playersPanel
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.*;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;

    public class PlayersPanelXvmView extends XvmViewBase
    {
        public function PlayersPanelXvmView(view:IView)
        {
            super(view);
        }

        public function get page():BattlePage
        {
            return super.view as BattlePage;
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
            cController.splice(cController.indexOf(page.playersPanel), 1);

            var idx:int = page.getChildIndex(page.playersPanel);
            page.removeChild(page.playersPanel);
            var component:UI_PlayersPanel = new UI_PlayersPanel();
            component.x = page.playersPanel.x;
            component.y = page.playersPanel.y;
            component.visible = page.playersPanel.visible;
            page.playersPanel = component;
            page.addChildAt(page.playersPanel, idx);

            bsdController.registerComponentController(page.playersPanel);
            XfwAccess.getPrivateField(page, 'registerComponent')(page.playersPanel, BATTLE_VIEW_ALIASES.PLAYERS_PANEL);
        }
    }
}
