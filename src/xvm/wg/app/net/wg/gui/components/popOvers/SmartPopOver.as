package net.wg.gui.components.popOvers
{
    public class SmartPopOver extends PopOver
    {
        
        public function SmartPopOver() {
            super();
            visible = false;
        }
        
        override protected function invokeLayout() : void {
            var _loc1_:Object = _layout.invokeLayout();
            if(_loc1_)
            {
                visible = true;
            }
        }
    }
}
