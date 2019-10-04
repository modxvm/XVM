package net.wg.gui.bootcamp
{
    import net.wg.infrastructure.base.meta.impl.BCOverlayFinalWindowMeta;
    import net.wg.infrastructure.base.meta.IBCOverlayFinalWindowMeta;
    import flash.display.MovieClip;
    import net.wg.gui.bootcamp.interfaces.IAnimatedMovieClip;
    import flash.geom.Point;

    public class BCOverlayFinalWindow extends BCOverlayFinalWindowMeta implements IBCOverlayFinalWindowMeta
    {

        private static const SMALL_SCALE:Number = 0.78;

        private static const POSITION_PERCENT:Number = 0.1;

        private static const VICTORY_STATE:int = 1;

        private static const DRAW:int = 0;

        private static const DEFEAT:int = 2;

        private static const STAGE_RESIZED:String = "stageResized";

        private static const SMALL_STAGE_HEIGHT:int = 1000;

        public var background:MovieClip = null;

        public var victory:IAnimatedMovieClip = null;

        public var defeat:IAnimatedMovieClip = null;

        private var _stageDimensions:Point;

        public function BCOverlayFinalWindow()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            if(!this._stageDimensions)
            {
                this._stageDimensions = new Point();
            }
            this._stageDimensions.x = param1;
            this._stageDimensions.y = param2;
            invalidate(STAGE_RESIZED);
        }

        override protected function onDispose() : void
        {
            this._stageDimensions = null;
            this.defeat.dispose();
            this.victory.dispose();
            this.defeat = null;
            this.victory = null;
            this.background.addFrameScript(this.background.totalFrames - 1,null);
            this.background = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._stageDimensions && isInvalid(STAGE_RESIZED))
            {
                this.victory.y = this.defeat.y = POSITION_PERCENT * this._stageDimensions.y >> 0;
                if(this._stageDimensions.y <= SMALL_STAGE_HEIGHT)
                {
                    this.victory.scaleX = this.victory.scaleY = this.defeat.scaleX = this.defeat.scaleY = SMALL_SCALE;
                }
                this.victory.x = this.defeat.x = this._stageDimensions.x >> 1;
                this.background.width = this._stageDimensions.x;
                this.background.height = this._stageDimensions.y;
            }
        }

        public function as_msgTypeHandler(param1:Number, param2:String) : void
        {
            this.background.gotoAndPlay(1);
            if(param1 == VICTORY_STATE)
            {
                this.victory.gotoAndPlay(1);
                this.defeat.gotoAndStop(1);
                this.defeat.visible = false;
                this.victory.text = param2;
            }
            else if(param1 == DRAW || param1 == DEFEAT)
            {
                this.victory.gotoAndStop(1);
                this.victory.visible = false;
                this.defeat.gotoAndPlay(1);
                this.defeat.text = param2;
            }
            this.background.addFrameScript(this.background.totalFrames - 1,this.goMsgFinishHandler);
        }

        private function goMsgFinishHandler() : void
        {
            this.background.stop();
            animFinishS();
        }
    }
}
