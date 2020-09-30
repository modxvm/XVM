/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.crew
{
    import com.xfw.*;

    public class UI_CrewItemRenderer extends CrewItemRendererUI
    {
        private var orig_skills_x:int = 0;
        private var orig_skills_y:int = 0;

        public function UI_CrewItemRenderer()
        {
            Logger.add("UI_CrewItemRenderer");
            super();

            orig_skills_x = skills.x;
            orig_skills_y = skills.y;

            CrewItemRendererHelper.init(this, orig_skills_x, orig_skills_y);
            Logger.add("UI_CrewItemRenderer -- end");
        }

        override protected function updateAfterStateChange():void
        {
            Logger.add("UI_CrewItemRenderer::updateAfterStateChange --begin");
            super.updateAfterStateChange();
            CrewItemRendererHelper.init(this, orig_skills_x, orig_skills_y);
        }
    }
}
