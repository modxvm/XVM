package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.VPSecretEventBuyingPanel;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSecretEventBuyingActionPanelVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class VehiclePreviewSecretEventBuyingActionPanelMeta extends VPSecretEventBuyingPanel
    {

        public var onActionClick:Function;

        private var _vPSecretEventBuyingActionPanelVO:VPSecretEventBuyingActionPanelVO;

        public function VehiclePreviewSecretEventBuyingActionPanelMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._vPSecretEventBuyingActionPanelVO)
            {
                this._vPSecretEventBuyingActionPanelVO.dispose();
                this._vPSecretEventBuyingActionPanelVO = null;
            }
            super.onDispose();
        }

        public function onActionClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onActionClick,"onActionClick" + Errors.CANT_NULL);
            this.onActionClick();
        }

        public final function as_setActionData(param1:Object) : void
        {
            var _loc2_:VPSecretEventBuyingActionPanelVO = this._vPSecretEventBuyingActionPanelVO;
            this._vPSecretEventBuyingActionPanelVO = new VPSecretEventBuyingActionPanelVO(param1);
            this.setActionData(this._vPSecretEventBuyingActionPanelVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setActionData(param1:VPSecretEventBuyingActionPanelVO) : void
        {
            var _loc2_:String = "as_setActionData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
