package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.headerTutorial.HeaderTutorialVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class HeaderTutorialWindowMeta extends AbstractWindowView
    {
        
        public function HeaderTutorialWindowMeta()
        {
            super();
        }
        
        public var goNextStep:Function = null;
        
        public var goPrevStep:Function = null;
        
        public var setStep:Function = null;
        
        public var requestToLeave:Function = null;
        
        public function goNextStepS() : void
        {
            App.utils.asserter.assertNotNull(this.goNextStep,"goNextStep" + Errors.CANT_NULL);
            this.goNextStep();
        }
        
        public function goPrevStepS() : void
        {
            App.utils.asserter.assertNotNull(this.goPrevStep,"goPrevStep" + Errors.CANT_NULL);
            this.goPrevStep();
        }
        
        public function setStepS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.setStep,"setStep" + Errors.CANT_NULL);
            this.setStep(param1);
        }
        
        public function requestToLeaveS() : void
        {
            App.utils.asserter.assertNotNull(this.requestToLeave,"requestToLeave" + Errors.CANT_NULL);
            this.requestToLeave();
        }
        
        public function as_setData(param1:Object) : void
        {
            var _loc2_:HeaderTutorialVO = new HeaderTutorialVO(param1);
            this.setData(_loc2_);
        }
        
        protected function setData(param1:HeaderTutorialVO) : void
        {
            var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
