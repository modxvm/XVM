package net.wg.gui.components.advanced.events
{
    import flash.events.Event;

    public class TutorialHintEvent extends Event
    {

        public static const LOOP_ENDED:String = "loopEnded";

        public function TutorialHintEvent(param1:String)
        {
            super(param1,true,true);
        }
    }
}
