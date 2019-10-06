package net.wg.gui.lobby.store.actions.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class StoreActionsViewVo extends DAAPIDataClass
    {

        private static const CARDS_FILED:String = "cards";

        private static const EMPTY_FILED:String = "empty";

        public var title:String = "";

        public var cards:StoreActionsCardsVo = null;

        public var empty:StoreActionsEmptyVo = null;

        public function StoreActionsViewVo(param1:Object = null)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == CARDS_FILED)
            {
                if(param2)
                {
                    this.cards = new StoreActionsCardsVo(param2);
                }
                return false;
            }
            if(param1 == EMPTY_FILED)
            {
                if(param2)
                {
                    this.empty = new StoreActionsEmptyVo(param2);
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.cards)
            {
                this.cards.dispose();
                this.cards = null;
            }
            if(this.empty)
            {
                this.empty.dispose();
                this.empty = null;
            }
            super.onDispose();
        }
    }
}
