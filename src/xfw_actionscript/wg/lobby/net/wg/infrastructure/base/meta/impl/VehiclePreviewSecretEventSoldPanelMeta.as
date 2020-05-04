package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSecretEventSoldPanelVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class VehiclePreviewSecretEventSoldPanelMeta extends BaseDAAPIComponent
    {

        public var onRestoreClick:Function;

        private var _vPSecretEventSoldPanelVO:VPSecretEventSoldPanelVO;

        public function VehiclePreviewSecretEventSoldPanelMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._vPSecretEventSoldPanelVO)
            {
                this._vPSecretEventSoldPanelVO.dispose();
                this._vPSecretEventSoldPanelVO = null;
            }
            super.onDispose();
        }

        public function onRestoreClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onRestoreClick,"onRestoreClick" + Errors.CANT_NULL);
            this.onRestoreClick();
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:VPSecretEventSoldPanelVO = this._vPSecretEventSoldPanelVO;
            this._vPSecretEventSoldPanelVO = new VPSecretEventSoldPanelVO(param1);
            this.setData(this._vPSecretEventSoldPanelVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:VPSecretEventSoldPanelVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
