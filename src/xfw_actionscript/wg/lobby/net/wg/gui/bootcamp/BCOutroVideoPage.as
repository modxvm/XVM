package net.wg.gui.bootcamp
{
    import net.wg.infrastructure.base.meta.impl.BCOutroVideoPageMeta;
    import net.wg.infrastructure.base.meta.IBCOutroVideoPageMeta;
    import net.wg.gui.components.common.video.SimpleVideoPlayer;
    import flash.display.MovieClip;
    import flash.geom.Point;
    import net.wg.gui.components.common.video.VideoPlayerEvent;
    import net.wg.gui.components.common.video.VideoPlayerStatusEvent;
    import org.idmedia.as3commons.util.StringUtils;

    public class BCOutroVideoPage extends BCOutroVideoPageMeta implements IBCOutroVideoPageMeta
    {

        private static const INTRO_INFO_CHANGED:String = "infoChanged";

        private static const STAGE_RESIZED:String = "stageResized";

        public var videoPlayer:SimpleVideoPlayer;

        public var blackBG:MovieClip;

        private var _introInfo:BCOutroVideoVO;

        private var _playerOriginalWidth:Number;

        private var _playerOriginalHeight:Number;

        private var _playerOriginalScaleX:Number;

        private var _playerOriginalScaleY:Number;

        private var _stageDimensions:Point;

        public function BCOutroVideoPage()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            if(this._stageDimensions == null)
            {
                this._stageDimensions = new Point();
            }
            this._stageDimensions.x = param1;
            this._stageDimensions.y = param2;
            invalidate(STAGE_RESIZED);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this._playerOriginalWidth = this.videoPlayer.width;
            this._playerOriginalHeight = this.videoPlayer.height;
            this._playerOriginalScaleX = this.videoPlayer.scaleX;
            this._playerOriginalScaleY = this.videoPlayer.scaleY;
            this.videoPlayer.addEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.onVideoPlayerPlaybackStoppedHandler);
            this.videoPlayer.addEventListener(VideoPlayerStatusEvent.ERROR,this.onVideoPlayerErrorHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._introInfo && isInvalid(INTRO_INFO_CHANGED))
            {
                if(StringUtils.isNotEmpty(this._introInfo.source))
                {
                    this.videoPlayer.volume = this._introInfo.volume;
                    this.videoPlayer.source = this._introInfo.source;
                }
                else
                {
                    videoFinishedS();
                }
            }
            if(this._stageDimensions != null && isInvalid(STAGE_RESIZED))
            {
                this.videoPlayer.scaleX = this.videoPlayer.scaleY = Math.max(this._playerOriginalScaleX * this._stageDimensions.x / this._playerOriginalWidth,this._playerOriginalScaleY * this._stageDimensions.y / this._playerOriginalHeight);
                this.blackBG.width = this._stageDimensions.x;
                this.blackBG.height = this._stageDimensions.y;
            }
        }

        override protected function onDispose() : void
        {
            this.videoPlayer.removeEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.onVideoPlayerPlaybackStoppedHandler);
            this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.ERROR,this.onVideoPlayerErrorHandler);
            this.videoPlayer.dispose();
            this.videoPlayer = null;
            this.blackBG = null;
            this._stageDimensions = null;
            this._introInfo.dispose();
            this._introInfo = null;
            super.onDispose();
        }

        override protected function playVideo(param1:BCOutroVideoVO) : void
        {
            this._introInfo = param1;
            invalidate(INTRO_INFO_CHANGED);
        }

        private function onVideoPlayerPlaybackStoppedHandler(param1:VideoPlayerEvent) : void
        {
            videoFinishedS();
        }

        private function onVideoPlayerErrorHandler(param1:VideoPlayerStatusEvent) : void
        {
            handleErrorS(param1.errorCode);
        }
    }
}
