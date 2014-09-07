package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.SmartPopOverView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.BattleDirectionPopoverVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortBattleDirectionPopoverMeta extends SmartPopOverView
    {
        
        public function FortBattleDirectionPopoverMeta()
        {
            super();
        }
        
        public var requestToJoin:Function = null;
        
        public function requestToJoinS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.requestToJoin,"requestToJoin" + Errors.CANT_NULL);
            this.requestToJoin(param1);
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:BattleDirectionPopoverVO = new BattleDirectionPopoverVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:BattleDirectionPopoverVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
