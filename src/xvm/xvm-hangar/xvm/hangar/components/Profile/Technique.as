package xvm.hangar.components.Profile
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.lobby.profile.pages.summary.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.io.*;
    import com.xvm.types.cfg.*;
    import xvm.UI.profileSections.UI_TechniqueRenderer;

    public class Technique extends Sprite
    {
        private var page:ProfileTechnique;
        private var summary:ProfileSummary;

        public function Technique(page:ProfileTechnique, summary:ProfileSummary):void
        {
            this.page = page;
            this.summary = summary;

            page.listComponent.lowerShadow.visible = false;
            page.listComponent.techniqueList.itemRenderer = UI_TechniqueRenderer;
            page.listComponent.techniqueList.addEventListener(TechniqueList.SELECTED_DATA_CHANGED, selectedDataChangeHandler, false, 0, true);
        }

        // PRIVATE

        private function selectedDataChangeHandler(e:Event):void
        {
            //Logger.add("selectedDataChangeHandler");
        }
    }
}
