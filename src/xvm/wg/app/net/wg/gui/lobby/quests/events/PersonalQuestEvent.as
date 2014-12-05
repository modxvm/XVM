package net.wg.gui.lobby.quests.events
{
    import flash.events.Event;
    
    public class PersonalQuestEvent extends Event
    {
        
        public function PersonalQuestEvent(param1:String, param2:* = null)
        {
            super(param1,true,true);
            this._data = param2;
        }
        
        public static var SHOW_SEASON_AWARDS:String = "showSeasonAwards";
        
        public static var TILE_CLICK:String = "tileClick";
        
        public static var SLOT_CLICK:String = "slotClick";
        
        private var _data = null;
        
        public function get data() : *
        {
            return this._data;
        }
    }
}
