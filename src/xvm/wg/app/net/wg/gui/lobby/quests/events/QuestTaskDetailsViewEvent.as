package net.wg.gui.lobby.quests.events
{
    import flash.events.Event;
    
    public class QuestTaskDetailsViewEvent extends Event
    {
        
        public function QuestTaskDetailsViewEvent(param1:String, param2:Number = -1)
        {
            super(param1,true,true);
            this.taskID = param2;
        }
        
        public static var SELECT_TASK:String = "selectTask";
        
        public static var CANCEL_TASK:String = "cancelTask";
        
        public var taskID:Number = -1;
    }
}
