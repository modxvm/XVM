package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.gui.data.BoosterBuyWindowVO;
    import net.wg.gui.data.BoosterBuyWindowUpdateVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class BoosterBuyWindowMeta extends AbstractWindowView
    {

        public var buy:Function;

        public var setAutoRearm:Function;

        private var _boosterBuyWindowVO:BoosterBuyWindowVO;

        private var _boosterBuyWindowUpdateVO:BoosterBuyWindowUpdateVO;

        public function BoosterBuyWindowMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._boosterBuyWindowVO)
            {
                this._boosterBuyWindowVO.dispose();
                this._boosterBuyWindowVO = null;
            }
            if(this._boosterBuyWindowUpdateVO)
            {
                this._boosterBuyWindowUpdateVO.dispose();
                this._boosterBuyWindowUpdateVO = null;
            }
            super.onDispose();
        }

        public function buyS(param1:uint) : void
        {
            App.utils.asserter.assertNotNull(this.buy,"buy" + Errors.CANT_NULL);
            this.buy(param1);
        }

        public function setAutoRearmS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.setAutoRearm,"setAutoRearm" + Errors.CANT_NULL);
            this.setAutoRearm(param1);
        }

        public final function as_setInitData(param1:Object) : void
        {
            var _loc2_:BoosterBuyWindowVO = this._boosterBuyWindowVO;
            this._boosterBuyWindowVO = new BoosterBuyWindowVO(param1);
            this.setInitData(this._boosterBuyWindowVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_updateData(param1:Object) : void
        {
            var _loc2_:BoosterBuyWindowUpdateVO = this._boosterBuyWindowUpdateVO;
            this._boosterBuyWindowUpdateVO = new BoosterBuyWindowUpdateVO(param1);
            this.updateData(this._boosterBuyWindowUpdateVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setInitData(param1:BoosterBuyWindowVO) : void
        {
            var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function updateData(param1:BoosterBuyWindowUpdateVO) : void
        {
            var _loc2_:String = "as_updateData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
