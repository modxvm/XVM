/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.teamBasesPanel
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.teamBasesPanel.*;
    import net.wg.gui.battle.views.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class TeamBasesPanelXvmView extends XvmViewBase
    {
        public function TeamBasesPanelXvmView(view:IView)
        {
            super(view);
        }

        public function get battlePage():BaseBattlePage
        {
            return super.view as BaseBattlePage;
        }

        public function get battlePageTeamBasesPanelUI():TeamBasesPanel
        {
            try
            {
                return battlePage["teamBasesPanelUI"];
            }
            catch (ex:Error)
            {
            }
            return null;
        }

        public function set battlePageTeamBasesPanelUI(value:TeamBasesPanel):void
        {
            try
            {
                battlePage["teamBasesPanelUI"] = value;
            }
            catch (ex:Error)
            {
            }
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            super.onAfterPopulate(e);
            init();
        }

        // PRIVATE

        private function init():void
        {
            //page.unregisterComponent(BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL);
            var idx:int = battlePage.getChildIndex(battlePageTeamBasesPanelUI);
            battlePage.removeChild(battlePageTeamBasesPanelUI);
            var component:UI_teamBasesPanel = new UI_teamBasesPanel();
            component.x = battlePageTeamBasesPanelUI.x;
            component.y = battlePageTeamBasesPanelUI.y;
            component.visible = battlePageTeamBasesPanelUI.visible;
            battlePageTeamBasesPanelUI = component;
            battlePage.addChildAt(battlePageTeamBasesPanelUI, idx);
            battlePage.xfw_registerComponent(battlePageTeamBasesPanelUI, BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL);
        }
    }
}
