package net.wg.gui.tutorial.windows 
{
    import flash.events.*;
    import net.wg.gui.components.common.video.*;
    import net.wg.gui.components.common.video.advanced.*;
    
    public class TutorialVideoDialog extends net.wg.gui.tutorial.windows.TutorialDialog
    {
        public function TutorialVideoDialog()
        {
            super();
            showWindowBg = false;
            canClose = false;
            canDrag = false;
            isModal = true;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.videoPlayer.addEventListener(net.wg.gui.components.common.video.advanced.AdvancedVideoPlayer.PLAYER_CLOSED, this.onVideoClosed);
            this.videoPlayer.addEventListener(net.wg.gui.components.common.video.VideoPlayerEvent.PLAYBACK_STOPPED, this.onVideoStopped);
            return;
        }

        internal function onVideoStopped(arg1:net.wg.gui.components.common.video.VideoPlayerEvent):void
        {
            if (this._isPopulated) 
            {
                onWindowCloseS();
            }
            return;
        }

        internal function onVideoClosed(arg1:flash.events.Event):void
        {
            onWindowCloseS();
            return;
        }

        protected override function drawData():void
        {
            super.drawData();
            this.videoPlayer.source = _data.message;
            this.videoPlayer.volume = _data.soundValue;
            this.videoPlayer.subtitleTrack = _data.subtitleTrack;
            this.videoPlayer.audioTrack = _data.audioTrack;
            this.videoPlayer.play();
            this._isPopulated = true;
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.getBackground().visible = false;
            window.getTitleBtn().visible = false;
            return;
        }

        protected override function onDispose():void
        {
            if (this.videoPlayer) 
            {
                this.videoPlayer.dispose();
                if (this.videoPlayer.parent) 
                {
                    this.videoPlayer.removeEventListener(net.wg.gui.components.common.video.advanced.AdvancedVideoPlayer.PLAYER_CLOSED, this.onVideoClosed);
                    this.videoPlayer.removeEventListener(net.wg.gui.components.common.video.VideoPlayerEvent.PLAYBACK_STOPPED, this.onVideoStopped);
                    this.videoPlayer.parent.removeChild(parent);
                }
                this.videoPlayer = null;
            }
            super.onDispose();
            return;
        }

        public var videoPlayer:net.wg.gui.components.common.video.advanced.AdvancedVideoPlayer;

        internal var _isPopulated:Boolean=false;
    }
}
