package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.gui.lobby.boosters.data.BoostersWindowVO;
    import net.wg.gui.lobby.boosters.data.BoostersWindowStaticVO;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.boosters.data.BoostersTableRendererVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class BoostersWindowMeta extends AbstractWindowView
    {

        public var requestBoostersArray:Function;

        public var onBoosterActionBtnClick:Function;

        public var onFiltersChange:Function;

        public var onResetFilters:Function;

        private var _boostersWindowVO:BoostersWindowVO;

        private var _boostersWindowStaticVO:BoostersWindowStaticVO;

        private var _dataProviderBoostersTableRendererVO:DataProvider;

        public function BoostersWindowMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            var _loc1_:BoostersTableRendererVO = null;
            if(this._boostersWindowVO)
            {
                this._boostersWindowVO.dispose();
                this._boostersWindowVO = null;
            }
            if(this._boostersWindowStaticVO)
            {
                this._boostersWindowStaticVO.dispose();
                this._boostersWindowStaticVO = null;
            }
            if(this._dataProviderBoostersTableRendererVO)
            {
                for each(_loc1_ in this._dataProviderBoostersTableRendererVO)
                {
                    _loc1_.dispose();
                }
                this._dataProviderBoostersTableRendererVO.cleanUp();
                this._dataProviderBoostersTableRendererVO = null;
            }
            super.onDispose();
        }

        public function requestBoostersArrayS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.requestBoostersArray,"requestBoostersArray" + Errors.CANT_NULL);
            this.requestBoostersArray(param1);
        }

        public function onBoosterActionBtnClickS(param1:Number, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.onBoosterActionBtnClick,"onBoosterActionBtnClick" + Errors.CANT_NULL);
            this.onBoosterActionBtnClick(param1,param2);
        }

        public function onFiltersChangeS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onFiltersChange,"onFiltersChange" + Errors.CANT_NULL);
            this.onFiltersChange(param1);
        }

        public function onResetFiltersS() : void
        {
            App.utils.asserter.assertNotNull(this.onResetFilters,"onResetFilters" + Errors.CANT_NULL);
            this.onResetFilters();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:BoostersWindowVO = this._boostersWindowVO;
            this._boostersWindowVO = new BoostersWindowVO(param1);
            this.setData(this._boostersWindowVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setStaticData(param1:Object) : void
        {
            var _loc2_:BoostersWindowStaticVO = this._boostersWindowStaticVO;
            this._boostersWindowStaticVO = new BoostersWindowStaticVO(param1);
            this.setStaticData(this._boostersWindowStaticVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setListData(param1:Array, param2:Boolean) : void
        {
            var _loc6_:BoostersTableRendererVO = null;
            var _loc3_:DataProvider = this._dataProviderBoostersTableRendererVO;
            this._dataProviderBoostersTableRendererVO = new DataProvider();
            var _loc4_:uint = param1.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                this._dataProviderBoostersTableRendererVO[_loc5_] = new BoostersTableRendererVO(param1[_loc5_]);
                _loc5_++;
            }
            this.setListData(this._dataProviderBoostersTableRendererVO,param2);
            if(_loc3_)
            {
                for each(_loc6_ in _loc3_)
                {
                    _loc6_.dispose();
                }
                _loc3_.cleanUp();
            }
        }

        protected function setData(param1:BoostersWindowVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setStaticData(param1:BoostersWindowStaticVO) : void
        {
            var _loc2_:String = "as_setStaticData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setListData(param1:DataProvider, param2:Boolean) : void
        {
            var _loc3_:String = "as_setListData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc3_);
            throw new AbstractException(_loc3_);
        }
    }
}
