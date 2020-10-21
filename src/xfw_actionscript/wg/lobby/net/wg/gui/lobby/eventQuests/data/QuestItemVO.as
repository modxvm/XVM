package net.wg.gui.lobby.eventQuests.data
{
    import net.wg.gui.components.paginator.vo.ToolTipVO;

    public class QuestItemVO extends ToolTipVO
    {

        public var icon:String = "";

        public var value:String = "";

        public var isMoney:Boolean = false;

        public function QuestItemVO(param1:Object)
        {
            super(param1);
        }
    }
}
