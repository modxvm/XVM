package net.wg.infrastructure.events
{
    import flash.events.Event;
    
    public class GameEvent extends Event
    {
        
        public function GameEvent(param1:String, param2:Boolean = false, param3:Boolean = true)
        {
            super(param1,param2,param3);
        }
        
        public static var SUBMIT:String = "submit";
    }
}
