package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.gui.data.CrystalsPromoWindowVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class CrystalsPromoWindowMeta extends AbstractWindowView
    {

        public var onOpenShop:Function;

        private var _crystalsPromoWindowVO:CrystalsPromoWindowVO;

        public function CrystalsPromoWindowMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._crystalsPromoWindowVO)
            {
                this._crystalsPromoWindowVO.dispose();
                this._crystalsPromoWindowVO = null;
            }
            super.onDispose();
        }

        public function onOpenShopS() : void
        {
            App.utils.asserter.assertNotNull(this.onOpenShop,"onOpenShop" + Errors.CANT_NULL);
            this.onOpenShop();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:CrystalsPromoWindowVO = this._crystalsPromoWindowVO;
            this._crystalsPromoWindowVO = new CrystalsPromoWindowVO(param1);
            this.setData(this._crystalsPromoWindowVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:CrystalsPromoWindowVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
