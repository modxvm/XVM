package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.gui.lobby.epicBattles.data.FrontlineBuyConfirmVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class FrontlineBuyConfirmViewMeta extends AbstractScreen
    {

        public var onClose:Function;

        public var onBuy:Function;

        public var onBack:Function;

        private var _frontlineBuyConfirmVO:FrontlineBuyConfirmVO;

        public function FrontlineBuyConfirmViewMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._frontlineBuyConfirmVO)
            {
                this._frontlineBuyConfirmVO.dispose();
                this._frontlineBuyConfirmVO = null;
            }
            super.onDispose();
        }

        public function onCloseS() : void
        {
            App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
            this.onClose();
        }

        public function onBuyS() : void
        {
            App.utils.asserter.assertNotNull(this.onBuy,"onBuy" + Errors.CANT_NULL);
            this.onBuy();
        }

        public function onBackS() : void
        {
            App.utils.asserter.assertNotNull(this.onBack,"onBack" + Errors.CANT_NULL);
            this.onBack();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:FrontlineBuyConfirmVO = this._frontlineBuyConfirmVO;
            this._frontlineBuyConfirmVO = new FrontlineBuyConfirmVO(param1);
            this.setData(this._frontlineBuyConfirmVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:FrontlineBuyConfirmVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
