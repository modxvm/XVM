package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.FortChoiceDivisionVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortChoiceDivisionWindowMeta extends AbstractWindowView
    {
        
        public function FortChoiceDivisionWindowMeta()
        {
            super();
        }
        
        public var selectedDivision:Function = null;
        
        public function selectedDivisionS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.selectedDivision,"selectedDivision" + Errors.CANT_NULL);
            this.selectedDivision(param1);
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:FortChoiceDivisionVO = new FortChoiceDivisionVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:FortChoiceDivisionVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
