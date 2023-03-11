/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.crew
{
    import net.wg.gui.lobby.components.SmallSkillsList;
    import net.wg.gui.lobby.components.data.BaseTankmanVO;
    import com.xfw.XfwAccess;
    import com.xvm.Config;

    public class UI_SmallSkillsList extends SmallSkillsListUI
    {
        public function UI_SmallSkillsList()
        {
            super();
        }

        override public function updateSkills(data:BaseTankmanVO):void
        {
            XfwAccess.setPrivateField(SmallSkillsList, "MAX_RENDER_SKILLS", Config.config.hangar.crewMaxPerksCount + 1);

            super.updateSkills(data);
            skills.width = (skills.columnWidth + skills.paddingRight) * skills.dataProvider.length;

            XfwAccess.setPrivateField(SmallSkillsList, "MAX_RENDER_SKILLS", 5);
        }
    }
}
