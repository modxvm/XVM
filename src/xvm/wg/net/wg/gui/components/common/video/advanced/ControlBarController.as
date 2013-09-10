package net.wg.gui.components.common.video.advanced 
{
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.components.common.video.*;
    import scaleform.clik.events.*;
    
    public class ControlBarController extends net.wg.gui.components.common.video.advanced.AbstractPlayerController
    {
        public function ControlBarController(arg1:net.wg.gui.components.common.video.SimpleVideoPlayer, arg2:net.wg.gui.components.common.video.advanced.VideoPlayerControlBar)
        {
            super(arg1);
            this.controlBar = arg2;
            videoPlayer.addEventListener(net.wg.gui.components.common.video.VideoPlayerStatusEvent.STATUS_CHANGED, this.videoPlayerStatusHandler, false, 0, true);
            videoPlayer.addEventListener(net.wg.gui.components.common.video.VideoPlayerEvent.VOLUME_CHANGED, this.volumeChangeHandler, false, 0, true);
            videoPlayer.addEventListener(net.wg.gui.components.common.video.VideoPlayerEvent.META_DATA_CHANGED, this.videoMetaDataChangeHandler, false, 0, true);
            this.controlBar.playButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.playButtonClickHandler, false, 0, true);
            this.controlBar.repeatButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.repeatButtonClickHandler, false, 0, true);
            this.controlBar.soundSlider.addEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.soundSliderChangeHandler, false, 0, true);
            this.volumeChangeHandler(null);
            return;
        }

        internal function soundSliderChangeHandler(arg1:scaleform.clik.events.SliderEvent):void
        {
            videoPlayer.volume = this.controlBar.volume;
            return;
        }

        internal function videoMetaDataChangeHandler(arg1:flash.events.Event):void
        {
            this.controlBar.totalTime = videoPlayer.metaData.duration;
            return;
        }

        internal function videoPlayerStatusHandler(arg1:net.wg.gui.components.common.video.VideoPlayerStatusEvent):void
        {
            var loc1:*=0;
            loc1 = videoPlayer.status;
            if (loc1 != net.wg.gui.components.common.video.PlayerStatus.PLAYING) 
            {
                this.stopTimer();
            }
            else 
            {
                if (!this.timer) 
                {
                    this.timer = new flash.utils.Timer(DISPLAY_TIMER_UPDATE_DELAY);
                }
                this.timer.addEventListener(flash.events.TimerEvent.TIMER, this.updateTime, false, 0, true);
                this.timer.reset();
                this.timer.start();
            }
            this.controlBar.playButton.enabled = !(loc1 == net.wg.gui.components.common.video.PlayerStatus.STOP && videoPlayer.currentTime == 0);
            this.controlBar.showPlayBtn = !(loc1 == net.wg.gui.components.common.video.PlayerStatus.PLAYING);
            this.controlBar.enabled = !(loc1 == net.wg.gui.components.common.video.PlayerStatus.LOADING);
            return;
        }

        internal function stopTimer():void
        {
            if (this.timer) 
            {
                this.timer.removeEventListener(flash.events.TimerEvent.TIMER, this.updateTime);
                this.timer.stop();
            }
            return;
        }

        internal function updateTime(arg1:flash.events.TimerEvent):void
        {
            this.controlBar.currentTime = videoPlayer.currentTime;
            return;
        }

        internal function volumeChangeHandler(arg1:flash.events.Event):void
        {
            this.controlBar.volume = videoPlayer.volume;
            return;
        }

        internal function playButtonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            videoPlayer.togglePlayback();
            return;
        }

        internal function repeatButtonClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            videoPlayer.runPlayback();
            this.controlBar.currentTime = 0;
            return;
        }

        public override function dispose():void
        {
            this.stopTimer();
            this.timer = null;
            this.controlBar.playButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.playButtonClickHandler);
            this.controlBar.repeatButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.repeatButtonClickHandler);
            this.controlBar.soundSlider.removeEventListener(scaleform.clik.events.SliderEvent.VALUE_CHANGE, this.soundSliderChangeHandler);
            videoPlayer.removeEventListener(net.wg.gui.components.common.video.VideoPlayerStatusEvent.STATUS_CHANGED, this.videoPlayerStatusHandler);
            videoPlayer.removeEventListener(net.wg.gui.components.common.video.VideoPlayerEvent.VOLUME_CHANGED, this.volumeChangeHandler);
            videoPlayer.removeEventListener(net.wg.gui.components.common.video.VideoPlayerEvent.META_DATA_CHANGED, this.videoMetaDataChangeHandler);
            super.dispose();
            return;
        }

        internal static const DISPLAY_TIMER_UPDATE_DELAY:int=200;

        internal var controlBar:net.wg.gui.components.common.video.advanced.VideoPlayerControlBar;

        internal var timer:flash.utils.Timer;
    }
}
