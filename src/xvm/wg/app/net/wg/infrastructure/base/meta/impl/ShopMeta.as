package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.store.*;
    
    public class ShopMeta extends net.wg.gui.lobby.store.Store
    {
        public function ShopMeta()
        {
            super();
            return;
        }

        public function buyItemS(arg1:net.wg.data.VO.StoreTableData):void
        {
            App.utils.asserter.assertNotNull(this.buyItem, "buyItem" + net.wg.data.constants.Errors.CANT_NULL);
            this.buyItem(arg1);
            return;
        }

        public var buyItem:Function=null;
    }
}
