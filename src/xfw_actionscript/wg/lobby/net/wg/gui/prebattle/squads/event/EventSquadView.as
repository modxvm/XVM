package net.wg.gui.prebattle.squads.event
{
    import net.wg.gui.prebattle.squads.SquadView;
    import net.wg.data.constants.generated.SQUADTYPES;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.prebattle.squads.event.vo.EventSquadRallyVO;

    public class EventSquadView extends SquadView
    {

        private static const INVITE_BTN_Y_EVENT_SQUAD:Number = 415;

        public function EventSquadView()
        {
            super();
        }

        override protected function get squadType() : String
        {
            return SQUADTYPES.SQUAD_TYPE_EVENT;
        }

        override protected function get teamSectionPosY() : Number
        {
            return INVITE_BTN_Y_EVENT_SQUAD;
        }

        override protected function getIRallyVOForRally(param1:Object) : IRallyVO
        {
            return new EventSquadRallyVO(param1);
        }
    }
}
