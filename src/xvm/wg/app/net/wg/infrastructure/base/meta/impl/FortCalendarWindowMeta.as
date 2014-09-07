package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.gui.lobby.fortifications.data.FortCalendarPreviewBlockVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortCalendarWindowMeta extends AbstractWindowView
    {
        
        public function FortCalendarWindowMeta()
        {
            super();
        }
        
        public function as_updatePreviewData(param1:Object) : void
        {
            var _loc2_:FortCalendarPreviewBlockVO = new FortCalendarPreviewBlockVO(param1);
            this.updatePreviewData(_loc2_);
        }
        
        protected function updatePreviewData(param1:FortCalendarPreviewBlockVO) : void
        {
            var _loc2_:String = "as_updatePreviewData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
