package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.gui.lobby.eventShopConfirmation.data.ConfirmationDataVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventShopConfirmationMeta extends AbstractScreen
    {

        public var onCancelClick:Function;

        public var onBuyClick:Function;

        private var _confirmationDataVO:ConfirmationDataVO;

        public function EventShopConfirmationMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._confirmationDataVO)
            {
                this._confirmationDataVO.dispose();
                this._confirmationDataVO = null;
            }
            super.onDispose();
        }

        public function onCancelClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onCancelClick,"onCancelClick" + Errors.CANT_NULL);
            this.onCancelClick();
        }

        public function onBuyClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onBuyClick,"onBuyClick" + Errors.CANT_NULL);
            this.onBuyClick();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:ConfirmationDataVO = this._confirmationDataVO;
            this._confirmationDataVO = new ConfirmationDataVO(param1);
            this.setData(this._confirmationDataVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:ConfirmationDataVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
