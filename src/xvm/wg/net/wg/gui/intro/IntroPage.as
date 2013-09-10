package net.wg.gui.intro 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import net.wg.gui.components.common.video.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.ui.*;
    
    public class IntroPage extends net.wg.infrastructure.base.meta.impl.IntroPageMeta implements net.wg.infrastructure.base.meta.IIntroPageMeta
    {
        public function IntroPage()
        {
            super();
            focusable = true;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.videoPlayer.addEventListener(net.wg.gui.components.common.video.VideoPlayerEvent.PLAYBACK_STOPPED, this.videoPlayerStopHandler, false, 0, true);
            this.videoPlayer.addEventListener(net.wg.gui.components.common.video.VideoPlayerStatusEvent.ERROR, this.videoPlayerErrorHandler, false, 0, true);
            stage.addEventListener(flash.events.MouseEvent.CLICK, this.clickMainHandler, false, 0, true);
            this.playerOriginalWidth = this.videoPlayer.width;
            this.playerOriginalHeight = this.videoPlayer.height;
            return;
        }

        internal function clickMainHandler(arg1:flash.events.MouseEvent):void
        {
            this.videoPlayer.stopPlayback();
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            if (!this.stageDimensions) 
                this.stageDimensions = new flash.geom.Point();
            this.stageDimensions.x = arg1;
            this.stageDimensions.y = arg2;
            invalidate(STAGE_RESIZED);
            return;
        }

        internal function videoPlayerStopHandler(arg1:net.wg.gui.components.common.video.VideoPlayerEvent):void
        {
            stopVideoS();
            return;
        }

        internal function videoPlayerErrorHandler(arg1:net.wg.gui.components.common.video.VideoPlayerStatusEvent):void
        {
            handleErrorS(arg1.errorCode);
            return;
        }

        public override function setViewSize(arg1:Number, arg2:Number):void
        {
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc2:*=NaN;
            super.handleInput(arg1);
            var loc1:*=arg1.details;
            if (loc1.value != scaleform.clik.constants.InputValue.KEY_UP) 
            {
                loc2 = loc1.code;
                if (loc2 == flash.ui.Keyboard.ESCAPE || loc2 == flash.ui.Keyboard.ENTER || loc2 == flash.ui.Keyboard.SPACE) 
                {
                    arg1.handled = true;
                    this.videoPlayer.stopPlayback();
                }
            }
            return;
        }

        public function as_playVideo(arg1:Object):void
        {
            this.introInfo = new net.wg.gui.intro.IntroInfoVO(arg1);
            invalidate(INTRO_INFO_CHANGED);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INTRO_INFO_CHANGED)) 
                if (this.introInfo) 
                {
                    this.videoPlayer.volume = this.introInfo.volume;
                    this.videoPlayer.source = this.introInfo.source;
                }
            if (isInvalid(STAGE_RESIZED)) 
                if (this.stageDimensions) 
                    net.wg.gui.intro.IntroPage.imitateNoBorderScaleMode(this, this.stageDimensions.x, this.stageDimensions.y, this.playerOriginalWidth, this.playerOriginalHeight);
            return;
        }

        protected override function onDispose():void
        {
            if (this.videoPlayer) 
            {
                this.videoPlayer.removeEventListener(net.wg.gui.components.common.video.VideoPlayerStatusEvent.STATUS_CHANGED, this.videoPlayerStopHandler);
                this.videoPlayer.removeEventListener(net.wg.gui.components.common.video.VideoPlayerStatusEvent.ERROR, this.videoPlayerErrorHandler);
                this.videoPlayer.dispose();
                if (this.videoPlayer.parent) 
                    this.videoPlayer.parent.removeChild(this.videoPlayer);
                this.videoPlayer = null;
            }
            if (stage) 
                stage.removeEventListener(flash.events.MouseEvent.CLICK, this.clickMainHandler);
            super.onDispose();
            return;
        }

        internal static function imitateNoBorderScaleMode(arg1:flash.display.DisplayObject, arg2:Number, arg3:Number, arg4:Number, arg5:Number):void
        {
            var loc1:*;
            arg1.scaleY = loc1 = Math.max(arg2 / arg4, arg3 / arg5);
            arg1.scaleX = loc1;
            arg1.x = arg2 - arg1.width >> 1;
            arg1.y = arg3 - arg1.height >> 1;
            return;
        }

        internal static const INTRO_INFO_CHANGED:String="infoChanged";

        internal static const STAGE_RESIZED:String="stageResized";

        public var videoPlayer:net.wg.gui.components.common.video.SimpleVideoPlayer;

        internal var introInfo:net.wg.gui.intro.IntroInfoVO;

        internal var playerOriginalWidth:Number;

        internal var playerOriginalHeight:Number;

        internal var stageDimensions:flash.geom.Point;
    }
}
