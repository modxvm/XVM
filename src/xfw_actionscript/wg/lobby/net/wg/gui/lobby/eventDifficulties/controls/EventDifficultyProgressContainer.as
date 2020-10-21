package net.wg.gui.lobby.eventDifficulties.controls
{
    import net.wg.gui.components.common.FrameStateCmpnt;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventDifficultyProgressContainer extends FrameStateCmpnt
    {

        private static const CONDITION_TF_OFFSET1:int = 100;

        private static const CONDITION_TF_OFFSET2:int = 216;

        private static const LEVEL2:int = 2;

        private static const LEVEL3:int = 3;

        private static const STATE_BIG:String = "big";

        private static const STATE_SMALL:String = "small";

        private static const SMALL_HEIGHT:int = 900;

        private static const SMALL_WIDTH:int = 1500;

        public var progressBar:MovieClip = null;

        public var conditionTF:TextField = null;

        private var _progress:int = 1;

        private var _level:int = 1;

        private var _condition:String = "";

        private var _isSmallSize:Boolean = false;

        private var _frameLabel:String = "big";

        public function EventDifficultyProgressContainer()
        {
            super();
        }

        public function setProgress(param1:int, param2:String, param3:int) : void
        {
            this._progress = param1;
            this._condition = param2;
            this._level = param3;
            invalidateData();
        }

        public function udpateSize(param1:Number, param2:Number) : void
        {
            this._isSmallSize = param1 < SMALL_WIDTH || param2 < SMALL_HEIGHT;
            this._frameLabel = this._isSmallSize?STATE_SMALL:STATE_BIG;
            invalidateData();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                frameLabel = this._frameLabel;
                this.progressBar.gotoAndStop(this._progress);
                if(_baseDisposed)
                {
                    return;
                }
                if(StringUtils.isEmpty(this._condition) || this._level == LEVEL3)
                {
                    this.conditionTF.visible = false;
                }
                else
                {
                    this.conditionTF.visible = true;
                    this.conditionTF.htmlText = this._condition;
                }
                if(this._level == LEVEL2)
                {
                    this.conditionTF.x = this._isSmallSize?CONDITION_TF_OFFSET1:CONDITION_TF_OFFSET2;
                }
            }
        }

        override protected function onDispose() : void
        {
            this.progressBar = null;
            this.conditionTF = null;
            super.onDispose();
        }
    }
}
