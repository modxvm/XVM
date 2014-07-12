package net.wg.gui.events
{
    import flash.events.Event;
    
    public class QuestEvent extends Event
    {
        
        public function QuestEvent(param1:String, param2:String) {
            super(param1,true,true);
            this.questID = param2;
        }
        
        public static var SELECT_QUEST:String = "selectQuest";
        
        public var questID:String = "";
        
        override public function clone() : Event {
            return new QuestEvent(type,this.questID);
        }
    }
}
