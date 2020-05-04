package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSecretEventBuyingPanelVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class VehiclePreviewSecretEventBuyingPanelMeta extends BaseDAAPIComponent
    {

        public var onBuyClick:Function;

        private var _vPSecretEventBuyingPanelVO:VPSecretEventBuyingPanelVO;

        public function VehiclePreviewSecretEventBuyingPanelMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._vPSecretEventBuyingPanelVO)
            {
                this._vPSecretEventBuyingPanelVO.dispose();
                this._vPSecretEventBuyingPanelVO = null;
            }
            super.onDispose();
        }

        public function onBuyClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onBuyClick,"onBuyClick" + Errors.CANT_NULL);
            this.onBuyClick();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:VPSecretEventBuyingPanelVO = this._vPSecretEventBuyingPanelVO;
            this._vPSecretEventBuyingPanelVO = new VPSecretEventBuyingPanelVO(param1);
            this.setData(this._vPSecretEventBuyingPanelVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:VPSecretEventBuyingPanelVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
