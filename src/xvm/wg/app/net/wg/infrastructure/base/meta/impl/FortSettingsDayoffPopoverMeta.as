package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.fortifications.popovers.PopoverWithDropdown;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.settings.DayOffPopoverVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortSettingsDayoffPopoverMeta extends PopoverWithDropdown
    {
        
        public function FortSettingsDayoffPopoverMeta()
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
            var _loc2_:DayOffPopoverVO = new DayOffPopoverVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:DayOffPopoverVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
