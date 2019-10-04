package net.wg.gui.prebattle.squads.simple.vo
{
    import net.wg.gui.rally.vo.RallySlotVO;

    public class SimpleSquadRallySlotVO extends RallySlotVO
    {

        public var additionalMsg:String = "";

        public var isVisibleAdtMsg:Boolean = false;

        public var hasPremiumAccount:Boolean = false;

        public var slotNotificationIcon:String = "";

        public var slotNotificationIconTooltip:String = "";

        public function SimpleSquadRallySlotVO(param1:Object)
        {
            super(param1);
        }
    }
}
