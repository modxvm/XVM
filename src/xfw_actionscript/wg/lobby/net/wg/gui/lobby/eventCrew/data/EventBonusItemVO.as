package net.wg.gui.lobby.eventCrew.data
{
    import net.wg.gui.components.paginator.vo.ToolTipVO;

    public class EventBonusItemVO extends ToolTipVO
    {

        public var icon:String = "";

        public var label:String = "";

        public var completed:Boolean = false;

        public var currentProgress:int = -1;

        public var maxProgress:int = -1;

        public function EventBonusItemVO(param1:Object)
        {
            super(param1);
        }
    }
}
