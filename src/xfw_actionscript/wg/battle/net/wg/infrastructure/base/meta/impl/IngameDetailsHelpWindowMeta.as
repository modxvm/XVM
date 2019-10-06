package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.gui.battle.windows.vo.IngameDetailsHelpVO;
    import net.wg.gui.battle.windows.vo.IngameDetailsPageVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class IngameDetailsHelpWindowMeta extends AbstractWindowView
    {

        public var requestHelpData:Function;

        private var _ingameDetailsHelpVO:IngameDetailsHelpVO;

        private var _ingameDetailsPageVO:IngameDetailsPageVO;

        public function IngameDetailsHelpWindowMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._ingameDetailsHelpVO)
            {
                this._ingameDetailsHelpVO.dispose();
                this._ingameDetailsHelpVO = null;
            }
            if(this._ingameDetailsPageVO)
            {
                this._ingameDetailsPageVO.dispose();
                this._ingameDetailsPageVO = null;
            }
            super.onDispose();
        }

        public function requestHelpDataS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.requestHelpData,"requestHelpData" + Errors.CANT_NULL);
            this.requestHelpData(param1);
        }

        public final function as_setInitData(param1:Object) : void
        {
            var _loc2_:IngameDetailsHelpVO = this._ingameDetailsHelpVO;
            this._ingameDetailsHelpVO = this.getIngameDetailsHelpVOForData(param1);
            this.setInitData(this._ingameDetailsHelpVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setHelpData(param1:Object) : void
        {
            var _loc2_:IngameDetailsPageVO = this._ingameDetailsPageVO;
            this._ingameDetailsPageVO = this.getIngameDetailsPageVOForData(param1);
            this.setHelpData(this._ingameDetailsPageVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function getIngameDetailsHelpVOForData(param1:Object) : IngameDetailsHelpVO
        {
            var _loc2_:String = "getIngameDetailsHelpVOForData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setInitData(param1:IngameDetailsHelpVO) : void
        {
            var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function getIngameDetailsPageVOForData(param1:Object) : IngameDetailsPageVO
        {
            var _loc2_:String = "getIngameDetailsPageVOForData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setHelpData(param1:IngameDetailsPageVO) : void
        {
            var _loc2_:String = "as_setHelpData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
