/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.epicrandom.teamBasesPanel
{
    import com.xfw.*;
    import com.xvm.battle.shared.teamBasesPanel.UI_teamBasesPanel;
    import com.xvm.infrastructure.*;
    import flash.events.Event;
    import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
    import net.wg.gui.battle.epicRandom.views.EpicRandomPage;
    import net.wg.gui.battle.random.views.teamBasesPanel.TeamBasesPanel;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import net.wg.infrastructure.interfaces.IView;

    public class TeamBasesPanelXvmView extends XvmViewBase
    {
        public function TeamBasesPanelXvmView(view:IView)
        {
            super(view);
        }

        public function get battlePage():EpicRandomPage
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
            battlePage.unregisterComponent(BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL);
            var idx:int = battlePage.getChildIndex(battlePage.teamBasesPanelUI);
            battlePage.removeChild(battlePage.teamBasesPanelUI);
            var component:UI_teamBasesPanel = new UI_teamBasesPanel();
            component.x = battlePage.teamBasesPanelUI.x;
            component.y = battlePage.teamBasesPanelUI.y;
            component.visible = battlePage.teamBasesPanelUI.visible;
            battlePage.teamBasesPanelUI = component;
            battlePage.addChildAt(battlePage.teamBasesPanelUI, idx);
            battlePage.xfw_registerComponent(battlePage.teamBasesPanelUI, BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL);
            component.addEventListener(Event.CHANGE, battlePage.xfw_onTeamBasesPanelUIChangeHandler);
        }
    }
}
