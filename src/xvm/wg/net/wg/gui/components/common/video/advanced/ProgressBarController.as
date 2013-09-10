package net.wg.gui.components.common.video.advanced 
{
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.components.common.video.*;
    
    public class ProgressBarController extends net.wg.gui.components.common.video.advanced.AbstractPlayerController
    {
        public function ProgressBarController(arg1:net.wg.gui.components.common.video.SimpleVideoPlayer, arg2:net.wg.gui.components.common.video.advanced.AbstractPlayerProgressBar)
        {
            super(arg1);
            this.progressBar = arg2;
            this.progressBar.addEventListener(net.wg.gui.components.common.video.advanced.ProgressBarEvent.POSITION_UPDATED, this.progressBarUpdatePositionHandler, false, 0, true);
            this.progressBar.addEventListener(net.wg.gui.components.common.video.advanced.AbstractPlayerProgressBar.UNDER_USING_STATE, this.underUsingStateChangedHandler, false, 0, true);
            this.progressBar.addEventListener(flash.events.Event.ENTER_FRAME, this.updateHandler, false, 0, true);
            videoPlayer.addEventListener(net.wg.gui.components.common.video.VideoPlayerEvent.SEEK_START, this.seekStartHandler, false, 0, true);
            videoPlayer.addEventListener(net.wg.gui.components.common.video.VideoPlayerEvent.SEEK_COMPLETE, this.seekCompleteHandler, false, 0, true);
            return;
        }

        internal function seekCompleteHandler(arg1:flash.events.Event):void
        {
            this.progressBar.addEventListener(flash.events.Event.ENTER_FRAME, this.updateHandler, false, 0, true);
            return;
        }

        internal function seekStartHandler(arg1:flash.events.Event):void
        {
            this.progressBar.removeEventListener(flash.events.Event.ENTER_FRAME, this.updateHandler);
            return;
        }

        internal function underUsingStateChangedHandler(arg1:flash.events.Event):void
        {
            if (this.progressBar.underUsing) 
            {
                videoPlayer.pausePlayback();
                this.startSeekingByCoolDown();
            }
            else 
            {
                videoPlayer.resumePlayback();
                this.stopSeekingByCoolDown();
                this.invokeSeeking(null);
            }
            return;
        }

        internal function startSeekingByCoolDown():void
        {
            if (!this.timer) 
                this.timer = new flash.utils.Timer(SEEK_INVOKE_COOLDOWN_TIME);
            this.timer.addEventListener(flash.events.TimerEvent.TIMER, this.invokeSeeking, false, 0, true);
            this.timer.start();
            return;
        }

        internal function stopSeekingByCoolDown():void
        {
            if (this.timer) 
            {
                this.timer.removeEventListener(flash.events.TimerEvent.TIMER, this.invokeSeeking);
                this.timer.stop();
            }
            return;
        }

        internal function invokeSeeking(arg1:flash.events.TimerEvent):void
        {
            var loc1:*=roundDecimal(this.progressBarPosition * videoPlayer.metaData.duration, 2);
            if (videoPlayer.status == net.wg.gui.components.common.video.PlayerStatus.STOP) 
                videoPlayer.runPlayback();
            videoPlayer.seek(loc1);
            return;
        }

        internal function updateHandler(arg1:flash.events.Event):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (!this.progressBar.underUsing) 
            {
                loc1 = isNaN(videoPlayer.currentTime) ? 0 : videoPlayer.currentTime;
                loc2 = videoPlayer.metaData ? videoPlayer.metaData.duration : 0;
                this.progressBar.position = roundDecimal(loc1 / loc2, 2);
            }
            return;
        }

        internal function progressBarUpdatePositionHandler(arg1:net.wg.gui.components.common.video.advanced.ProgressBarEvent):void
        {
            this.progressBarPosition = arg1.position;
            if (!this.progressBar.underUsing) 
                this.invokeSeeking(null);
            return;
        }

        public override function dispose():void
        {
            this.stopSeekingByCoolDown();
            this.progressBar.removeEventListener(net.wg.gui.components.common.video.advanced.ProgressBarEvent.POSITION_UPDATED, this.progressBarUpdatePositionHandler);
            this.progressBar.removeEventListener(net.wg.gui.components.common.video.advanced.AbstractPlayerProgressBar.UNDER_USING_STATE, this.underUsingStateChangedHandler);
            this.progressBar.removeEventListener(flash.events.Event.ENTER_FRAME, this.updateHandler);
            videoPlayer.removeEventListener(net.wg.gui.components.common.video.VideoPlayerEvent.SEEK_START, this.seekStartHandler);
            videoPlayer.removeEventListener(net.wg.gui.components.common.video.VideoPlayerEvent.SEEK_COMPLETE, this.seekCompleteHandler);
            this.progressBar = null;
            super.dispose();
            return;
        }

        public static function roundDecimal(arg1:Number, arg2:int):Number
        {
            var loc1:*=Math.pow(10, arg2);
            return Math.round(loc1 * arg1) / loc1;
        }

        internal static const SEEK_INVOKE_COOLDOWN_TIME:uint=500;

        internal var progressBar:net.wg.gui.components.common.video.advanced.AbstractPlayerProgressBar;

        internal var timer:flash.utils.Timer;

        internal var progressBarPosition:Number;
    }
}
