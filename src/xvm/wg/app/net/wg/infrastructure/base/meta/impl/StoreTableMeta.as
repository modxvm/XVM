package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    
    public class StoreTableMeta extends BaseDAAPIComponent
    {
        
        public function StoreTableMeta() {
            super();
        }
        
        public var refreshStoreTableDataProvider:Function = null;
        
        public function refreshStoreTableDataProviderS() : void {
            App.utils.asserter.assertNotNull(this.refreshStoreTableDataProvider,"refreshStoreTableDataProvider" + Errors.CANT_NULL);
            this.refreshStoreTableDataProvider();
        }
    }
}
