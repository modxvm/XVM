package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.InitBuyWindowVO;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.BuyWindowTittlesVO;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchasesTotalVO;
    import net.wg.gui.lobby.vehicleCustomization.data.purchase.CustomizationBuyWindowDataVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class CustomizationBuyWindowMeta extends AbstractView
    {

        public var buy:Function;

        public var close:Function;

        public var selectItem:Function;

        public var deselectItem:Function;

        public var changePriceItem:Function;

        public var applyToTankChanged:Function;

        public var updateAutoProlongation:Function;

        public var onAutoProlongationCheckboxAdded:Function;

        private var _initBuyWindowVO:InitBuyWindowVO;

        private var _buyWindowTittlesVO:BuyWindowTittlesVO;

        private var _purchasesTotalVO:PurchasesTotalVO;

        private var _customizationBuyWindowDataVO:CustomizationBuyWindowDataVO;

        public function CustomizationBuyWindowMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._initBuyWindowVO)
            {
                this._initBuyWindowVO.dispose();
                this._initBuyWindowVO = null;
            }
            if(this._buyWindowTittlesVO)
            {
                this._buyWindowTittlesVO.dispose();
                this._buyWindowTittlesVO = null;
            }
            if(this._purchasesTotalVO)
            {
                this._purchasesTotalVO.dispose();
                this._purchasesTotalVO = null;
            }
            if(this._customizationBuyWindowDataVO)
            {
                this._customizationBuyWindowDataVO.dispose();
                this._customizationBuyWindowDataVO = null;
            }
            super.onDispose();
        }

        public function buyS() : void
        {
            App.utils.asserter.assertNotNull(this.buy,"buy" + Errors.CANT_NULL);
            this.buy();
        }

        public function closeS() : void
        {
            App.utils.asserter.assertNotNull(this.close,"close" + Errors.CANT_NULL);
            this.close();
        }

        public function selectItemS(param1:uint, param2:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.selectItem,"selectItem" + Errors.CANT_NULL);
            this.selectItem(param1,param2);
        }

        public function deselectItemS(param1:uint, param2:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.deselectItem,"deselectItem" + Errors.CANT_NULL);
            this.deselectItem(param1,param2);
        }

        public function changePriceItemS(param1:uint, param2:uint) : void
        {
            App.utils.asserter.assertNotNull(this.changePriceItem,"changePriceItem" + Errors.CANT_NULL);
            this.changePriceItem(param1,param2);
        }

        public function applyToTankChangedS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.applyToTankChanged,"applyToTankChanged" + Errors.CANT_NULL);
            this.applyToTankChanged(param1);
        }

        public function updateAutoProlongationS() : void
        {
            App.utils.asserter.assertNotNull(this.updateAutoProlongation,"updateAutoProlongation" + Errors.CANT_NULL);
            this.updateAutoProlongation();
        }

        public function onAutoProlongationCheckboxAddedS() : void
        {
            App.utils.asserter.assertNotNull(this.onAutoProlongationCheckboxAdded,"onAutoProlongationCheckboxAdded" + Errors.CANT_NULL);
            this.onAutoProlongationCheckboxAdded();
        }

        public final function as_setInitData(param1:Object) : void
        {
            var _loc2_:InitBuyWindowVO = this._initBuyWindowVO;
            this._initBuyWindowVO = new InitBuyWindowVO(param1);
            this.setInitData(this._initBuyWindowVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setTitles(param1:Object) : void
        {
            var _loc2_:BuyWindowTittlesVO = this._buyWindowTittlesVO;
            this._buyWindowTittlesVO = new BuyWindowTittlesVO(param1);
            this.setTitles(this._buyWindowTittlesVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setTotalData(param1:Object) : void
        {
            var _loc2_:PurchasesTotalVO = this._purchasesTotalVO;
            this._purchasesTotalVO = new PurchasesTotalVO(param1);
            this.setTotalData(this._purchasesTotalVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:CustomizationBuyWindowDataVO = this._customizationBuyWindowDataVO;
            this._customizationBuyWindowDataVO = new CustomizationBuyWindowDataVO(param1);
            this.setData(this._customizationBuyWindowDataVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setInitData(param1:InitBuyWindowVO) : void
        {
            var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setTitles(param1:BuyWindowTittlesVO) : void
        {
            var _loc2_:String = "as_setTitles" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setTotalData(param1:PurchasesTotalVO) : void
        {
            var _loc2_:String = "as_setTotalData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setData(param1:CustomizationBuyWindowDataVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
