package net.wg.gui.prebattle.squads.event
{
    import net.wg.gui.components.controls.DropDownListItemRendererSound;
    import net.wg.gui.components.common.FrameStateCmpnt;
    import flash.display.MovieClip;
    import net.wg.utils.ICommons;
    import net.wg.gui.prebattle.squads.event.data.EventSquadDifficultyRendererVO;
    import scaleform.clik.constants.InvalidationType;

    public class EventSquadDifficultyRenderer extends DropDownListItemRendererSound
    {

        private static const DIFFICULTY_LABEL:String = "difficulty";

        private static const SELECTED_LABEL:String = "Selected";

        public var difficultyStars:FrameStateCmpnt = null;

        public var infoIcon:MovieClip = null;

        public var lockIcon:MovieClip = null;

        private var _commons:ICommons;

        public function EventSquadDifficultyRenderer()
        {
            this._commons = App.utils.commons;
            super();
        }

        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            var _loc2_:EventSquadDifficultyRendererVO = EventSquadDifficultyRendererVO(param1);
            if(_loc2_)
            {
                this.difficultyStars.frameLabel = selected?DIFFICULTY_LABEL + _loc2_.difficultyLevel + SELECTED_LABEL:DIFFICULTY_LABEL + _loc2_.difficultyLevel;
                enabled = !_loc2_.disabled;
            }
        }

        override protected function draw() : void
        {
            var _loc1_:EventSquadDifficultyRendererVO = null;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                _loc1_ = EventSquadDifficultyRendererVO(data);
                if(_loc1_)
                {
                    this.infoIcon.visible = _loc1_.showInfoIcon;
                    this.lockIcon.visible = _loc1_.showLockIcon;
                }
            }
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabledOnDisabled = true;
            preventAutosizing = true;
            this.infoIcon.visible = false;
            this.lockIcon.visible = false;
            this._commons.updateChildrenMouseEnabled(this,false);
        }

        override protected function onDispose() : void
        {
            this.difficultyStars.dispose();
            this.difficultyStars = null;
            this.infoIcon = null;
            this.lockIcon = null;
            this._commons = null;
            super.onDispose();
        }
    }
}
