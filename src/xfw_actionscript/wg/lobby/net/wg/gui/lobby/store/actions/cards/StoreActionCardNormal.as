package net.wg.gui.lobby.store.actions.cards
{
    import net.wg.data.constants.generated.TEXT_ALIGN;

    public class StoreActionCardNormal extends StoreActionCardBase
    {

        private static const HEADER_BOTTOM_MARGIN:Number = 25;

        private static const HEADER_QUEST_BOTTOM_MARGIN:Number = 12;

        public function StoreActionCardNormal()
        {
            super();
        }

        override protected function getBtnAlign(param1:Boolean) : String
        {
            if(param1)
            {
                return TEXT_ALIGN.RIGHT;
            }
            return TEXT_ALIGN.CENTER;
        }

        override protected function updateHeaderAnimStartPosition(param1:Boolean) : void
        {
            var _loc2_:Number = HEADER_BOTTOM_MARGIN;
            if(param1)
            {
                _loc2_ = getPermanentHeight() - battleQuestsBtn.y + HEADER_QUEST_BOTTOM_MARGIN;
            }
            header.y = getPermanentHeight() - header.height - _loc2_ ^ 0;
            super.updateHeaderAnimStartPosition(param1);
        }

        override protected function initAnimStartState() : void
        {
            descr.alpha = 0;
            super.initAnimStartState();
        }

        override protected function getDescriptionVerticalAlign() : String
        {
            return StoreActionDescr.DESCRIPTION_POS_CENTER_WITH_HEADER;
        }
    }
}
