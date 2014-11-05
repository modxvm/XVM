package net.wg.gui.lobby.header.vo
{
    public class HBC_SquadDataVo extends Object
    {
        
        public function HBC_SquadDataVo()
        {
            this.buttonName = MENU.HEADERBUTTONS_BTNLABEL_CREATESQUAD;
            this.tooltip = TOOLTIPS.HEADER_SQUAD;
            super();
        }
        
        public var buttonName:String;
        
        public var tooltip:String;
        
        private var _isInSquad:Boolean = false;
        
        public function get isInSquad() : Boolean
        {
            return this._isInSquad;
        }
        
        public function set isInSquad(param1:Boolean) : void
        {
            this._isInSquad = param1;
            this.buttonName = this._isInSquad?MENU.HEADERBUTTONS_BTNLABEL_INSQUAD:MENU.HEADERBUTTONS_BTNLABEL_CREATESQUAD;
            this.tooltip = this._isInSquad?TOOLTIPS.HEADER_SQUAD_MEMBER:TOOLTIPS.HEADER_SQUAD;
        }
    }
}
