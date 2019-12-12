package net.wg.gui.ny.cmpnts
{
    public class NYCraftSettingsBlock extends NySliderBlock
    {

        public var tab_1:NYSliderTab = null;

        public var tab_2:NYSliderTab = null;

        public var tab_3:NYSliderTab = null;

        public var tab_4:NYSliderTab = null;

        public var tab_5:NYSliderTab = null;

        public function NYCraftSettingsBlock()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.tab_1.imageIdle.source = RES_ICONS.MAPS_ICONS_NEW_YEAR_CRAFTMACHINE_ICONS_LEVELS_RANDOM;
            this.tab_2.imageIdle.source = RES_ICONS.MAPS_ICONS_NEW_YEAR_CRAFTMACHINE_ICONS_SETTINGS_NEWYEAR;
            this.tab_3.imageIdle.source = RES_ICONS.MAPS_ICONS_NEW_YEAR_CRAFTMACHINE_ICONS_SETTINGS_CHRISTMAS;
            this.tab_4.imageIdle.source = RES_ICONS.MAPS_ICONS_NEW_YEAR_CRAFTMACHINE_ICONS_SETTINGS_FAIRYTALE;
            this.tab_5.imageIdle.source = RES_ICONS.MAPS_ICONS_NEW_YEAR_CRAFTMACHINE_ICONS_SETTINGS_ORIENTAL;
            this.tab_1.imageSelect.source = RES_ICONS.MAPS_ICONS_NEW_YEAR_CRAFTMACHINE_ICONS_LEVELS_RANDOM_ACTIVE;
            this.tab_2.imageSelect.source = RES_ICONS.MAPS_ICONS_NEW_YEAR_CRAFTMACHINE_ICONS_SETTINGS_NEWYEAR_ACTIVE;
            this.tab_3.imageSelect.source = RES_ICONS.MAPS_ICONS_NEW_YEAR_CRAFTMACHINE_ICONS_SETTINGS_CHRISTMAS_ACTIVE;
            this.tab_4.imageSelect.source = RES_ICONS.MAPS_ICONS_NEW_YEAR_CRAFTMACHINE_ICONS_SETTINGS_FAIRYTALE_ACTIVE;
            this.tab_5.imageSelect.source = RES_ICONS.MAPS_ICONS_NEW_YEAR_CRAFTMACHINE_ICONS_SETTINGS_ORIENTAL_ACTIVE;
            tabs.addButton(this.tab_1);
            tabs.addButton(this.tab_2);
            tabs.addButton(this.tab_3);
            tabs.addButton(this.tab_4);
            tabs.addButton(this.tab_5);
        }

        override protected function onDispose() : void
        {
            this.tab_1.dispose();
            this.tab_1 = null;
            this.tab_2.dispose();
            this.tab_2 = null;
            this.tab_3.dispose();
            this.tab_3 = null;
            this.tab_4.dispose();
            this.tab_4 = null;
            this.tab_5.dispose();
            this.tab_5 = null;
            super.onDispose();
        }
    }
}
