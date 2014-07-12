package net.wg.gui.components.controls
{
    import flash.display.MovieClip;
    
    public class BorderShadowScrollPane extends ResizableScrollPane
    {
        
        public function BorderShadowScrollPane() {
            super();
        }
        
        public var topShadow:MovieClip;
        
        public var bottomShadow:MovieClip;
        
        override protected function configUI() : void {
            super.configUI();
            this.topShadow.mouseChildren = this.topShadow.mouseEnabled = false;
            this.bottomShadow.mouseChildren = this.bottomShadow.mouseEnabled = false;
        }
        
        override protected function onDispose() : void {
            super.onDispose();
            this.topShadow = null;
            this.bottomShadow = null;
        }
        
        override protected function applyTargetChanges() : void {
            super.applyTargetChanges();
            if(target)
            {
                if(getChildIndex(target) > getChildIndex(this.topShadow))
                {
                    swapChildren(target,this.topShadow);
                }
                if(getChildIndex(target) > getChildIndex(this.bottomShadow))
                {
                    swapChildren(target,this.bottomShadow);
                }
            }
        }
    }
}
