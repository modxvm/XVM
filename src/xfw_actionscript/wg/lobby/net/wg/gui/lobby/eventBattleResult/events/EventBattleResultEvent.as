package net.wg.gui.lobby.eventBattleResult.events
{
    import flash.events.Event;

    public final class EventBattleResultEvent extends Event
    {

        public static const TAB_CHANGED:String = "tabChanged";

        public static const SEND_FRIEND:String = "sendFriend";

        public static const SEND_SQUAD:String = "sendSquad";

        public static const VALUES_ANIMATION_STARTED:String = "valuesAnimationStarted";

        public static const MISSION_REWARD_APPEAR:String = "missionRewardAppear";

        public static const MISSION_PROGRESSBAR_APPEAR:String = "missionProgressbarAppear";

        private var _id:Number;

        private var _userName:String;

        public function EventBattleResultEvent(param1:String, param2:Number = 0, param3:String = null, param4:Boolean = false)
        {
            super(param1,param4);
            this._id = param2;
            this._userName = param3;
        }

        override public function clone() : Event
        {
            return new EventBattleResultEvent(type,this._id,this._userName,bubbles);
        }

        public function get id() : Number
        {
            return this._id;
        }

        public function get userName() : String
        {
            return this._userName;
        }
    }
}
