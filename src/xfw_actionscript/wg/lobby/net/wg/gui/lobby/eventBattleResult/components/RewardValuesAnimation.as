package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.utils.IScheduler;
    import flash.events.Event;
    import flash.utils.getTimer;
    import net.wg.gui.lobby.eventBattleResult.events.EventBattleResultEvent;

    public class RewardValuesAnimation extends ResultAppearMovieClip implements IDisposable
    {

        private static const ANIM_TIME:int = 1000;

        private static const ANIM_STEP_TIME:int = 20;

        private static const MAX_PROGRESS:Number = 1;

        private var _startTime:Number = 0;

        private var _scheduler:IScheduler;

        public function RewardValuesAnimation()
        {
            this._scheduler = App.utils.scheduler;
            super();
        }

        override public function appear() : void
        {
            super.appear();
            addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
        }

        override public function immediateAppear() : void
        {
            super.immediateAppear();
            this._scheduler.cancelTask(this.increaseValues);
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            this.setAnimationProgress(MAX_PROGRESS);
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        protected function setAnimationProgress(param1:Number) : void
        {
        }

        protected function onDispose() : void
        {
            this._scheduler.cancelTask(this.increaseValues);
            this._scheduler = null;
            removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
        }

        private function onEnterFrameHandler(param1:Event) : void
        {
            if(currentFrameLabel == ResultAppearMovieClip.IDLE)
            {
                removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
                this._startTime = getTimer();
                this._scheduler.scheduleRepeatableTask(this.increaseValues,ANIM_STEP_TIME,int.MAX_VALUE);
                dispatchEvent(new EventBattleResultEvent(EventBattleResultEvent.VALUES_ANIMATION_STARTED));
            }
        }

        private function increaseValues() : void
        {
            var _loc1_:Number = Math.min((getTimer() - this._startTime) / ANIM_TIME,MAX_PROGRESS);
            if(_loc1_ == MAX_PROGRESS)
            {
                this._scheduler.cancelTask(this.increaseValues);
            }
            this.setAnimationProgress(_loc1_);
        }
    }
}
