package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class EventCoinsCounterMeta extends BaseDAAPIComponent
    {

        private var _toolTipVO:ToolTipVO;

        public function EventCoinsCounterMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._toolTipVO)
            {
                this._toolTipVO.dispose();
                this._toolTipVO = null;
            }
            super.onDispose();
        }

        public final function as_setCoinsTooltip(param1:Object) : void
        {
            var _loc2_:ToolTipVO = this._toolTipVO;
            this._toolTipVO = new ToolTipVO(param1);
            this.setCoinsTooltip(this._toolTipVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setCoinsTooltip(param1:ToolTipVO) : void
        {
            var _loc2_:String = "as_setCoinsTooltip" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
