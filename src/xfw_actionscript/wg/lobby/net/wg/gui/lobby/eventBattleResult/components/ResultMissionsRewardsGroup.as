package net.wg.gui.lobby.eventBattleResult.components
{
    import net.wg.gui.components.containers.GroupEx;

    public class ResultMissionsRewardsGroup extends GroupEx
    {

        public function ResultMissionsRewardsGroup()
        {
            super();
        }

        public function appear() : void
        {
            var _loc2_:RewardItemRenderer = null;
            var _loc1_:int = numRenderers();
            var _loc3_:* = 0;
            while(_loc3_ < _loc1_)
            {
                _loc2_ = RewardItemRenderer(getRendererAt(_loc3_));
                _loc2_.appear();
                _loc3_++;
            }
        }
    }
}
