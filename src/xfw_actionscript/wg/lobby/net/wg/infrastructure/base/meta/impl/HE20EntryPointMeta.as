package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.lobby.eventHangar.data.EventProgressBannerVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class HE20EntryPointMeta extends BaseDAAPIComponent
    {

        public var onClick:Function;

        private var _eventProgressBannerVO:EventProgressBannerVO;

        public function HE20EntryPointMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._eventProgressBannerVO)
            {
                this._eventProgressBannerVO.dispose();
                this._eventProgressBannerVO = null;
            }
            super.onDispose();
        }

        public function onClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onClick,"onClick" + Errors.CANT_NULL);
            this.onClick();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:EventProgressBannerVO = this._eventProgressBannerVO;
            this._eventProgressBannerVO = new EventProgressBannerVO(param1);
            this.setData(this._eventProgressBannerVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:EventProgressBannerVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
