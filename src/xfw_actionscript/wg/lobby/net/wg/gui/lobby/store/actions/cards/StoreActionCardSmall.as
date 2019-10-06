package net.wg.gui.lobby.store.actions.cards
{
    import net.wg.data.constants.generated.TEXT_ALIGN;

    public class StoreActionCardSmall extends StoreActionCardBase
    {

        public function StoreActionCardSmall()
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
            header.y = getPermanentHeight() - header.height >> 1;
            super.updateHeaderAnimStartPosition(param1);
        }

        override protected function initAnimStartState() : void
        {
            descr.alpha = 0;
            super.initAnimStartState();
        }

        override protected function getIsSetDescr() : Boolean
        {
            return false;
        }
    }
}
