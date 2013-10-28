package net.wg.gui.components.common.video.advanced
{
   import net.wg.gui.components.common.video.SimpleVideoPlayer;


   public class AbstractPlayerController extends Object
   {
          
      public function AbstractPlayerController(param1:SimpleVideoPlayer) {
         super();
         this.videoPlayer = param1;
      }

      protected var videoPlayer:SimpleVideoPlayer;

      public function dispose() : void {
         this.videoPlayer = null;
      }
   }

}