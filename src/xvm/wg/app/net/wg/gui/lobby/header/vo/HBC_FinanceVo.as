package net.wg.gui.lobby.header.vo
{
    import net.wg.data.constants.IconsTypes;
    
    public class HBC_FinanceVo extends Object
    {
        
        public function HBC_FinanceVo()
        {
            super();
        }
        
        public var money:String = "";
        
        private var _iconId:String = "empty";
        
        public var btnDoText:String = "";
        
        public function get iconId() : String
        {
            return this._iconId;
        }
        
        public function set iconId(param1:String) : void
        {
            this._iconId = param1;
            switch(this._iconId)
            {
                case IconsTypes.GOLD:
                    this.btnDoText = MENU.HEADERBUTTONS_BTNLABEL_BUY_GOLD;
                    break;
                case IconsTypes.CREDITS:
                    this.btnDoText = MENU.HEADERBUTTONS_BTNLABEL_EXCHANGE_GOLD;
                    break;
                case IconsTypes.FREE_XP:
                    this.btnDoText = MENU.HEADERBUTTONS_BTNLABEL_GATHERING_EXPERIENCE;
                    break;
            }
        }
    }
}
