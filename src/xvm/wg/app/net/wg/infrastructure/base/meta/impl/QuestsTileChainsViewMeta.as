package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestsTileChainsViewVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestTileVO;
    import net.wg.gui.lobby.quests.data.ChainProgressVO;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskDetailsVO;
    
    public class QuestsTileChainsViewMeta extends BaseDAAPIComponent
    {
        
        public function QuestsTileChainsViewMeta()
        {
            super();
        }
        
        public var getTileData:Function = null;
        
        public var getChainProgress:Function = null;
        
        public var getTaskDetails:Function = null;
        
        public var selectTask:Function = null;
        
        public var refuseTask:Function = null;
        
        public var gotoBack:Function = null;
        
        public var showAwardVehicleInfo:Function = null;
        
        public var showAwardVehicleInHangar:Function = null;
        
        public function getTileDataS(param1:int, param2:String, param3:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.getTileData,"getTileData" + Errors.CANT_NULL);
            this.getTileData(param1,param2,param3);
        }
        
        public function getChainProgressS() : void
        {
            App.utils.asserter.assertNotNull(this.getChainProgress,"getChainProgress" + Errors.CANT_NULL);
            this.getChainProgress();
        }
        
        public function getTaskDetailsS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.getTaskDetails,"getTaskDetails" + Errors.CANT_NULL);
            this.getTaskDetails(param1);
        }
        
        public function selectTaskS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.selectTask,"selectTask" + Errors.CANT_NULL);
            this.selectTask(param1);
        }
        
        public function refuseTaskS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.refuseTask,"refuseTask" + Errors.CANT_NULL);
            this.refuseTask(param1);
        }
        
        public function gotoBackS() : void
        {
            App.utils.asserter.assertNotNull(this.gotoBack,"gotoBack" + Errors.CANT_NULL);
            this.gotoBack();
        }
        
        public function showAwardVehicleInfoS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.showAwardVehicleInfo,"showAwardVehicleInfo" + Errors.CANT_NULL);
            this.showAwardVehicleInfo(param1);
        }
        
        public function showAwardVehicleInHangarS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.showAwardVehicleInHangar,"showAwardVehicleInHangar" + Errors.CANT_NULL);
            this.showAwardVehicleInHangar(param1);
        }
        
        public function as_setHeaderData(param1:Object) : void
        {
            var _loc2_:QuestsTileChainsViewVO = new QuestsTileChainsViewVO(param1);
            this.setHeaderData(_loc2_);
        }
        
        protected function setHeaderData(param1:QuestsTileChainsViewVO) : void
        {
            var _loc2_:String = "as_setHeaderData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function as_updateTileData(param1:Object) : void
        {
            var _loc2_:QuestTileVO = new QuestTileVO(param1);
            this.updateTileData(_loc2_);
        }
        
        protected function updateTileData(param1:QuestTileVO) : void
        {
            var _loc2_:String = "as_updateTileData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function as_updateChainProgress(param1:Object) : void
        {
            var _loc2_:ChainProgressVO = new ChainProgressVO(param1);
            this.updateChainProgress(_loc2_);
        }
        
        protected function updateChainProgress(param1:ChainProgressVO) : void
        {
            var _loc2_:String = "as_updateChainProgress" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function as_updateTaskDetails(param1:Object) : void
        {
            var _loc2_:QuestTaskDetailsVO = new QuestTaskDetailsVO(param1);
            this.updateTaskDetails(_loc2_);
        }
        
        protected function updateTaskDetails(param1:QuestTaskDetailsVO) : void
        {
            var _loc2_:String = "as_updateTaskDetails" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
