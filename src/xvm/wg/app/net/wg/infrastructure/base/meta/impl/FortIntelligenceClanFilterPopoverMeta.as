package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.fortifications.popovers.PopoverWithDropdown;
    import net.wg.gui.lobby.fortifications.data.IntelligenceClanFilterVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortIntelligenceClanFilterPopoverMeta extends PopoverWithDropdown
    {
        
        public function FortIntelligenceClanFilterPopoverMeta()
        {
            super();
        }
        
        public var useFilter:Function = null;
        
        public var getAvailabilityProvider:Function = null;
        
        public function useFilterS(param1:IntelligenceClanFilterVO, param2:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.useFilter,"useFilter" + Errors.CANT_NULL);
            this.useFilter(param1,param2);
        }
        
        public function getAvailabilityProviderS() : Array
        {
            App.utils.asserter.assertNotNull(this.getAvailabilityProvider,"getAvailabilityProvider" + Errors.CANT_NULL);
            return this.getAvailabilityProvider();
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:IntelligenceClanFilterVO = new IntelligenceClanFilterVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:IntelligenceClanFilterVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
