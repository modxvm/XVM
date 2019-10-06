package net.wg.gui.lobby.header.vo
{
    public class HBC_SquadDataVo extends HBC_AbstractVO
    {

        public var buttonName:String = "#menu:headerButtons/btnLabel/createSquad";

        public var icon:String = "../maps/icons/battleTypes/40x40/squad.png";

        public var isEvent:Boolean = false;

        public function HBC_SquadDataVo()
        {
            super();
        }

        public function set isInSquad(param1:Boolean) : void
        {
            this.buttonName = param1?MENU.HEADERBUTTONS_BTNLABEL_INSQUAD:MENU.HEADERBUTTONS_BTNLABEL_CREATESQUAD;
        }
    }
}
