package net.wg.gui.lobby.headerTutorial
{
    import flash.events.Event;
    
    public class HeaderTutorialEvent extends Event
    {
        
        public function HeaderTutorialEvent(param1:String, param2:int)
        {
            super(param1,true,true);
            this.step = param2;
        }
        
        public static var STEP_CHANGED:String = "stepChanged";
        
        public var step:int = 0;
        
        override public function clone() : Event
        {
            return new HeaderTutorialEvent(type,this.step);
        }
    }
}
