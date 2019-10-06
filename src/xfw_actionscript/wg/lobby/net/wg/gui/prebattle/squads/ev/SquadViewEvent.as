package net.wg.gui.prebattle.squads.ev
{
    import flash.events.Event;

    public class SquadViewEvent extends Event
    {

        public static var ON_POPULATED:String = "onSquadViewPopulated";

        public function SquadViewEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1,param2,param3);
        }
    }
}
