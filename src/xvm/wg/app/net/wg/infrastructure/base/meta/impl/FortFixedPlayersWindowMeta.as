package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.FortFixedPlayersVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortFixedPlayersWindowMeta extends AbstractWindowView
    {
        
        public function FortFixedPlayersWindowMeta()
        {
            super();
        }
        
        public var assignToBuilding:Function = null;
        
        public function assignToBuildingS() : void
        {
            App.utils.asserter.assertNotNull(this.assignToBuilding,"assignToBuilding" + Errors.CANT_NULL);
            this.assignToBuilding();
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:FortFixedPlayersVO = new FortFixedPlayersVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:FortFixedPlayersVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
