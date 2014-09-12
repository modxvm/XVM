package net.wg.gui.components.advanced
{
    public class GhostButton extends ButtonDnmIcon
    {
        
        public function GhostButton()
        {
            super();
        }
        
        private static var ICON_ALPHA_ENABLED:Number = 1;
        
        private static var ICON_ALPHA_DISABLED:Number = 0.5;
        
        override protected function configUI() : void
        {
            super.configUI();
            disabledFillPadding.left = 1;
            disabledFillPadding.top = 1;
            disabledFillPadding.bottom = 1;
        }
        
        override protected function updateDisable() : void
        {
            super.updateDisable();
            if(enabled)
            {
                container.alpha = ICON_ALPHA_ENABLED;
            }
            else
            {
                container.alpha = ICON_ALPHA_DISABLED;
            }
        }
    }
}
