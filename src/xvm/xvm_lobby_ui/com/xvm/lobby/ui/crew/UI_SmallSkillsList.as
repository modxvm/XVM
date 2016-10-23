/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.crew
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.gui.lobby.components.data.*;

    public /*dynamic*/ class UI_SmallSkillsList extends SmallSkillsListUI
    {
        public function UI_SmallSkillsList()
        {
            //Logger.add("UI_SmallSkillsList");
            super();
        }

        override public function updateSkills(data:BaseTankmanVO):void
        {
            MAX_RENDER_SKILLS = Config.config.hangar.crewMaxPerksCount + 1;
            super.updateSkills(data);
            skills.width = this.lastSkillLevel.x - skills.x;
            MAX_RENDER_SKILLS = 5;
        }
    }
}
