package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.quests.data.seasonAwards.SeasonAwardsVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class QuestsSeasonAwardsWindowMeta extends AbstractWindowView
    {
        
        public function QuestsSeasonAwardsWindowMeta()
        {
            super();
        }
        
        public var showVehicleInfo:Function = null;
        
        public function showVehicleInfoS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.showVehicleInfo,"showVehicleInfo" + Errors.CANT_NULL);
            this.showVehicleInfo(param1);
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:SeasonAwardsVO = new SeasonAwardsVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:SeasonAwardsVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
