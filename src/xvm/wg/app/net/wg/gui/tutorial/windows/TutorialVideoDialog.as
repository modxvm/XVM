package net.wg.gui.tutorial.windows
{
   import net.wg.gui.components.common.video.advanced.AdvancedVideoPlayer;
   import net.wg.gui.components.common.video.VideoPlayerEvent;
   import flash.events.Event;
   import scaleform.clik.utils.Padding;
   
   public class TutorialVideoDialog extends TutorialDialog
   {
      
      public function TutorialVideoDialog() {
         super();
         showWindowBg = false;
         canClose = false;
         canDrag = false;
         isModal = true;
         isCentered = true;
      }
      
      public var videoPlayer:AdvancedVideoPlayer;
      
      private var _isPopulated:Boolean = false;
      
      override protected function configUI() : void {
         super.configUI();
         this.videoPlayer.addEventListener(AdvancedVideoPlayer.PLAYER_CLOSED,this.onVideoClosed);
         this.videoPlayer.addEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.onVideoStopped);
      }
      
      private function onVideoStopped(param1:VideoPlayerEvent) : void {
         if(this._isPopulated)
         {
            onWindowCloseS();
         }
      }
      
      private function onVideoClosed(param1:Event) : void {
         onWindowCloseS();
      }
      
      override protected function drawData() : void {
         super.drawData();
         this.videoPlayer.source = _data.message;
         this.videoPlayer.volume = _data.soundValue;
         this.videoPlayer.subtitleTrack = _data.subtitleTrack;
         this.videoPlayer.audioTrack = _data.audioTrack;
         this.videoPlayer.play();
         this._isPopulated = true;
      }
      
      override protected function onPopulate() : void {
         super.onPopulate();
         window.getBackground().visible = false;
         window.getTitleBtn().visible = false;
         var _loc1_:Padding = window.contentPadding as Padding;
         _loc1_.top = 0;
         _loc1_.bottom = 0;
         _loc1_.left = 0;
         _loc1_.right = 0;
      }
      
      override protected function onDispose() : void {
         if(this.videoPlayer)
         {
            this.videoPlayer.dispose();
            if(this.videoPlayer.parent)
            {
               this.videoPlayer.removeEventListener(AdvancedVideoPlayer.PLAYER_CLOSED,this.onVideoClosed);
               this.videoPlayer.removeEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.onVideoStopped);
               this.videoPlayer.parent.removeChild(parent);
            }
            this.videoPlayer = null;
         }
         super.onDispose();
      }
   }
}
