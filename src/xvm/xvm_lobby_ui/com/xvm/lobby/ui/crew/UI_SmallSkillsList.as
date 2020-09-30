/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.crew
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.gui.lobby.components.data.*;

    public class UI_SmallSkillsList extends SmallSkillsListUI
    {
        public function UI_SmallSkillsList()
        {
            Logger.add("UI_SmallSkillsList");
            super();
            Logger.add("UI_SmallSkillsList -- end");
        }

        override public function updateSkills(data:BaseTankmanVO):void
        {
            Logger.add("UI_SmallSkillsList::updateSkills -- begin");
            MAX_RENDER_SKILLS = Config.config.hangar.crewMaxPerksCount + 1;
            super.updateSkills(data);
            skills.width = (skills.columnWidth + skills.paddingRight) * skills.dataProvider.length;
            MAX_RENDER_SKILLS = 5;
            Logger.add("UI_SmallSkillsList::updateSkills -- end");
        }
    }
}
