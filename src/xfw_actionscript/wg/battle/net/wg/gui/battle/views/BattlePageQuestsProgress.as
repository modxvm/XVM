package net.wg.gui.battle.views
{
    import net.wg.gui.battle.views.questProgress.QuestProgressTopView;
    import net.wg.gui.battle.views.questProgress.animated.AnimationTopContainer;
    import net.wg.gui.battle.views.questProgress.QuestProgressAnimatedWrapper;
    import net.wg.infrastructure.helpers.statisticsDataController.BattleStatisticDataController;
    import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
    import net.wg.gui.battle.views.questProgress.events.QuestProgressAnimatedWrapperEvent;
    import net.wg.gui.battle.views.prebattleTimer.PrebattleTimerEvent;
    import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
    import flash.events.Event;

    public class BattlePageQuestsProgress extends BaseBattlePage
    {

        private static const FINAL_HIDE_PROGRESS_DELAY:int = 700;

        public var questProgressTopView:QuestProgressTopView = null;

        public var questProgressTopAnimContainer:AnimationTopContainer = null;

        private var _questProgressAnimatedWrapper:QuestProgressAnimatedWrapper;

        public function BattlePageQuestsProgress()
        {
            super();
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            var _loc3_:* = param1 >> 1;
            if(this.isQuestProgress && battleStatisticDataController.hasQuestProgressActiveData)
            {
                this.questProgressTopView.x = _loc3_;
                this.questProgressTopAnimContainer.x = _loc3_;
            }
        }

        override protected function initializeStatisticsController(param1:BattleStatisticDataController) : void
        {
            var _loc2_:IQuestProgressView = null;
            if(this.isQuestProgress)
            {
                this._questProgressAnimatedWrapper = new QuestProgressAnimatedWrapper(this.questProgressTopView,this.questProgressTopAnimContainer);
                param1.registerQuestProgressView(this._questProgressAnimatedWrapper);
                _loc2_ = this.getFullStatsTabQuestProgress();
                if(_loc2_)
                {
                    param1.registerQuestProgressView(_loc2_);
                }
                this._questProgressAnimatedWrapper.addEventListener(QuestProgressAnimatedWrapperEvent.ALL_ANIM_COMPLETED,this.onAllAnimCompletedHandler);
            }
        }

        override protected function onPopulate() : void
        {
            if(this.isQuestProgress)
            {
                prebattleTimer.addEventListener(PrebattleTimerEvent.ALLOW_TO_SHOW_QP,this.onPrebattleTimerAllowToShowQpHandler);
                prebattleTimer.addEventListener(PrebattleTimerEvent.RESET_ANIM_QP,this.onPrebattleTimerNeedResetAnimQpHandler);
                registerComponent(this.questProgressTopView,BATTLE_VIEW_ALIASES.QUEST_PROGRESS_TOP_VIEW);
            }
            super.onPopulate();
        }

        override protected function onDispose() : void
        {
            this.questProgressTopView = null;
            if(this.isQuestProgress)
            {
                this._questProgressAnimatedWrapper.removeEventListener(QuestProgressAnimatedWrapperEvent.ALL_ANIM_COMPLETED,this.onAllAnimCompletedHandler);
                this._questProgressAnimatedWrapper.dispose();
                this._questProgressAnimatedWrapper = null;
                this.questProgressTopAnimContainer.dispose();
                this.questProgressTopAnimContainer = null;
                prebattleTimer.removeEventListener(PrebattleTimerEvent.ALLOW_TO_SHOW_QP,this.onPrebattleTimerAllowToShowQpHandler);
                prebattleTimer.removeEventListener(PrebattleTimerEvent.RESET_ANIM_QP,this.onPrebattleTimerNeedResetAnimQpHandler);
            }
            super.onDispose();
        }

        override protected function onMessagesStartedPlaying(param1:String) : void
        {
            super.onMessagesStartedPlaying(param1);
            this.hideQuestProgressTopView(null,FINAL_HIDE_PROGRESS_DELAY);
        }

        protected function getFullStatsTabQuestProgress() : IQuestProgressView
        {
            return null;
        }

        protected function hideQuestProgressTopView(param1:Function, param2:int) : void
        {
            if(this.isQuestProgress)
            {
                this._questProgressAnimatedWrapper.permanentStopAnimation();
                this.questProgressTopView.hideView(param1,param2);
            }
        }

        protected function updatePositionQuestProgressTop(param1:int) : void
        {
            if(this.isQuestProgress)
            {
                this.questProgressTopView.setYPosition(param1);
                this.questProgressTopAnimContainer.y = param1;
            }
        }

        override protected function get isQuestProgress() : Boolean
        {
            return true;
        }

        private function onPrebattleTimerAllowToShowQpHandler(param1:PrebattleTimerEvent) : void
        {
            if(this.isQuestProgress)
            {
                this.questProgressTopView.showByPrebattleTimer(param1.useAnim);
            }
        }

        private function onPrebattleTimerNeedResetAnimQpHandler(param1:PrebattleTimerEvent) : void
        {
            if(this.isQuestProgress)
            {
                this.questProgressTopView.resetFirstShowByTimer();
            }
        }

        private function onAllAnimCompletedHandler(param1:Event) : void
        {
            if(this.isQuestProgress)
            {
                this.questProgressTopView.unlock();
            }
        }
    }
}
