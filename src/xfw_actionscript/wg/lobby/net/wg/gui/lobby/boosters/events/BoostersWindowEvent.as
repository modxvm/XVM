package net.wg.gui.lobby.boosters.events
{
    import flash.events.Event;

    public class BoostersWindowEvent extends Event
    {

        public static const BOOSTER_ACTION_BTN_CLICK:String = "boosterActionBtnClick";

        public var boosterID:Number = -1;

        public var questID:String = "";

        public function BoostersWindowEvent(param1:String, param2:Number = -1, param3:String = "")
        {
            super(param1,true,true);
            this.boosterID = param2;
            this.questID = param3;
        }
    }
}
