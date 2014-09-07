package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.fortifications.popovers.PopoverWithDropdown;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.settings.PeripheryPopoverVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortSettingsPeripheryPopoverMeta extends PopoverWithDropdown
    {
        
        public function FortSettingsPeripheryPopoverMeta()
        {
            super();
        }
        
        public var onApply:Function = null;
        
        public function onApplyS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.onApply,"onApply" + Errors.CANT_NULL);
            this.onApply(param1);
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:PeripheryPopoverVO = new PeripheryPopoverVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:PeripheryPopoverVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function as_setTexts(param1:Object) : void
        {
            var _loc2_:PeripheryPopoverVO = new PeripheryPopoverVO(param1);
            this.setTexts(_loc2_);
        }
        
        protected function setTexts(param1:PeripheryPopoverVO) : void
        {
            var _loc2_:String = "as_setTexts" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
