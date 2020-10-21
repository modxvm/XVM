package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.containers.GroupEx;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;

    public class ResultMissionReward extends ResultAppearMovieClip implements IDisposable
    {

        private static const GAP:int = 6;

        private static const SIZE:int = 62;

        private static const GROUP_RENDERER:String = "ResultMissionRewardRendererUI";

        public var rewards:GroupEx = null;

        public function ResultMissionReward()
        {
            super();
            var _loc1_:CenterAlignedGroupLayout = new CenterAlignedGroupLayout(SIZE,SIZE);
            _loc1_.gap = GAP;
            this.rewards.layout = _loc1_;
            this.rewards.itemRendererLinkage = GROUP_RENDERER;
        }

        public function setData(param1:DataProvider) : void
        {
            this.rewards.dataProvider = param1;
        }

        public final function dispose() : void
        {
            this.rewards.dispose();
            this.rewards = null;
        }
    }
}
