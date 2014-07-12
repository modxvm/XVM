package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    import net.wg.gui.lobby.fortifications.data.FortModeStateVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    import net.wg.gui.lobby.fortifications.data.FortificationVO;
    
    public class FortMainViewMeta extends BaseDAAPIComponent
    {
        
        public function FortMainViewMeta() {
            super();
        }
        
        public var onStatsClick:Function = null;
        
        public var onClanClick:Function = null;
        
        public var onCreateDirectionClick:Function = null;
        
        public var onEnterBuildDirectionClick:Function = null;
        
        public var onLeaveBuildDirectionClick:Function = null;
        
        public var onEnterTransportingClick:Function = null;
        
        public var onLeaveTransportingClick:Function = null;
        
        public var onIntelligenceClick:Function = null;
        
        public var onSortieClick:Function = null;
        
        public var onFirstTransportingStep:Function = null;
        
        public var onNextTransportingStep:Function = null;
        
        public function onStatsClickS() : void {
            App.utils.asserter.assertNotNull(this.onStatsClick,"onStatsClick" + Errors.CANT_NULL);
            this.onStatsClick();
        }
        
        public function onClanClickS() : void {
            App.utils.asserter.assertNotNull(this.onClanClick,"onClanClick" + Errors.CANT_NULL);
            this.onClanClick();
        }
        
        public function onCreateDirectionClickS(param1:uint) : void {
            App.utils.asserter.assertNotNull(this.onCreateDirectionClick,"onCreateDirectionClick" + Errors.CANT_NULL);
            this.onCreateDirectionClick(param1);
        }
        
        public function onEnterBuildDirectionClickS() : void {
            App.utils.asserter.assertNotNull(this.onEnterBuildDirectionClick,"onEnterBuildDirectionClick" + Errors.CANT_NULL);
            this.onEnterBuildDirectionClick();
        }
        
        public function onLeaveBuildDirectionClickS() : void {
            App.utils.asserter.assertNotNull(this.onLeaveBuildDirectionClick,"onLeaveBuildDirectionClick" + Errors.CANT_NULL);
            this.onLeaveBuildDirectionClick();
        }
        
        public function onEnterTransportingClickS() : void {
            App.utils.asserter.assertNotNull(this.onEnterTransportingClick,"onEnterTransportingClick" + Errors.CANT_NULL);
            this.onEnterTransportingClick();
        }
        
        public function onLeaveTransportingClickS() : void {
            App.utils.asserter.assertNotNull(this.onLeaveTransportingClick,"onLeaveTransportingClick" + Errors.CANT_NULL);
            this.onLeaveTransportingClick();
        }
        
        public function onIntelligenceClickS() : void {
            App.utils.asserter.assertNotNull(this.onIntelligenceClick,"onIntelligenceClick" + Errors.CANT_NULL);
            this.onIntelligenceClick();
        }
        
        public function onSortieClickS() : void {
            App.utils.asserter.assertNotNull(this.onSortieClick,"onSortieClick" + Errors.CANT_NULL);
            this.onSortieClick();
        }
        
        public function onFirstTransportingStepS() : void {
            App.utils.asserter.assertNotNull(this.onFirstTransportingStep,"onFirstTransportingStep" + Errors.CANT_NULL);
            this.onFirstTransportingStep();
        }
        
        public function onNextTransportingStepS() : void {
            App.utils.asserter.assertNotNull(this.onNextTransportingStep,"onNextTransportingStep" + Errors.CANT_NULL);
            this.onNextTransportingStep();
        }
        
        public function as_switchMode(param1:Object) : void {
            var _loc2_:FortModeStateVO = new FortModeStateVO(param1);
            this.switchMode(_loc2_);
        }
        
        protected function switchMode(param1:FortModeStateVO) : void {
            var _loc2_:String = "as_switchMode" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
        
        public function as_setMainData(param1:Object) : void {
            var _loc2_:FortificationVO = new FortificationVO(param1);
            this.setMainData(_loc2_);
        }
        
        protected function setMainData(param1:FortificationVO) : void {
            var _loc2_:String = "as_setMainData" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
