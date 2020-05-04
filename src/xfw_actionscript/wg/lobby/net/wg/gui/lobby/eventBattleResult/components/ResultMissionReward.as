package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.components.containers.HorizontalGroupLayout;

    public class ResultMissionReward extends ResultAppearMovieClip implements IDisposable
    {

        private static const REWARD_GAP:int = -8;

        private static const ABILITY_GAP:int = -2;

        private static const REWARD_RENDERER:String = "ResultMissionRewardRendererUI";

        private static const ABILITY_RENDERER:String = "ResultMissionAbilityRendererUI";

        public var rewards:ResultMissionsRewardsGroup = null;

        public function ResultMissionReward()
        {
            super();
            var _loc1_:HorizontalGroupLayout = new HorizontalGroupLayout(REWARD_GAP);
            this.rewards.layout = _loc1_;
        }

        override public function appear() : void
        {
            super.appear();
            this.rewards.validateNow();
            this.rewards.appear();
        }

        override public function immediateAppear() : void
        {
            super.immediateAppear();
            this.rewards.appear();
        }

        public final function dispose() : void
        {
            this.rewards.dispose();
            this.rewards = null;
        }

        public function setData(param1:DataProvider, param2:Boolean) : void
        {
            HorizontalGroupLayout(this.rewards.layout).gap = param2?ABILITY_GAP:REWARD_GAP;
            this.rewards.itemRendererLinkage = param2?ABILITY_RENDERER:REWARD_RENDERER;
            this.rewards.dataProvider = param1;
        }
    }
}
