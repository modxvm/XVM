package net.wg.gui.components.common.video.advanced
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.common.video.SimpleVideoPlayer;
    
    public class AbstractPlayerController extends Object implements IDisposable
    {
        
        public function AbstractPlayerController(param1:SimpleVideoPlayer) {
            super();
            this.videoPlayer = param1;
        }
        
        protected var videoPlayer:SimpleVideoPlayer;
        
        public final function dispose() : void {
            this.onDispose();
        }
        
        protected function onDispose() : void {
            this.videoPlayer = null;
        }
    }
}
