package net.wg.gui.lobby.header.vo
{
    public class HBC_SquadDataVo extends Object
    {
        
        public function HBC_SquadDataVo()
        {
            super();
        }
        
        public var buttonName:String = "#menu:headerButtons/btnLabel/createSquad";
        
        public var tooltip:String = "#tooltips:header/squad";
        
        private var _isInSquad:Boolean = false;
        
        public var isEventSquad:Boolean = false;
        
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
