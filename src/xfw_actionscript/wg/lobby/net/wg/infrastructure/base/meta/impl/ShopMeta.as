package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.store.StoreComponent;
    import net.wg.data.constants.Errors;

    public class ShopMeta extends StoreComponent
    {

        public var buyItem:Function;

        public function ShopMeta()
        {
            super();
        }

        public function buyItemS(param1:String, param2:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.buyItem,"buyItem" + Errors.CANT_NULL);
            this.buyItem(param1,param2);
        }
    }
}
