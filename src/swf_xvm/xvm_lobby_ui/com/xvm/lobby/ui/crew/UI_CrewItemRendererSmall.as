/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.crew
{
    import com.xfw.*;

    public class UI_CrewItemRendererSmall extends CrewItemRendererSmallUI
    {
        private var orig_skills_x:int = 0;
        private var orig_skills_y:int = 0;

        public function UI_CrewItemRendererSmall()
        {
            //Logger.add("UI_CrewItemRendererSmall");
            super();

            orig_skills_x = skills.x;
            orig_skills_y = skills.y;

            CrewItemRendererHelper.init(this, orig_skills_x, orig_skills_y);
        }

        override protected function updateAfterStateChange():void
        {
            super.updateAfterStateChange();
            CrewItemRendererHelper.init(this, orig_skills_x, orig_skills_y);
        }
    }
}
