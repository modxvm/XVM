package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.settings.FortSettingsClanInfoVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.gui.lobby.fortifications.data.settings.FortSettingsActivatedViewVO;
    import net.wg.gui.lobby.fortifications.data.settings.FortSettingsNotActivatedViewVO;
    
    public class FortSettingsWindowMeta extends AbstractWindowView
    {
        
        public function FortSettingsWindowMeta()
        {
            super();
        }
        
        public var activateDefencePeriod:Function = null;
        
        public var disableDefencePeriod:Function = null;
        
        public var cancelDisableDefencePeriod:Function = null;
        
        public function activateDefencePeriodS() : void
        {
            App.utils.asserter.assertNotNull(this.activateDefencePeriod,"activateDefencePeriod" + Errors.CANT_NULL);
            this.activateDefencePeriod();
        }
        
        public function disableDefencePeriodS() : void
        {
            App.utils.asserter.assertNotNull(this.disableDefencePeriod,"disableDefencePeriod" + Errors.CANT_NULL);
            this.disableDefencePeriod();
        }
        
        public function cancelDisableDefencePeriodS() : void
        {
            App.utils.asserter.assertNotNull(this.cancelDisableDefencePeriod,"cancelDisableDefencePeriod" + Errors.CANT_NULL);
            this.cancelDisableDefencePeriod();
        }
        
        public function as_setFortClanInfo(param1:Object) : void
        {
            var _loc2_:FortSettingsClanInfoVO = new FortSettingsClanInfoVO(param1);
            this.setFortClanInfo(_loc2_);
        }
        
        protected function setFortClanInfo(param1:FortSettingsClanInfoVO) : void
        {
            var _loc2_:String = "as_setFortClanInfo" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function as_setDataForActivated(param1:Object) : void
        {
            var _loc2_:FortSettingsActivatedViewVO = new FortSettingsActivatedViewVO(param1);
            this.setDataForActivated(_loc2_);
        }
        
        protected function setDataForActivated(param1:FortSettingsActivatedViewVO) : void
        {
            var _loc2_:String = "as_setDataForActivated" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function as_setDataForNotActivated(param1:Object) : void
        {
            var _loc2_:FortSettingsNotActivatedViewVO = new FortSettingsNotActivatedViewVO(param1);
            this.setDataForNotActivated(_loc2_);
        }
        
        protected function setDataForNotActivated(param1:FortSettingsNotActivatedViewVO) : void
        {
            var _loc2_:String = "as_setDataForNotActivated" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
