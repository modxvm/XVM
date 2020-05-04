package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.gui.lobby.eventAwards.data.EventAwardScreenVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventAwardScreenMeta extends AbstractView
    {

        public var onCloseWindow:Function;

        public var onPlaySound:Function;

        public var onButton:Function;

        private var _eventAwardScreenVO:EventAwardScreenVO;

        public function EventAwardScreenMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventAwardScreenVO)
            {
                this._eventAwardScreenVO.dispose();
                this._eventAwardScreenVO = null;
            }
            super.onDispose();
        }

        public function onCloseWindowS() : void
        {
            App.utils.asserter.assertNotNull(this.onCloseWindow,"onCloseWindow" + Errors.CANT_NULL);
            this.onCloseWindow();
        }

        public function onPlaySoundS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.onPlaySound,"onPlaySound" + Errors.CANT_NULL);
            this.onPlaySound(param1);
        }

        public function onButtonS() : void
        {
            App.utils.asserter.assertNotNull(this.onButton,"onButton" + Errors.CANT_NULL);
            this.onButton();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:EventAwardScreenVO = this._eventAwardScreenVO;
            this._eventAwardScreenVO = new EventAwardScreenVO(param1);
            this.setData(this._eventAwardScreenVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:EventAwardScreenVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
