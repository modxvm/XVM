package net.wg.gui.lobby.eventDifficulties.controls
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import net.wg.gui.components.common.FrameStateCmpnt;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventDifficulties.data.EventDifficultyLevelVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.eventDifficulties.events.DifficultySelectionEvent;

    public class EventDifficultyButton extends SoundButtonEx
    {

        private static const DIFFICULTY_SELECTED_LABEL:String = "difficultySelected";

        private static const DIFFICULTY_ENABLED_LABEL:String = "difficultyEnabled";

        private static const DIFFICULTY_DISABLED_LABEL:String = "difficultyDisabled";

        public var titleTF:TextField = null;

        public var numPhasesTF:TextField = null;

        public var descriptionTF:TextField = null;

        public var statusTF:TextField = null;

        public var difficultyStars:FrameStateCmpnt = null;

        public var cardBg:MovieClip = null;

        private var _index:int = 0;

        private var _frameLabel:String = "";

        private var _vo:EventDifficultyLevelVO = null;

        public function EventDifficultyButton()
        {
            super();
        }

        public function setData(param1:EventDifficultyLevelVO) : void
        {
            this._vo = param1;
            this._index = this._vo.level;
            this.enabled = this._vo.enabled;
            this.selected = this._vo.selected;
            invalidateData();
        }

        override protected function configUI() : void
        {
            super.configUI();
            preventAutosizing = true;
            this.cardBg.stop();
        }

        override protected function draw() : void
        {
            var _loc1_:String = null;
            super.draw();
            if(this._vo && isInvalid(InvalidationType.DATA))
            {
                this.titleTF.htmlText = this._vo.title;
                this.numPhasesTF.htmlText = this._vo.numPhases;
                this.descriptionTF.htmlText = this._vo.description;
                _loc1_ = this._vo.enabled?EVENT.EVENT_DIFFICULTY_ENABLED:EVENT.EVENT_DIFFICULTY_DISABLED;
                this._frameLabel = this._vo.enabled?DIFFICULTY_ENABLED_LABEL:DIFFICULTY_DISABLED_LABEL;
                if(this._vo.selected && this._vo.enabled)
                {
                    _loc1_ = EVENT.EVENT_DIFFICULTY_SELECTED;
                    this._frameLabel = DIFFICULTY_SELECTED_LABEL;
                }
                this.difficultyStars.frameLabel = this._frameLabel + this._index.toString();
                this.cardBg.gotoAndStop(this._index);
                this.statusTF.text = _loc1_;
            }
        }

        override protected function handleClick(param1:uint = 0) : void
        {
            super.handleClick(param1);
            this.selected = true;
            this.difficultyStars.frameLabel = DIFFICULTY_SELECTED_LABEL + this._index.toString();
            dispatchEvent(new DifficultySelectionEvent(DifficultySelectionEvent.DIFFICULTY_BUTTON_CLICK,this._index));
        }

        override protected function onDispose() : void
        {
            this._vo = null;
            this.titleTF = null;
            this.numPhasesTF = null;
            this.descriptionTF = null;
            this.statusTF = null;
            this.cardBg = null;
            this.difficultyStars.dispose();
            this.difficultyStars = null;
            super.onDispose();
        }
    }
}
