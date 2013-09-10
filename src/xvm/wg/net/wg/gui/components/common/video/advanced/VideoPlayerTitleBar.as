package net.wg.gui.components.common.video.advanced 
{
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class VideoPlayerTitleBar extends scaleform.clik.core.UIComponent
    {
        public function VideoPlayerTitleBar()
        {
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            if (this.closeBtn) 
            {
                if (this.closeBtn.parent) 
                    this.closeBtn.parent.removeChild(this.closeBtn);
                this.closeBtn = null;
            }
            return;
        }

        public var closeBtn:net.wg.gui.components.controls.SoundButtonEx;
    }
}
