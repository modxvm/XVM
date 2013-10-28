package net.wg.gui.intro
{
   import net.wg.infrastructure.base.meta.impl.IntroPageMeta;
   import net.wg.infrastructure.base.meta.IIntroPageMeta;
   import flash.display.DisplayObject;
   import net.wg.gui.components.common.video.SimpleVideoPlayer;
   import flash.geom.Point;
   import net.wg.gui.components.common.video.VideoPlayerEvent;
   import net.wg.gui.components.common.video.VideoPlayerStatusEvent;
   import flash.events.MouseEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import scaleform.clik.constants.InputValue;
   import flash.ui.Keyboard;


   public class IntroPage extends IntroPageMeta implements IIntroPageMeta
   {
          
      public function IntroPage() {
         super();
         focusable = true;
      }

      private static const INTRO_INFO_CHANGED:String = "infoChanged";

      private static const STAGE_RESIZED:String = "stageResized";

      private static function imitateNoBorderScaleMode(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:Number) : void {
         param1.scaleX = param1.scaleY = Math.max(param2 / param4,param3 / param5);
         param1.x = param2 - param1.width >> 1;
         param1.y = param3 - param1.height >> 1;
      }

      public var videoPlayer:SimpleVideoPlayer;

      private var introInfo:IntroInfoVO;

      private var playerOriginalWidth:Number;

      private var playerOriginalHeight:Number;

      private var stageDimensions:Point;

      override protected function configUI() : void {
         super.configUI();
         this.videoPlayer.addEventListener(VideoPlayerEvent.PLAYBACK_STOPPED,this.videoPlayerStopHandler,false,0,true);
         this.videoPlayer.addEventListener(VideoPlayerStatusEvent.ERROR,this.videoPlayerErrorHandler,false,0,true);
         stage.addEventListener(MouseEvent.CLICK,this.clickMainHandler,false,0,true);
         this.playerOriginalWidth = this.videoPlayer.width;
         this.playerOriginalHeight = this.videoPlayer.height;
      }

      private function clickMainHandler(param1:MouseEvent) : void {
         this.videoPlayer.stopPlayback();
      }

      override public function updateStage(param1:Number, param2:Number) : void {
         if(!this.stageDimensions)
         {
            this.stageDimensions = new Point();
         }
         this.stageDimensions.x = param1;
         this.stageDimensions.y = param2;
         invalidate(STAGE_RESIZED);
      }

      private function videoPlayerStopHandler(param1:VideoPlayerEvent) : void {
         stopVideoS();
      }

      private function videoPlayerErrorHandler(param1:VideoPlayerStatusEvent) : void {
         handleErrorS(param1.errorCode);
      }

      override public function setViewSize(param1:Number, param2:Number) : void {
          
      }

      override public function handleInput(param1:InputEvent) : void {
         var _loc3_:* = NaN;
         super.handleInput(param1);
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.value != InputValue.KEY_UP)
         {
            _loc3_ = _loc2_.code;
            if(_loc3_ == Keyboard.ESCAPE || _loc3_ == Keyboard.ENTER || _loc3_ == Keyboard.SPACE)
            {
               param1.handled = true;
               this.videoPlayer.stopPlayback();
            }
         }
      }

      public function as_playVideo(param1:Object) : void {
         this.introInfo = new IntroInfoVO(param1);
         invalidate(INTRO_INFO_CHANGED);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(INTRO_INFO_CHANGED))
         {
            if(this.introInfo)
            {
               this.videoPlayer.volume = this.introInfo.volume;
               this.videoPlayer.source = this.introInfo.source;
            }
         }
         if(isInvalid(STAGE_RESIZED))
         {
            if(this.stageDimensions)
            {
               IntroPage.imitateNoBorderScaleMode(this,this.stageDimensions.x,this.stageDimensions.y,this.playerOriginalWidth,this.playerOriginalHeight);
            }
         }
      }

      override protected function onDispose() : void {
         if(this.videoPlayer)
         {
            this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.STATUS_CHANGED,this.videoPlayerStopHandler);
            this.videoPlayer.removeEventListener(VideoPlayerStatusEvent.ERROR,this.videoPlayerErrorHandler);
            this.videoPlayer.dispose();
            if(this.videoPlayer.parent)
            {
               this.videoPlayer.parent.removeChild(this.videoPlayer);
            }
            this.videoPlayer = null;
         }
         if(stage)
         {
            stage.removeEventListener(MouseEvent.CLICK,this.clickMainHandler);
         }
         super.onDispose();
      }
   }

}