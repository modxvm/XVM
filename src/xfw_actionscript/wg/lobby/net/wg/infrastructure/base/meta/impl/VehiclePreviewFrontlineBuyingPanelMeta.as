package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.lobby.vehiclePreview20.data.VPFrontlineBuyingPanelVO;
    import net.wg.gui.lobby.vehiclePreview20.data.VPSetItemsVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class VehiclePreviewFrontlineBuyingPanelMeta extends BaseDAAPIComponent
    {

        public var onBuyClick:Function;

        public var showTooltip:Function;

        private var _vPFrontlineBuyingPanelVO:VPFrontlineBuyingPanelVO;

        private var _vPSetItemsVO:VPSetItemsVO;

        public function VehiclePreviewFrontlineBuyingPanelMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._vPFrontlineBuyingPanelVO)
            {
                this._vPFrontlineBuyingPanelVO.dispose();
                this._vPFrontlineBuyingPanelVO = null;
            }
            if(this._vPSetItemsVO)
            {
                this._vPSetItemsVO.dispose();
                this._vPSetItemsVO = null;
            }
            super.onDispose();
        }

        public function onBuyClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onBuyClick,"onBuyClick" + Errors.CANT_NULL);
            this.onBuyClick();
        }

        public function showTooltipS(param1:String, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.showTooltip,"showTooltip" + Errors.CANT_NULL);
            this.showTooltip(param1,param2);
        }

        public final function as_setData(param1:Object) : void
        {
            var _loc2_:VPFrontlineBuyingPanelVO = this._vPFrontlineBuyingPanelVO;
            this._vPFrontlineBuyingPanelVO = new VPFrontlineBuyingPanelVO(param1);
            this.setData(this._vPFrontlineBuyingPanelVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setSetItemsData(param1:Object) : void
        {
            var _loc2_:VPSetItemsVO = this._vPSetItemsVO;
            this._vPSetItemsVO = new VPSetItemsVO(param1);
            this.setSetItemsData(this._vPSetItemsVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setData(param1:VPFrontlineBuyingPanelVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setSetItemsData(param1:VPSetItemsVO) : void
        {
            var _loc2_:String = "as_setSetItemsData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
