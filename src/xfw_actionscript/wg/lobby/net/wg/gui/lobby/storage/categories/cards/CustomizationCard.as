package net.wg.gui.lobby.storage.categories.cards
{
    public class CustomizationCard extends BaseCard
    {

        public function CustomizationCard()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            sellButton.label = STORAGE.BUTTONLABEL_PREVIEW;
        }
    }
}
