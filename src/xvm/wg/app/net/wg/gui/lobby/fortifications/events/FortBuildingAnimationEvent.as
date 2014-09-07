package net.wg.gui.lobby.fortifications.events
{
    import flash.events.Event;
    
    public class FortBuildingAnimationEvent extends Event
    {
        
        public function FortBuildingAnimationEvent(param1:String)
        {
            super(param1,true,true);
        }
        
        public static var END_ANIMATION:String = "endAnimation";
    }
}
