package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewStaticDataVO;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewInfoPanelVO;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewBuyingPanelDataVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class VehiclePreviewMeta extends AbstractView
    {

        public var closeView:Function;

        public var onBackClick:Function;

        public var onBuyOrResearchClick:Function;

        public var onOpenInfoTab:Function;

        public var onCompareClick:Function;

        private var _vehPreviewStaticDataVO:VehPreviewStaticDataVO;

        private var _vehPreviewInfoPanelVO:VehPreviewInfoPanelVO;

        private var _vehPreviewBuyingPanelDataVO:VehPreviewBuyingPanelDataVO;

        public function VehiclePreviewMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._vehPreviewStaticDataVO)
            {
                this._vehPreviewStaticDataVO.dispose();
                this._vehPreviewStaticDataVO = null;
            }
            if(this._vehPreviewInfoPanelVO)
            {
                this._vehPreviewInfoPanelVO.dispose();
                this._vehPreviewInfoPanelVO = null;
            }
            if(this._vehPreviewBuyingPanelDataVO)
            {
                this._vehPreviewBuyingPanelDataVO.dispose();
                this._vehPreviewBuyingPanelDataVO = null;
            }
            super.onDispose();
        }

        public function closeViewS() : void
        {
            App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
            this.closeView();
        }

        public function onBackClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onBackClick,"onBackClick" + Errors.CANT_NULL);
            this.onBackClick();
        }

        public function onBuyOrResearchClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onBuyOrResearchClick,"onBuyOrResearchClick" + Errors.CANT_NULL);
            this.onBuyOrResearchClick();
        }

        public function onOpenInfoTabS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onOpenInfoTab,"onOpenInfoTab" + Errors.CANT_NULL);
            this.onOpenInfoTab(param1);
        }

        public function onCompareClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onCompareClick,"onCompareClick" + Errors.CANT_NULL);
            this.onCompareClick();
        }

        public final function as_setStaticData(param1:Object) : void
        {
            var _loc2_:VehPreviewStaticDataVO = this._vehPreviewStaticDataVO;
            this._vehPreviewStaticDataVO = new VehPreviewStaticDataVO(param1);
            this.setStaticData(this._vehPreviewStaticDataVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_updateInfoData(param1:Object) : void
        {
            var _loc2_:VehPreviewInfoPanelVO = this._vehPreviewInfoPanelVO;
            this._vehPreviewInfoPanelVO = new VehPreviewInfoPanelVO(param1);
            this.updateInfoData(this._vehPreviewInfoPanelVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_updateBuyingPanel(param1:Object) : void
        {
            var _loc2_:VehPreviewBuyingPanelDataVO = this._vehPreviewBuyingPanelDataVO;
            this._vehPreviewBuyingPanelDataVO = new VehPreviewBuyingPanelDataVO(param1);
            this.updateBuyingPanel(this._vehPreviewBuyingPanelDataVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setStaticData(param1:VehPreviewStaticDataVO) : void
        {
            var _loc2_:String = "as_setStaticData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function updateInfoData(param1:VehPreviewInfoPanelVO) : void
        {
            var _loc2_:String = "as_updateInfoData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function updateBuyingPanel(param1:VehPreviewBuyingPanelDataVO) : void
        {
            var _loc2_:String = "as_updateBuyingPanel" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
