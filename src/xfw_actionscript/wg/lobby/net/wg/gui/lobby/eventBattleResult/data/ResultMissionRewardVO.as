package net.wg.gui.lobby.eventBattleResult.data
{
    import net.wg.gui.lobby.eventQuests.data.QuestLevelProgressVO;

    public class ResultMissionRewardVO extends QuestLevelProgressVO
    {

        public var isCommander:Boolean = false;

        public var showBonus:Boolean = false;

        public var showProgress:Boolean = true;

        public var showComplete:Boolean = false;

        public var progressDelta:String = "";

        public function ResultMissionRewardVO(param1:Object)
        {
            super(param1);
        }
    }
}
