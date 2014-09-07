package net.wg.gui.lobby.fortifications.events
{
    import flash.events.Event;
    
    public class FortIntelClanDescriptionEvent extends Event
    {
        
        public function FortIntelClanDescriptionEvent(param1:String, param2:* = null)
        {
            super(param1,true,true);
            this._data = param2;
        }
        
        public static var SHOW_CLAN_INFOTIP:String = "showClanInfotip";
        
        public static var HIDE_CLAN_INFOTIP:String = "hideClanInfotip";
        
        public static var CHECKBOX_CLICK:String = "checkBoxClick";
        
        public static var OPEN_CALENDAR:String = "openCalendar";
        
        public static var CLICK_LINK_BTN:String = "clickLinkBtn";
        
        public static var OPEN_CLAN_LIST:String = "openClanList";
        
        public static var OPEN_CLAN_STATISTICS:String = "openClanStatistics";
        
        public static var OPEN_CLAN_CARD:String = "openClanCard";
        
        public static var ATTACK_DIRECTION:String = "attackDirection";
        
        public static var HOVER_DIRECTION:String = "hoverDirection";
        
        private var _data = null;
        
        public function get data() : *
        {
            return this._data;
        }
    }
}
