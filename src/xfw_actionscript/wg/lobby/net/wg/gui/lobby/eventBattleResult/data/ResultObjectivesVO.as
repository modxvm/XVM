package net.wg.gui.lobby.eventBattleResult.data
{
    import net.wg.gui.components.paginator.vo.ToolTipVO;

    public class ResultObjectivesVO extends ToolTipVO
    {

        public var total:int = -1;

        public var completed:int = -1;

        public function ResultObjectivesVO(param1:Object)
        {
            super(param1);
        }
    }
}
