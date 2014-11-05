package net.wg.gui.components.common.video.advanced
{
    import flash.utils.Timer;
    import scaleform.clik.events.SliderEvent;
    import flash.events.Event;
    import net.wg.gui.components.common.video.VideoPlayerStatusEvent;
    import net.wg.gui.components.common.video.PlayerStatus;
    import flash.events.TimerEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.components.common.video.VideoPlayerEvent;
    import net.wg.gui.components.common.video.SimpleVideoPlayer;
    
    public class ControlBarController extends AbstractPlayerController
    {
        
        public function ControlBarController(param1:SimpleVideoPlayer, param2:VideoPlayerControlBar)
        {
            super(param1);
            this.controlBar = param2;
            videoPlayer.addEventListener(VideoPlayerStatusEvent.STATUS_CHANGED,this.videoPlayerStatusHandler,false,0,true);
            videoPlayer.addEventListener(VideoPlayerEvent.VOLUME_CHANGED,this.volumeChangeHandler,false,0,true);
            videoPlayer.addEventListener(VideoPlayerEvent.META_DATA_CHANGED,this.videoMetaDataChangeHandler,false,0,true);
            this.controlBar.playButton.addEventListener(ButtonEvent.CLICK,this.playButtonClickHandler,false,0,true);
            this.controlBar.repeatButton.addEventListener(ButtonEvent.CLICK,this.repeatButtonClickHandler,false,0,true);
            this.controlBar.soundSlider.addEventListener(SliderEvent.VALUE_CHANGE,this.soundSliderChangeHandler,false,0,true);
            this.volumeChangeHandler(null);
        }
        
        private static var DISPLAY_TIMER_UPDATE_DELAY:int = 200;
        
        private var controlBar:VideoPlayerControlBar;
        
        private var timer:Timer;
        
        private function soundSliderChangeHandler(param1:SliderEvent) : void
        {
            videoPlayer.volume = this.controlBar.volume;
        }
        
        private function videoMetaDataChangeHandler(param1:Event) : void
        {
            this.controlBar.totalTime = videoPlayer.metaData.duration;
        }
        
        private function videoPlayerStatusHandler(param1:VideoPlayerStatusEvent) : void
        {
            var _loc2_:uint = videoPlayer.status;
            if(_loc2_ == PlayerStatus.PLAYING)
            {
                if(!this.timer)
                {
                    this.timer = new Timer(DISPLAY_TIMER_UPDATE_DELAY);
                }
                this.timer.addEventListener(TimerEvent.TIMER,this.updateTime,false,0,true);
                this.timer.reset();
                this.timer.start();
            }
            else
            {
                this.stopTimer();
            }
            this.controlBar.playButton.enabled = !(_loc2_ == PlayerStatus.STOP && videoPlayer.currentTime == 0);
            this.controlBar.showPlayBtn = !(_loc2_ == PlayerStatus.PLAYING);
            this.controlBar.enabled = !(_loc2_ == PlayerStatus.LOADING);
        }
        
        private function stopTimer() : void
        {
            if(this.timer)
            {
                this.timer.removeEventListener(TimerEvent.TIMER,this.updateTime);
                this.timer.stop();
            }
        }
        
        private function updateTime(param1:TimerEvent) : void
        {
            this.controlBar.currentTime = videoPlayer.currentTime;
        }
        
        private function volumeChangeHandler(param1:Event) : void
        {
            this.controlBar.volume = videoPlayer.volume;
        }
        
        private function playButtonClickHandler(param1:ButtonEvent) : void
        {
            videoPlayer.togglePlayback();
        }
        
        private function repeatButtonClickHandler(param1:ButtonEvent) : void
        {
            videoPlayer.runPlayback();
            this.controlBar.currentTime = 0;
        }
        
        override protected function onDispose() : void
        {
            this.stopTimer();
            this.timer = null;
            this.controlBar.playButton.removeEventListener(ButtonEvent.CLICK,this.playButtonClickHandler);
            this.controlBar.repeatButton.removeEventListener(ButtonEvent.CLICK,this.repeatButtonClickHandler);
            this.controlBar.soundSlider.removeEventListener(SliderEvent.VALUE_CHANGE,this.soundSliderChangeHandler);
            videoPlayer.removeEventListener(VideoPlayerStatusEvent.STATUS_CHANGED,this.videoPlayerStatusHandler);
            videoPlayer.removeEventListener(VideoPlayerEvent.VOLUME_CHANGED,this.volumeChangeHandler);
            videoPlayer.removeEventListener(VideoPlayerEvent.META_DATA_CHANGED,this.videoMetaDataChangeHandler);
            super.onDispose();
        }
    }
}
