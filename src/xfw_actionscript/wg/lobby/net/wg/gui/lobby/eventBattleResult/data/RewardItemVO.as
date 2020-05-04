package net.wg.gui.lobby.eventBattleResult.data
{
    import net.wg.gui.components.paginator.vo.ToolTipVO;

    public class RewardItemVO extends ToolTipVO
    {

        public var icon:String = "";

        public var value:String = "";

        public var overlayType:String = "";

        public var highlightType:String = "";

        public function RewardItemVO(param1:Object)
        {
            super(param1);
        }
    }
}
