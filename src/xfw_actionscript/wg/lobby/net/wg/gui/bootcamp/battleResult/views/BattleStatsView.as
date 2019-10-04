package net.wg.gui.bootcamp.battleResult.views
{
    import net.wg.infrastructure.base.UIComponentEx;
    import flash.display.MovieClip;
    import net.wg.gui.bootcamp.battleResult.containers.RewardStatsContainer;
    import net.wg.gui.bootcamp.battleResult.containers.BattleResultsGroup;
    import net.wg.gui.bootcamp.battleResult.data.BCBattleViewVO;
    import net.wg.gui.bootcamp.battleResult.containers.BattleResultGroupLayout;
    import net.wg.data.constants.generated.BOOTCAMP_BATTLE_RESULT_CONSTANTS;
    import net.wg.data.constants.Linkages;

    public class BattleStatsView extends UIComponentEx
    {

        private static const LIST_Y:int = -306;

        private static const LIST_STATS_Y:int = -208;

        private static const START_ANIMATION_LABEL:String = "startAnimation";

        private static const STATS_ANIM_DELAY:int = 800;

        private static const STATS_SPACING:int = 64;

        private static const MEDALS_SPACING:int = 100;

        public var dividerTop:MovieClip = null;

        public var dividerBottom:MovieClip = null;

        public var medalFX:MovieClip = null;

        public var rewardValue:RewardStatsContainer = null;

        private var _statList:BattleResultsGroup;

        private var _medalList:BattleResultsGroup;

        private var _bcData:BCBattleViewVO;

        private var _useBattleRewardsAnimation:Boolean = true;

        public function BattleStatsView()
        {
            this._statList = new BattleResultsGroup();
            this._medalList = new BattleResultsGroup();
            super();
        }

        override protected function onDispose() : void
        {
            App.utils.scheduler.cancelTask(this.startStatsAnimation);
            this.medalFX = null;
            this.dividerBottom = null;
            this.dividerTop = null;
            this.rewardValue.dispose();
            this.rewardValue = null;
            this._statList.dispose();
            this._medalList.dispose();
            this._statList = null;
            this._medalList = null;
            this._bcData = null;
            super.onDispose();
        }

        public function setData(param1:BCBattleViewVO) : void
        {
            this._bcData = param1;
            if(this.rewardValue)
            {
                this.rewardValue.setAwardValues(this._bcData.credits,this._bcData.xp);
            }
            this._useBattleRewardsAnimation = this._bcData.showRewards;
            this._statList.layout = new BattleResultGroupLayout(STATS_SPACING);
            this._medalList.layout = new BattleResultGroupLayout(MEDALS_SPACING);
            this._statList.elementId = BOOTCAMP_BATTLE_RESULT_CONSTANTS.STATS_LIST;
            this._medalList.elementId = BOOTCAMP_BATTLE_RESULT_CONSTANTS.MEDAlS_LIST;
            this._statList.itemRendererLinkage = Linkages.ITEM_RENDERER_STAT;
            this._medalList.itemRendererLinkage = Linkages.ITEM_RENDERER_MEDAL;
            this._statList.y = LIST_STATS_Y;
            this._medalList.y = LIST_Y;
            addChild(this._statList);
            addChild(this._medalList);
            this._medalList.dataProvider = this._bcData.unlocksAndMedals;
            this._statList.dataProvider = this._bcData.stats;
            if(this._bcData.unlocksAndMedals.length > 0)
            {
                this.dividerTop.gotoAndPlay(START_ANIMATION_LABEL);
                this.medalFX.gotoAndPlay(START_ANIMATION_LABEL);
            }
            this.dividerBottom.gotoAndPlay(START_ANIMATION_LABEL);
        }

        public function startAppearAnimation() : void
        {
            if(this._useBattleRewardsAnimation)
            {
                this.rewardValue.appear();
            }
            App.utils.scheduler.scheduleTask(this.startStatsAnimation,STATS_ANIM_DELAY);
            this._medalList.showAppearAnimation();
        }

        private function startStatsAnimation() : void
        {
            this._statList.showAppearAnimation();
        }
    }
}
