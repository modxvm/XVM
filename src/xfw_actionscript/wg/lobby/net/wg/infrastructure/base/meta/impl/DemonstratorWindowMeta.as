package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.gui.lobby.demonstration.data.DemonstratorVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class DemonstratorWindowMeta extends AbstractWindowView
    {

        public var onMapSelected:Function;

        private var _demonstratorVO:DemonstratorVO;

        public function DemonstratorWindowMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._demonstratorVO)
            {
                this._demonstratorVO.dispose();
                this._demonstratorVO = null;
            }
            super.onDispose();
        }

        public function onMapSelectedS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.onMapSelected,"onMapSelected" + Errors.CANT_NULL);
            this.onMapSelected(param1);
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:DemonstratorVO = this._demonstratorVO;
            this._demonstratorVO = new DemonstratorVO(param1);
            this.setData(this._demonstratorVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:DemonstratorVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
