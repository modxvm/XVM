package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.settings.DisableDefencePeriodVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortDisableDefencePeriodWindowMeta extends AbstractWindowView
    {
        
        public function FortDisableDefencePeriodWindowMeta()
        {
            super();
        }
        
        public var onClickApplyButton:Function = null;
        
        public function onClickApplyButtonS() : void
        {
            App.utils.asserter.assertNotNull(this.onClickApplyButton,"onClickApplyButton" + Errors.CANT_NULL);
            this.onClickApplyButton();
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:DisableDefencePeriodVO = new DisableDefencePeriodVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:DisableDefencePeriodVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
