package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.FortInterFilterVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortIntelFilterMeta extends BaseDAAPIComponent
    {
        
        public function FortIntelFilterMeta()
        {
            super();
        }
        
        public var onTryToSearchByClanAbbr:Function = null;
        
        public var onClearClanTagSearch:Function = null;
        
        public function onTryToSearchByClanAbbrS(param1:String, param2:int) : String
        {
            App.utils.asserter.assertNotNull(this.onTryToSearchByClanAbbr,"onTryToSearchByClanAbbr" + Errors.CANT_NULL);
            return this.onTryToSearchByClanAbbr(param1,param2);
        }
        
        public function onClearClanTagSearchS() : void
        {
            App.utils.asserter.assertNotNull(this.onClearClanTagSearch,"onClearClanTagSearch" + Errors.CANT_NULL);
            this.onClearClanTagSearch();
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:FortInterFilterVO = new FortInterFilterVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:FortInterFilterVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
