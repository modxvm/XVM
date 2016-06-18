/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.teamBasesPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.teamBasesPanel.UI_teamBasesPanel;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.*;

    public class TeamBasesPanelXvmView extends XvmViewBase
    {
        public function TeamBasesPanelXvmView(view:IView)
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
            App.utils.scheduler.scheduleOnNextFrame(init);
        }

        // PRIVATE

        private function init():void
        {
            //page.unregisterComponent(BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL);
            page.removeChild(page.teamBasesPanelUI);
            var tbp:UI_teamBasesPanel = new UI_teamBasesPanel();
            tbp.x = page.teamBasesPanelUI.x;
            tbp.y = page.teamBasesPanelUI.y;
            page.teamBasesPanelUI = tbp;
            page.addChild(page.teamBasesPanelUI);
            page.xfw_registerComponent(page.teamBasesPanelUI, BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL);
        }
    }
}
