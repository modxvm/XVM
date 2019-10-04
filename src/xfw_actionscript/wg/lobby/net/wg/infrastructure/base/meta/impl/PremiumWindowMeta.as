package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.components.windows.SimpleWindow;
    import net.wg.gui.lobby.premiumWindow.data.PremiumWindowRatesVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class PremiumWindowMeta extends SimpleWindow
    {

        public var onRateClick:Function;

        private var _premiumWindowRatesVO:PremiumWindowRatesVO;

        public function PremiumWindowMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._premiumWindowRatesVO)
            {
                this._premiumWindowRatesVO.dispose();
                this._premiumWindowRatesVO = null;
            }
            super.onDispose();
        }

        public function onRateClickS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.onRateClick,"onRateClick" + Errors.CANT_NULL);
            this.onRateClick(param1);
        }

        public final function as_setRates(param1:Object) : void
        {
            var _loc2_:PremiumWindowRatesVO = this._premiumWindowRatesVO;
            this._premiumWindowRatesVO = new PremiumWindowRatesVO(param1);
            this.setRates(this._premiumWindowRatesVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setRates(param1:PremiumWindowRatesVO) : void
        {
            var _loc2_:String = "as_setRates" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
