package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.Event;
    import net.wg.gui.lobby.eventBattleResult.data.ResultMissionRewardVO;

    public class ResultMissions extends ResultAppearMovieClip implements IDisposable
    {

        private static const DELAY_MISSION1:int = 150;

        private static const DELAY_MISSION2:int = 950;

        public var mission1:ResultMissionProgress = null;

        public var mission2:ResultMissionProgress = null;

        public function ResultMissions()
        {
            super();
        }

        override public function appear() : void
        {
            super.appear();
            this.mission1.appear(DELAY_MISSION1);
            this.mission2.appear(DELAY_MISSION2);
            addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
        }

        override public function immediateAppear() : void
        {
            super.immediateAppear();
            this.mission1.immediateAppear();
            this.mission2.immediateAppear();
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
        }

        public final function dispose() : void
        {
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            this.mission1.dispose();
            this.mission1 = null;
            this.mission2.dispose();
            this.mission2 = null;
        }

        public function setData(param1:ResultMissionRewardVO, param2:ResultMissionRewardVO) : void
        {
            this.mission1.update(param1);
            this.mission2.update(param2);
        }

        private function onEnterFrameHandler(param1:Event) : void
        {
            if(currentFrameLabel == ResultAppearMovieClip.IDLE)
            {
                removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
                dispatchEvent(new Event(Event.COMPLETE));
            }
        }
    }
}
