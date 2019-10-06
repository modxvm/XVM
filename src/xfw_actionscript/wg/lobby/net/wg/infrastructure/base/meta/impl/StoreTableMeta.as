package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.VO.StoreTableVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class StoreTableMeta extends BaseDAAPIComponent
    {

        public var refreshStoreTableDataProvider:Function;

        private var _storeTableVO:StoreTableVO;

        public function StoreTableMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._storeTableVO)
            {
                this._storeTableVO.dispose();
                this._storeTableVO = null;
            }
            super.onDispose();
        }

        public function refreshStoreTableDataProviderS() : void
        {
            App.utils.asserter.assertNotNull(this.refreshStoreTableDataProvider,"refreshStoreTableDataProvider" + Errors.CANT_NULL);
            this.refreshStoreTableDataProvider();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:StoreTableVO = this._storeTableVO;
            this._storeTableVO = new StoreTableVO(param1);
            this.setData(this._storeTableVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:StoreTableVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
