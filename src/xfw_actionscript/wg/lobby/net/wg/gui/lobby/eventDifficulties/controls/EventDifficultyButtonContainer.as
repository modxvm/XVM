package net.wg.gui.lobby.eventDifficulties.controls
{
    import net.wg.gui.components.common.FrameStateCmpnt;
    import net.wg.gui.lobby.eventDifficulties.data.EventDifficultyLevelVO;

    public class EventDifficultyButtonContainer extends FrameStateCmpnt
    {

        public var difficultyButton:EventDifficultyButton = null;

        public function EventDifficultyButtonContainer()
        {
            super();
        }

        public function setData(param1:EventDifficultyLevelVO) : void
        {
            this.difficultyButton.setData(param1);
        }

        override protected function onDispose() : void
        {
            this.difficultyButton.dispose();
            this.difficultyButton = null;
            super.onDispose();
        }
    }
}
