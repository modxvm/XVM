package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSecretEventBoughtPanelVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class VehiclePreviewSecretEventBoughtPanelMeta extends BaseDAAPIComponent
    {

        public var onShowInHangarClick:Function;

        private var _vPSecretEventBoughtPanelVO:VPSecretEventBoughtPanelVO;

        public function VehiclePreviewSecretEventBoughtPanelMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._vPSecretEventBoughtPanelVO)
            {
                this._vPSecretEventBoughtPanelVO.dispose();
                this._vPSecretEventBoughtPanelVO = null;
            }
            super.onDispose();
        }

        public function onShowInHangarClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onShowInHangarClick,"onShowInHangarClick" + Errors.CANT_NULL);
            this.onShowInHangarClick();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:VPSecretEventBoughtPanelVO = this._vPSecretEventBoughtPanelVO;
            this._vPSecretEventBoughtPanelVO = new VPSecretEventBoughtPanelVO(param1);
            this.setData(this._vPSecretEventBoughtPanelVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:VPSecretEventBoughtPanelVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
