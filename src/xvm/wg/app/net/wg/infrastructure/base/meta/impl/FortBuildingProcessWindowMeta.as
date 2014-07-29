package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessInfoVO;
    
    public class FortBuildingProcessWindowMeta extends AbstractWindowView
    {
        
        public function FortBuildingProcessWindowMeta()
        {
            super();
        }
        
        public var requestBuildingInfo:Function = null;
        
        public var applyBuildingProcess:Function = null;
        
        public function requestBuildingInfoS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.requestBuildingInfo,"requestBuildingInfo" + Errors.CANT_NULL);
            this.requestBuildingInfo(param1);
        }
        
        public function applyBuildingProcessS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.applyBuildingProcess,"applyBuildingProcess" + Errors.CANT_NULL);
            this.applyBuildingProcess(param1);
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:BuildingProcessVO = new BuildingProcessVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:BuildingProcessVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function as_responseBuildingInfo(param1:Object) : void
        {
            var _loc2_:BuildingProcessInfoVO = new BuildingProcessInfoVO(param1);
            this.responseBuildingInfo(_loc2_);
        }
        
        protected function responseBuildingInfo(param1:BuildingProcessInfoVO) : void
        {
            var _loc2_:String = "as_responseBuildingInfo" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
