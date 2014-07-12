package net.wg.gui.components.common.video.advanced
{
    import flash.utils.Timer;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import net.wg.gui.components.common.video.PlayerStatus;
    import net.wg.gui.components.common.video.VideoPlayerEvent;
    import net.wg.gui.components.common.video.SimpleVideoPlayer;
    
    public class ProgressBarController extends AbstractPlayerController
    {
        
        public function ProgressBarController(param1:SimpleVideoPlayer, param2:AbstractPlayerProgressBar) {
            super(param1);
            this.progressBar = param2;
            this.progressBar.addEventListener(ProgressBarEvent.POSITION_UPDATED,this.progressBarUpdatePositionHandler,false,0,true);
            this.progressBar.addEventListener(AbstractPlayerProgressBar.UNDER_USING_STATE,this.underUsingStateChangedHandler,false,0,true);
            this.progressBar.addEventListener(Event.ENTER_FRAME,this.updateHandler,false,0,true);
            videoPlayer.addEventListener(VideoPlayerEvent.SEEK_START,this.seekStartHandler,false,0,true);
            videoPlayer.addEventListener(VideoPlayerEvent.SEEK_COMPLETE,this.seekCompleteHandler,false,0,true);
        }
        
        private static var SEEK_INVOKE_COOLDOWN_TIME:uint = 500;
        
        public static function roundDecimal(param1:Number, param2:int) : Number {
            var _loc3_:Number = Math.pow(10,param2);
            return Math.round(_loc3_ * param1) / _loc3_;
        }
        
        private var progressBar:AbstractPlayerProgressBar;
        
        private var timer:Timer;
        
        private function seekCompleteHandler(param1:Event) : void {
            this.progressBar.addEventListener(Event.ENTER_FRAME,this.updateHandler,false,0,true);
        }
        
        private function seekStartHandler(param1:Event) : void {
            this.progressBar.removeEventListener(Event.ENTER_FRAME,this.updateHandler);
        }
        
        private function underUsingStateChangedHandler(param1:Event) : void {
            if(this.progressBar.underUsing)
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
        }
        
        private function startSeekingByCoolDown() : void {
            if(!this.timer)
            {
                this.timer = new Timer(SEEK_INVOKE_COOLDOWN_TIME);
            }
            this.timer.addEventListener(TimerEvent.TIMER,this.invokeSeeking,false,0,true);
            this.timer.start();
        }
        
        private function stopSeekingByCoolDown() : void {
            if(this.timer)
            {
                this.timer.removeEventListener(TimerEvent.TIMER,this.invokeSeeking);
                this.timer.stop();
            }
        }
        
        private function invokeSeeking(param1:TimerEvent) : void {
            var _loc2_:Number = roundDecimal(this.progressBarPosition * videoPlayer.metaData.duration,2);
            if(videoPlayer.status == PlayerStatus.STOP)
            {
                videoPlayer.runPlayback();
            }
            videoPlayer.seek(_loc2_);
        }
        
        private function updateHandler(param1:Event) : void {
            var _loc2_:* = NaN;
            var _loc3_:* = NaN;
            if(!this.progressBar.underUsing)
            {
                _loc2_ = !isNaN(videoPlayer.currentTime)?videoPlayer.currentTime:0;
                _loc3_ = videoPlayer.metaData?videoPlayer.metaData.duration:0;
                this.progressBar.position = roundDecimal(_loc2_ / _loc3_,2);
            }
        }
        
        private var progressBarPosition:Number;
        
        private function progressBarUpdatePositionHandler(param1:ProgressBarEvent) : void {
            this.progressBarPosition = param1.position;
            if(!this.progressBar.underUsing)
            {
                this.invokeSeeking(null);
            }
        }
        
        override protected function onDispose() : void {
            this.stopSeekingByCoolDown();
            this.progressBar.removeEventListener(ProgressBarEvent.POSITION_UPDATED,this.progressBarUpdatePositionHandler);
            this.progressBar.removeEventListener(AbstractPlayerProgressBar.UNDER_USING_STATE,this.underUsingStateChangedHandler);
            this.progressBar.removeEventListener(Event.ENTER_FRAME,this.updateHandler);
            videoPlayer.removeEventListener(VideoPlayerEvent.SEEK_START,this.seekStartHandler);
            videoPlayer.removeEventListener(VideoPlayerEvent.SEEK_COMPLETE,this.seekCompleteHandler);
            this.progressBar = null;
            super.onDispose();
        }
    }
}
