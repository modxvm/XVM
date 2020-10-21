package net.wg.gui.lobby.eventTankRent.data
{
    import net.wg.gui.components.paginator.vo.ToolTipVO;

    public class EventTankRentVO extends ToolTipVO
    {

        public var description:String = "";

        public var cost:String = "";

        public var rewardText:String = "";

        public function EventTankRentVO(param1:Object)
        {
            super(param1);
        }
    }
}
