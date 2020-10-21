package net.wg.gui.lobby.eventDifficulties.events
{
    import flash.events.Event;

    public class DifficultySelectionEvent extends Event
    {

        public static const DIFFICULTY_BUTTON_CLICK:String = "difficultyButtonClick";

        private var _id:int = 0;

        public function DifficultySelectionEvent(param1:String, param2:Number = 0, param3:Boolean = true, param4:Boolean = false)
        {
            super(param1,param3,param4);
            this._id = param2;
        }

        override public function clone() : Event
        {
            return new DifficultySelectionEvent(type,this._id,bubbles,cancelable);
        }

        public function get id() : int
        {
            return this._id;
        }
    }
}
