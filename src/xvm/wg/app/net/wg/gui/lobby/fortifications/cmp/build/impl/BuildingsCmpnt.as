package net.wg.gui.lobby.fortifications.cmp.build.impl
{
    import net.wg.infrastructure.base.meta.impl.FortBuildingComponentMeta;
    import net.wg.gui.lobby.fortifications.cmp.build.IFortBuildingCmp;
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.gui.lobby.profile.components.SimpleLoader;
    import net.wg.gui.lobby.fortifications.cmp.drctn.IFortDirectionsContainer;
    import net.wg.gui.lobby.fortifications.cmp.build.IFortBuildingsContainer;
    import net.wg.gui.lobby.fortifications.data.BuildingsComponentVO;
    import net.wg.gui.lobby.fortifications.utils.ITransportingHelper;
    import net.wg.gui.lobby.fortifications.data.FortModeVO;
    import net.wg.gui.lobby.fortifications.data.FunctionalStates;
    import net.wg.data.constants.Linkages;
    import flash.geom.Point;
    import net.wg.gui.lobby.fortifications.cmp.build.IFortBuilding;
    import net.wg.gui.lobby.fortifications.events.FortBuildingEvent;
    import net.wg.gui.lobby.fortifications.data.BuildingVO;
    
    public class BuildingsCmpnt extends FortBuildingComponentMeta implements IFortBuildingCmp
    {
        
        public function BuildingsCmpnt()
        {
            super();
            UIID = 1;
        }
        
        private static var DEFAULT_LANDSCAPE_WIDTH:int = 1600;
        
        public var shadowMC:IUIComponentEx = null;
        
        private var _landscapeBG:SimpleLoader = null;
        
        public var bgFore:IUIComponentEx = null;
        
        private var _directionsContainer:IFortDirectionsContainer;
        
        private var _buildingContainer:IFortBuildingsContainer;
        
        private var model:BuildingsComponentVO = null;
        
        private var _transportingHelper:ITransportingHelper = null;
        
        public function updateCommonMode(param1:FortModeVO) : void
        {
            this._buildingContainer.updateCommonMode(param1);
        }
        
        public function as_refreshTransporting() : void
        {
            this._transportingHelper.updateTransportMode(this._transportingHelper.getModeVO(false,false));
            this._transportingHelper.updateTransportMode(this._transportingHelper.getModeVO(true,false));
        }
        
        public function updateTransportMode(param1:FortModeVO) : void
        {
            var _loc2_:Class = null;
            if(!param1.isTutorial && !(param1.currentMode == FunctionalStates.TRANSPORTING_NEXT_STEP) || (param1.isTutorial) && param1.currentMode == FunctionalStates.TRANSPORTING_TUTORIAL_FIRST_STEP)
            {
                this._directionsContainer.updateTransportMode(param1);
                if((param1.isEntering) && this._transportingHelper == null)
                {
                    _loc2_ = App.utils.classFactory.getClass(Linkages.TRANSPORTING_HELPER);
                    this._transportingHelper = ITransportingHelper(new _loc2_(this._buildingContainer.buildings,this));
                }
                if(this._transportingHelper != null)
                {
                    this._transportingHelper.updateTransportMode(param1);
                    this.toggleBackground(param1.isEntering);
                }
            }
        }
        
        public function updateControlPositions() : void
        {
            this.bgFore.x = this.shadowMC.x = globalToLocal(new Point(0,0)).x;
            this.bgFore.y = this.shadowMC.y = -y;
            this.bgFore.setActualSize(App.appWidth,App.appHeight);
            this.shadowMC.setActualSize(App.appWidth,App.appHeight);
            var _loc1_:Number = globalToLocal(new Point(0,0)).x;
            this._landscapeBG.x = (App.appWidth - DEFAULT_LANDSCAPE_WIDTH >> 1) + _loc1_ ^ 0;
        }
        
        public function updateDirectionsMode(param1:FortModeVO) : void
        {
            this._directionsContainer.updateDirectionsMode(param1);
            this._buildingContainer.updateDirectionsMode(param1);
            this.toggleBackground(param1.isEntering);
        }
        
        public function onTransportingSuccess(param1:IFortBuilding, param2:IFortBuilding) : void
        {
            onTransportingRequestS(param1.uid,param2.uid);
        }
        
        public function onStartExporting() : void
        {
            dispatchEvent(new FortBuildingEvent(FortBuildingEvent.FIRST_TRANSPORTING_STEP));
        }
        
        public function onStartImporting() : void
        {
            dispatchEvent(new FortBuildingEvent(FortBuildingEvent.NEXT_TRANSPORTING_STEP));
        }
        
        public function get buildingContainer() : IFortBuildingsContainer
        {
            return this._buildingContainer;
        }
        
        public function set buildingContainer(param1:IFortBuildingsContainer) : void
        {
            this._buildingContainer = param1;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this._buildingContainer.addEventListener(FortBuildingEvent.BUY_BUILDINGS,this.onByuBuildingsHandler);
            this._buildingContainer.addEventListener(FortBuildingEvent.BUILDING_SELECTED,this.buildingSelectedHandler);
            this.shadowMC.mouseChildren = false;
            this.shadowMC.mouseEnabled = false;
            this._landscapeBG.setSource(RES_FORT.MAPS_FORT_FORTLANDSCAPE);
        }
        
        override protected function setData(param1:BuildingsComponentVO) : void
        {
            this.model = param1;
            this.update();
        }
        
        override protected function setBuildingData(param1:BuildingVO) : void
        {
            this._buildingContainer.setBuildingData(param1,this.model.canAddBuilding);
        }
        
        override protected function onPopulate() : void
        {
            var _loc1_:IFortBuilding = null;
            super.onPopulate();
            for each(_loc1_ in this._buildingContainer.buildings)
            {
                _loc1_.getAdvancedToolTipFunc = getBuildingTooltipDataS;
            }
        }
        
        override protected function onDispose() : void
        {
            if(this._transportingHelper)
            {
                this._transportingHelper.dispose();
                this._transportingHelper = null;
            }
            this._directionsContainer.dispose();
            this._directionsContainer = null;
            this._buildingContainer.removeEventListener(FortBuildingEvent.BUY_BUILDINGS,this.onByuBuildingsHandler);
            this._buildingContainer.removeEventListener(FortBuildingEvent.BUILDING_SELECTED,this.buildingSelectedHandler);
            this._buildingContainer.dispose();
            this._buildingContainer = null;
            this._landscapeBG.dispose();
            this._landscapeBG = null;
            if(this.model)
            {
                this.model.dispose();
            }
            this.model = null;
            this.shadowMC.dispose();
            this.shadowMC = null;
            this.bgFore.dispose();
            this.bgFore = null;
            super.onDispose();
        }
        
        private function toggleBackground(param1:Boolean) : void
        {
            this._landscapeBG.alpha = !param1?1:0.4;
        }
        
        private function update() : void
        {
            var _loc1_:Vector.<BuildingVO> = this.model.buildingData;
            this._buildingContainer.update(_loc1_,this.model.canAddBuilding);
            this._directionsContainer.update(_loc1_);
        }
        
        private function buildingSelectedHandler(param1:FortBuildingEvent) : void
        {
            if(param1.uid)
            {
                upgradeVisitedBuildingS(param1.uid);
            }
        }
        
        private function onByuBuildingsHandler(param1:FortBuildingEvent) : void
        {
            requestBuildingProcessS(param1.direction,param1.position);
        }
        
        public function get directionsContainer() : IFortDirectionsContainer
        {
            return this._directionsContainer;
        }
        
        public function set directionsContainer(param1:IFortDirectionsContainer) : void
        {
            this._directionsContainer = param1;
        }
        
        public function get landscapeBG() : SimpleLoader
        {
            return this._landscapeBG;
        }
        
        public function set landscapeBG(param1:SimpleLoader) : void
        {
            this._landscapeBG = param1;
        }
    }
}
