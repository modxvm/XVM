package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.battleResults.BattleResultsVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortBattleResultsWindowMeta extends AbstractWindowView
    {
        
        public function FortBattleResultsWindowMeta()
        {
            super();
        }
        
        public var getMoreInfo:Function = null;
        
        public var getClanEmblem:Function = null;
        
        public function getMoreInfoS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.getMoreInfo,"getMoreInfo" + Errors.CANT_NULL);
            this.getMoreInfo(param1);
        }
        
        public function getClanEmblemS() : void
        {
            App.utils.asserter.assertNotNull(this.getClanEmblem,"getClanEmblem" + Errors.CANT_NULL);
            this.getClanEmblem();
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:BattleResultsVO = new BattleResultsVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:BattleResultsVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
