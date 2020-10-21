package net.wg.gui.lobby.eventManageCrewPanel.data
{
    import net.wg.gui.components.paginator.vo.ToolTipVO;

    public class EventManageCrewVO extends ToolTipVO
    {

        public var description:String = "";

        public var cost:String = "";

        public var buttonEnabled:Boolean = true;

        public var buttonLabel:String = "";

        public var icon:String = "";

        public var inStorage:String = "";

        public var isActivated:Boolean = false;

        public var bgFrame:String = "";

        public function EventManageCrewVO(param1:Object)
        {
            super(param1);
        }
    }
}
