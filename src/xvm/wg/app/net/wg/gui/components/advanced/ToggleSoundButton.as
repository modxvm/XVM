package net.wg.gui.components.advanced
{
    import net.wg.gui.components.controls.ButtonIconLoader;
    import scaleform.clik.constants.InvalidationType;
    
    public class ToggleSoundButton extends ButtonIconLoader
    {
        
        public function ToggleSoundButton()
        {
            super();
        }
        
        public var toggleIndicator:ButtonToggleIndicator;
        
        override public function set selected(param1:Boolean) : void
        {
            super.selected = param1;
            this.updateIndicatorSelection(param1);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            iconOffsetTop = this.hitMc.height - height >> 1;
            this.updateIndicatorSelection(_selected);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateIndicator();
            }
        }
        
        override protected function updateAfterStateChange() : void
        {
            this.updateIndicator();
            super.updateAfterStateChange();
        }
        
        private function updateIndicator() : void
        {
            this.toggleIndicator.scaleX = 1 / scaleX;
            this.toggleIndicator.scaleY = 1 / scaleY;
            this.toggleIndicator.x = Math.round((hitMc.width - this.toggleIndicator.width / scaleX) / 2);
            this.toggleIndicator.y = Math.round(hitMc.height - this.toggleIndicator.height);
        }
        
        private function updateIndicatorSelection(param1:Boolean) : void
        {
            this.toggleIndicator.selected = param1;
        }
    }
}
