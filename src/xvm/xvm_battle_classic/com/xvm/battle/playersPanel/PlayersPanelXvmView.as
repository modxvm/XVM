/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.battle.playersPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.*;

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
            page.xfw_battleStatisticDataController.componentControllers.splice(page.xfw_battleStatisticDataController.componentControllers.indexOf(page.playersPanel), 1);
            var idx:int = page.getChildIndex(page.playersPanel);
            page.removeChild(page.playersPanel);
            var component:UI_PlayersPanel = new UI_PlayersPanel();
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
