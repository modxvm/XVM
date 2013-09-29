package xvm.UI.profileSections
{
    import com.xvm.*;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import xvm.hangar.components.BattleLoading.*;
    import xvm.hangar.components.Profile.ProfileTechniqueRenderer;

    public class UI_TechniqueRenderer extends TechniqueRenderer_UI
    {
        private var worker:ProfileTechniqueRenderer;

        public function UI_TechniqueRenderer()
        {
            super();
            worker = new ProfileTechniqueRenderer(this);
        }

        override protected function draw():void
        {
            super.draw();
            worker.draw();
        }
    }
}
