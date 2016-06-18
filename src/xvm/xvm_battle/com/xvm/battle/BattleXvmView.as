/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.battle.teamBasesPanel.UI_teamBasesPanel;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.battle.random.views.*;

    public class BattleXvmView extends XvmViewBase
    {
        public function BattleXvmView(view:IView)
        {
            super(view);
        }

        public function get page():BattlePage
        {
            return super.view as BattlePage;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            //Logger.add("onAfterPopulate: " + view.as_alias);
            try
            {
                super.onAfterPopulate(e);
                //Logger.addObject(view);

                //page.unregisterComponent(BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL);
                page.removeChild(page.teamBasesPanelUI);
                var tbp:UI_teamBasesPanel = new UI_teamBasesPanel();
                tbp.x = page.teamBasesPanelUI.x;
                tbp.y = page.teamBasesPanelUI.y;
                page.teamBasesPanelUI = tbp;
                page.addChild(page.teamBasesPanelUI);
                page.xfw_registerComponent(page.teamBasesPanelUI, BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

    }
}
