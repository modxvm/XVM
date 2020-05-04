package net.wg.gui.lobby.eventHangar.components
{
    import net.wg.gui.components.common.video.SimpleVideoPlayer;
    import flash.media.Video;

    public class EventBannerVideoPlayer extends SimpleVideoPlayer
    {

        public function EventBannerVideoPlayer()
        {
            super();
            video = new Video(1024,768);
            addChild(video);
        }
    }
}
