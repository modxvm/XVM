package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.gui.bootcamp.questsView.data.BCQuestsViewVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class BCQuestsViewMeta extends AbstractView
    {

        public var onCloseClicked:Function;

        private var _bCQuestsViewVO:BCQuestsViewVO;

        public function BCQuestsViewMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._bCQuestsViewVO)
            {
                this._bCQuestsViewVO.dispose();
                this._bCQuestsViewVO = null;
            }
            super.onDispose();
        }

        public function onCloseClickedS() : void
        {
            App.utils.asserter.assertNotNull(this.onCloseClicked,"onCloseClicked" + Errors.CANT_NULL);
            this.onCloseClicked();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:BCQuestsViewVO = this._bCQuestsViewVO;
            this._bCQuestsViewVO = new BCQuestsViewVO(param1);
            this.setData(this._bCQuestsViewVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:BCQuestsViewVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
