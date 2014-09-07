package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.SmartPopOverView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.settings.DefenceHourPopoverVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class FortSettingsDefenceHourPopoverMeta extends SmartPopOverView
    {
        
        public function FortSettingsDefenceHourPopoverMeta()
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
            var _loc2_:DefenceHourPopoverVO = new DefenceHourPopoverVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:DefenceHourPopoverVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function as_setTexts(param1:Object) : void
        {
            var _loc2_:DefenceHourPopoverVO = new DefenceHourPopoverVO(param1);
            this.setTexts(_loc2_);
        }
        
        protected function setTexts(param1:DefenceHourPopoverVO) : void
        {
            var _loc2_:String = "as_setTexts" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
