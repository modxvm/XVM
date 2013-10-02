package xvm.UI.profileSections
{
    import xvm.hangar.components.Profile.ProfileTechniqueRenderer;

    public dynamic class UI_TechniqueRenderer extends TechniqueRenderer_UI
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
