package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.gui.lobby.hangar.data.ModuleInfoActionVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class ModuleInfoMeta extends AbstractWindowView
    {

        public var onCancelClick:Function;

        public var onActionButtonClick:Function;

        private var _moduleInfoActionVO:ModuleInfoActionVO;

        public function ModuleInfoMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._moduleInfoActionVO)
            {
                this._moduleInfoActionVO.dispose();
                this._moduleInfoActionVO = null;
            }
            super.onDispose();
        }

        public function onCancelClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onCancelClick,"onCancelClick" + Errors.CANT_NULL);
            this.onCancelClick();
        }

        public function onActionButtonClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onActionButtonClick,"onActionButtonClick" + Errors.CANT_NULL);
            this.onActionButtonClick();
        }

        public final function as_setActionButton(param1:Object) : void
        {
            var _loc2_:ModuleInfoActionVO = this._moduleInfoActionVO;
            this._moduleInfoActionVO = new ModuleInfoActionVO(param1);
            this.setActionButton(this._moduleInfoActionVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setActionButton(param1:ModuleInfoActionVO) : void
        {
            var _loc2_:String = "as_setActionButton" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
