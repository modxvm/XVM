package net.wg.gui.events 
{
    import flash.events.*;
    
    public class QuestEvent extends flash.events.Event
    {
        public function QuestEvent(arg1:String, arg2:String)
        {
            super(arg1, true, true);
            this.questID = arg2;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.events.QuestEvent(type, this.questID);
        }

        public static const SELECT_QUEST:String="selectQuest";

        public var questID:String="";
    }
}
