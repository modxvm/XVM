package net.wg.gui.components.common.video.advanced
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.SoundButtonEx;
    
    public class VideoPlayerTitleBar extends UIComponent
    {
        
        public function VideoPlayerTitleBar() {
            super();
        }
        
        public var closeBtn:SoundButtonEx;
        
        override protected function onDispose() : void {
            super.onDispose();
            if(this.closeBtn)
            {
                if(this.closeBtn.parent)
                {
                    this.closeBtn.parent.removeChild(this.closeBtn);
                }
                this.closeBtn = null;
            }
        }
    }
}
