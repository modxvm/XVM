package xvm.UI.profileSections
{
    import net.wg.data.gui_items.dossier.*;
    import xvm.hangar.components.Profile.TechniqueStatisticTab;

    public dynamic class UI_TechniqueStatisticTab extends TechniqueStatisticTab_UI
    {
        private var worker:TechniqueStatisticTab;

        public function UI_TechniqueStatisticTab()
        {
            super();
            worker = new TechniqueStatisticTab(this);
        }

        override protected function configUI():void
        {
            super.configUI();
            worker.configUI();
        }

        override public function update(arg1:Object):void
        {
            super.update(arg1);
            worker.update(arg1 as VehicleDossier);
        }
    }
}
