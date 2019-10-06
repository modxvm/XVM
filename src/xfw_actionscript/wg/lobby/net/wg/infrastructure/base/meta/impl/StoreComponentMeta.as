package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.store.StoreComponentViewBase;
    import net.wg.data.VO.ShopNationFilterDataVo;
    import net.wg.data.VO.ShopSubFilterData;
    import net.wg.gui.lobby.store.data.FiltersDataVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class StoreComponentMeta extends StoreComponentViewBase
    {

        public var requestTableData:Function;

        public var requestFilterData:Function;

        public var onShowInfo:Function;

        public var getName:Function;

        public var onAddVehToCompare:Function;

        private var _array:Array;

        private var _shopNationFilterDataVo:ShopNationFilterDataVo;

        private var _shopSubFilterData:ShopSubFilterData;

        private var _filtersDataVO:FiltersDataVO;

        public function StoreComponentMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._array)
            {
                this._array.splice(0,this._array.length);
                this._array = null;
            }
            if(this._shopNationFilterDataVo)
            {
                this._shopNationFilterDataVo.dispose();
                this._shopNationFilterDataVo = null;
            }
            if(this._shopSubFilterData)
            {
                this._shopSubFilterData.dispose();
                this._shopSubFilterData = null;
            }
            if(this._filtersDataVO)
            {
                this._filtersDataVO.dispose();
                this._filtersDataVO = null;
            }
            super.onDispose();
        }

        public function requestTableDataS(param1:Number, param2:Boolean, param3:String, param4:Object) : void
        {
            App.utils.asserter.assertNotNull(this.requestTableData,"requestTableData" + Errors.CANT_NULL);
            this.requestTableData(param1,param2,param3,param4);
        }

        public function requestFilterDataS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.requestFilterData,"requestFilterData" + Errors.CANT_NULL);
            this.requestFilterData(param1);
        }

        public function onShowInfoS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.onShowInfo,"onShowInfo" + Errors.CANT_NULL);
            this.onShowInfo(param1);
        }

        public function getNameS() : String
        {
            App.utils.asserter.assertNotNull(this.getName,"getName" + Errors.CANT_NULL);
            return this.getName();
        }

        public function onAddVehToCompareS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.onAddVehToCompare,"onAddVehToCompare" + Errors.CANT_NULL);
            this.onAddVehToCompare(param1);
        }

        public final function as_initFiltersData(param1:Array, param2:String) : void
        {
            var _loc3_:Array = this._array;
            this._array = param1;
            this.initFiltersData(this._array,param2);
            if(_loc3_)
            {
                _loc3_.splice(0,_loc3_.length);
            }
        }

        public final function as_setFilterType(param1:Object) : void
        {
            var _loc2_:ShopNationFilterDataVo = this._shopNationFilterDataVo;
            this._shopNationFilterDataVo = new ShopNationFilterDataVo(param1);
            this.setFilterType(this._shopNationFilterDataVo);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setSubFilter(param1:Object) : void
        {
            var _loc2_:ShopSubFilterData = this._shopSubFilterData;
            this._shopSubFilterData = new ShopSubFilterData(param1);
            this.setSubFilter(this._shopSubFilterData);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setFilterOptions(param1:Object) : void
        {
            var _loc2_:FiltersDataVO = this._filtersDataVO;
            this._filtersDataVO = new FiltersDataVO(param1);
            this.setFilterOptions(this._filtersDataVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function initFiltersData(param1:Array, param2:String) : void
        {
            var _loc3_:String = "as_initFiltersData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc3_);
            throw new AbstractException(_loc3_);
        }

        protected function setFilterType(param1:ShopNationFilterDataVo) : void
        {
            var _loc2_:String = "as_setFilterType" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setSubFilter(param1:ShopSubFilterData) : void
        {
            var _loc2_:String = "as_setSubFilter" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setFilterOptions(param1:FiltersDataVO) : void
        {
            var _loc2_:String = "as_setFilterOptions" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
