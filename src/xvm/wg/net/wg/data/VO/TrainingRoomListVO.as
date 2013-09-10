package net.wg.data.VO 
{
    import net.wg.data.daapi.base.*;
    
    public class TrainingRoomListVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function TrainingRoomListVO(arg1:Object)
        {
            this._other = [];
            this._team1 = [];
            this._team2 = [];
            super(arg1);
            return;
        }

        public function get team2():Array
        {
            return this._team2;
        }

        public function set team2(arg1:Array):void
        {
            this._team2 = arg1;
            return;
        }

        public function get team1():Array
        {
            return this._team1;
        }

        public function set team1(arg1:Array):void
        {
            this._team1 = arg1;
            return;
        }

        public function get other():Array
        {
            return this._other;
        }

        public function set other(arg1:Array):void
        {
            this._other = arg1;
            return;
        }

        public function get myId():Number
        {
            return this._myId;
        }

        public function set myId(arg1:Number):void
        {
            this._myId = arg1;
            return;
        }

        public function getTeam(arg1:String):Array
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case "team1":
                    return this._team1;
                case "team2":
                    return this._team2;
                case "other":
                    return this._other;
                default:
                    DebugUtils.LOG_DEBUG("undefined " + arg1 + "in TrainingRoomListVO");
                    return [];
            }
        }

        internal var _other:Array;

        internal var _team1:Array;

        internal var _team2:Array;

        internal var _myId:Number;
    }
}
