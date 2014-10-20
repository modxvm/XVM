package net.wg.gui.components.popOvers
{
    import net.wg.infrastructure.interfaces.ITween;
    import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
    import net.wg.utils.ITweenManager;
    import net.wg.infrastructure.managers.ITweenManagerHelper;
    
    public class SmartPopOver extends PopOver
    {
        
        public function SmartPopOver()
        {
            super();
            visible = false;
        }
        
        private var fadeInTween:ITween;
        
        override protected function invokeLayout() : void
        {
            var _loc2_:ITweenPropertiesVO = null;
            var _loc1_:Object = _layout.invokeLayout();
            if((_loc1_) && !visible)
            {
                alpha = 0;
                _loc2_ = App.utils.tweenAnimator.createPropsForAlpha(this,this.tweenMgrHelper.getFadeDurationFast(),1,0);
                _loc2_.setPaused(false);
                this.fadeInTween = this.tweenMgr.createNewTween(_loc2_);
                visible = true;
            }
        }
        
        private function get tweenMgr() : ITweenManager
        {
            return App.tweenMgr;
        }
        
        private function get tweenMgrHelper() : ITweenManagerHelper
        {
            return App.tweenMgr.getTweenManagerHelper();
        }
        
        override protected function onDispose() : void
        {
            if(this.fadeInTween != null)
            {
                this.tweenMgr.disposeTweenS(this.fadeInTween);
                this.fadeInTween = null;
            }
            super.onDispose();
        }
    }
}
