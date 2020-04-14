package net.wg.gui.bootcamp.nationsWindow.containers
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.text.TextField;

    public class InfoContainer extends UIComponentEx
    {

        private static const NATIONS:Array = [BOOTCAMP.AWARD_OPTIONS_NAME_US,BOOTCAMP.AWARD_OPTIONS_NAME_GE,BOOTCAMP.AWARD_OPTIONS_NAME_USSR];

        private static const DESCRIPTIONS:Array = [BOOTCAMP.AWARD_OPTIONS_DESCRIPTION_US,BOOTCAMP.AWARD_OPTIONS_DESCRIPTION_GE,BOOTCAMP.AWARD_OPTIONS_DESCRIPTION_USSR];

        public var title:TextField = null;

        public var historicalTitle:TextField = null;

        public var historicReference:TextField = null;

        public function InfoContainer()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.historicalTitle.text = VEHICLE_PREVIEW.INFOPANEL_TAB_ELITEFACTSHEET_INFO;
        }

        override protected function onDispose() : void
        {
            this.title = null;
            this.historicalTitle = null;
            this.historicReference = null;
            super.onDispose();
        }

        public function selectNation(param1:int) : void
        {
            if(NATIONS.length <= param1)
            {
                return;
            }
            this.title.text = NATIONS[param1];
            this.historicReference.text = DESCRIPTIONS[param1];
        }
    }
}
