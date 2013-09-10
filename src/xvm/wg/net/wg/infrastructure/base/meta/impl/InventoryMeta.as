package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.store.*;
    
    public class InventoryMeta extends net.wg.gui.lobby.store.Store
    {
        public function InventoryMeta()
        {
            super();
            return;
        }

        public function sellItemS(arg1:net.wg.data.VO.StoreTableData):void
        {
            App.utils.asserter.assertNotNull(this.sellItem, "sellItem" + net.wg.data.constants.Errors.CANT_NULL);
            this.sellItem(arg1);
            return;
        }

        public var sellItem:Function=null;
    }
}
