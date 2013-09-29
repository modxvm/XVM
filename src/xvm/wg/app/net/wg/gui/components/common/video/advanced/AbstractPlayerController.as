package net.wg.gui.components.common.video.advanced 
{
    import net.wg.gui.components.common.video.*;
    
    public class AbstractPlayerController extends Object
    {
        public function AbstractPlayerController(arg1:net.wg.gui.components.common.video.SimpleVideoPlayer)
        {
            super();
            this.videoPlayer = arg1;
            return;
        }

        public function dispose():void
        {
            this.videoPlayer = null;
            return;
        }

        protected var videoPlayer:net.wg.gui.components.common.video.SimpleVideoPlayer;
    }
}
