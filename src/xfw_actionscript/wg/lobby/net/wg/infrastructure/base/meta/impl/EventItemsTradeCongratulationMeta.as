package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.gui.lobby.eventItemsTradeCongratulation.data.EventItemsTradeCongratulationVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventItemsTradeCongratulationMeta extends AbstractScreen
    {

        public var closeView:Function;

        public var onButtonConfirmationClick:Function;

        private var _eventItemsTradeCongratulationVO:EventItemsTradeCongratulationVO;

        public function EventItemsTradeCongratulationMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventItemsTradeCongratulationVO)
            {
                this._eventItemsTradeCongratulationVO.dispose();
                this._eventItemsTradeCongratulationVO = null;
            }
            super.onDispose();
        }

        public function closeViewS() : void
        {
            App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
            this.closeView();
        }

        public function onButtonConfirmationClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onButtonConfirmationClick,"onButtonConfirmationClick" + Errors.CANT_NULL);
            this.onButtonConfirmationClick();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:EventItemsTradeCongratulationVO = this._eventItemsTradeCongratulationVO;
            this._eventItemsTradeCongratulationVO = new EventItemsTradeCongratulationVO(param1);
            this.setData(this._eventItemsTradeCongratulationVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:EventItemsTradeCongratulationVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
