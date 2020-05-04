package net.wg.gui.lobby.eventHangar.components
{
    import net.wg.infrastructure.base.meta.impl.SE20BannerMeta;
    import net.wg.gui.lobby.hangar.eventEntryPoint.IEventEntryPoint;
    import net.wg.infrastructure.base.meta.ISE20BannerMeta;
    import net.wg.gui.components.common.video.SimpleVideoPlayer;
    import net.wg.gui.lobby.eventHangar.events.HangarBannerEvent;
    import net.wg.gui.lobby.eventHangar.components.constants.EventBannerStates;
    import flash.utils.clearTimeout;
    import net.wg.gui.lobby.eventHangar.data.EventProgressBannerVO;
    import flash.utils.setTimeout;
    import net.wg.gui.components.common.video.VideoPlayerEvent;
    import flash.events.Event;

    public class EventBanner extends SE20BannerMeta implements IEventEntryPoint, ISE20BannerMeta
    {

        private static const BANNER_VISIBLE_DELAY:int = 800;

        private static const VIDEO_PLAYER_LINKAGE:String = "EventBannerVideoPlayer_UI";

        private static const SMALL_BANNER_X:int = -51;

        private static const SMALL_BANNER_Y:int = -59;

        private static const SMALL_BANNER_WIDTH:int = 262;

        private static const SMALL_BANNER_HEIGHT:int = 240;

        private static const BIG_BANNER_X:int = -70;

        private static const BIG_BANNER_Y:int = -70;

        private static const BIG_BANNER_WIDTH:int = 361;

        private static const BIG_BANNER_HEIGHT:int = 282;

        public var banner:EventProgressBanner = null;

        private var _state:String = null;

        private var _videoPlayer:SimpleVideoPlayer = null;

        private var _timeoutID:uint = 0;

        private var _isShown:Boolean = false;

        public function EventBanner()
        {
            super();
            this.banner.visible = false;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.banner.addEventListener(HangarBannerEvent.BANNER_CLICK,this.onBannerClickHandler);
        }

        public function set isSmall(param1:Boolean) : void
        {
            this.setState(param1?EventBannerStates.BANNER_STATE_SMALL:EventBannerStates.BANNER_STATE_BIG);
        }

        override protected function onBeforeDispose() : void
        {
            this.banner.removeEventListener(HangarBannerEvent.BANNER_CLICK,this.onBannerClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            clearTimeout(this._timeoutID);
            this.banner.dispose();
            this.banner = null;
            this.disposeVideoPlayer();
            super.onDispose();
        }

        override protected function setData(param1:EventProgressBannerVO) : void
        {
            this.banner.setData(param1);
        }

        public function setState(param1:String) : void
        {
            this.banner.setState(param1);
            setSize(this.banner.getWidth(),this.banner.getHeight());
            this._state = param1;
        }

        public function as_show(param1:Boolean, param2:Boolean) : void
        {
            if(this._isShown)
            {
                return;
            }
            this._isShown = true;
            this.banner.isAnimated = param2;
            if(param1)
            {
                this.createVideoPlayer();
                this._timeoutID = setTimeout(this.showBanner,BANNER_VISIBLE_DELAY);
            }
            else
            {
                this.showBanner();
            }
        }

        private function createVideoPlayer() : void
        {
            this._videoPlayer = App.utils.classFactory.getComponent(VIDEO_PLAYER_LINKAGE,EventBannerVideoPlayer);
            if(this._state == EventBannerStates.BANNER_STATE_BIG)
            {
                this._videoPlayer.x = BIG_BANNER_X;
                this._videoPlayer.y = BIG_BANNER_Y;
                this._videoPlayer.setActualSize(BIG_BANNER_WIDTH,BIG_BANNER_HEIGHT);
            }
            else
            {
                this._videoPlayer.x = SMALL_BANNER_X;
                this._videoPlayer.y = SMALL_BANNER_Y;
                this._videoPlayer.setActualSize(SMALL_BANNER_WIDTH,SMALL_BANNER_HEIGHT);
            }
            addChild(this._videoPlayer);
            this._videoPlayer.mouseEnabled = this._videoPlayer.mouseChildren = false;
            this._videoPlayer.addEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.videoPlayerStopHandler);
            this._videoPlayer.source = VIDEOS_CONSTANTS.FLASH_VIDEOS_EVENT_BANNERSTART;
        }

        private function disposeVideoPlayer() : void
        {
            if(this._videoPlayer != null)
            {
                removeChild(this._videoPlayer);
                this._videoPlayer.removeEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.videoPlayerStopHandler);
                this._videoPlayer.dispose();
                this._videoPlayer = null;
            }
        }

        private function showBanner() : void
        {
            this.banner.visible = true;
        }

        private function videoPlayerStopHandler(param1:Event) : void
        {
            this.disposeVideoPlayer();
        }

        private function onBannerClickHandler(param1:Event) : void
        {
            onClickS();
        }
    }
}
