package net.wg.gui.lobby.eventPlayerPackTrade.components
{
    import flash.display.Sprite;

    public class EventVehiclePanel extends EventItemsPanel
    {

        private static const ITEM1_OFFSET:int = 75;

        private static const ITEM2_OFFSET:int = 250;

        private static const ICON_OFFSET:int = 15;

        public var icon1:Sprite = null;

        public var icon2:Sprite = null;

        public function EventVehiclePanel()
        {
            super();
        }

        override public final function dispose() : void
        {
            this.icon1 = null;
            this.icon2 = null;
            super.dispose();
        }

        public function layoutElements() : void
        {
            description1TF.x = ITEM1_OFFSET - (description1TF.textWidth + this.icon1.width >> 1) + ICON_OFFSET;
            this.icon1.x = description1TF.x + description1TF.textWidth - ICON_OFFSET;
            description2TF.x = ITEM2_OFFSET - (description2TF.textWidth + this.icon2.width >> 1) + ICON_OFFSET;
            this.icon2.x = description2TF.x + description2TF.textWidth - ICON_OFFSET;
        }

        override protected function getItem1Offset() : int
        {
            return ITEM1_OFFSET;
        }

        override protected function getItem2Offset() : int
        {
            return ITEM2_OFFSET;
        }
    }
}
