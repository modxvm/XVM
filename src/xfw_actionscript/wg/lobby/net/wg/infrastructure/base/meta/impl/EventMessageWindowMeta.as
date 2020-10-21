package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.gui.lobby.eventMessageWindow.data.MessageContentVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventMessageWindowMeta extends AbstractWindowView
    {

        public var onResult:Function;

        private var _messageContentVO:MessageContentVO;

        public function EventMessageWindowMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._messageContentVO)
            {
                this._messageContentVO.dispose();
                this._messageContentVO = null;
            }
            super.onDispose();
        }

        public function onResultS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.onResult,"onResult" + Errors.CANT_NULL);
            this.onResult(param1);
        }

        public final function as_setMessageData(param1:Object) : void
        {
            var _loc2_:MessageContentVO = this._messageContentVO;
            this._messageContentVO = new MessageContentVO(param1);
            this.setMessageData(this._messageContentVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setMessageData(param1:MessageContentVO) : void
        {
            var _loc2_:String = "as_setMessageData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
