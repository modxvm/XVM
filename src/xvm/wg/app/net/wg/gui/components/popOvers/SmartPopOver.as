package net.wg.gui.components.popOvers
{
    public class SmartPopOver extends PopOver
    {
        
        public function SmartPopOver()
        {
            super();
            visible = false;
        }
        
        override protected function invokeLayout() : void
        {
            var _loc1_:Object = _layout.invokeLayout();
            if((_loc1_) && !visible)
            {
                alpha = 0;
                App.utils.tweenAnimator.removeAnims(this);
                App.utils.tweenAnimator.addFadeInAnim(this,null);
                visible = true;
            }
        }
        
        override protected function onDispose() : void
        {
            App.utils.tweenAnimator.removeAnims(this);
            super.onDispose();
        }
    }
}
