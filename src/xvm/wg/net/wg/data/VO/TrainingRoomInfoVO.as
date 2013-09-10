package net.wg.data.VO 
{
    import net.wg.data.daapi.base.*;
    
    public class TrainingRoomInfoVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function TrainingRoomInfoVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get creator():String
        {
            return this._creator;
        }

        public function set creator(arg1:String):void
        {
            this._creator = arg1;
            return;
        }

        public function get arenaSubType():String
        {
            return this._arenaSubType;
        }

        public function set arenaSubType(arg1:String):void
        {
            this._arenaSubType = arg1;
            return;
        }

        public function get arenaName():String
        {
            return this._arenaName;
        }

        public function set arenaName(arg1:String):void
        {
            this._arenaName = arg1;
            return;
        }

        public function get maxPlayersCount():Number
        {
            return this._maxPlayersCount;
        }

        public function set maxPlayersCount(arg1:Number):void
        {
            this._maxPlayersCount = arg1;
            return;
        }

        public function get roundLenString():String
        {
            return this._roundLenString;
        }

        public function set roundLenString(arg1:String):void
        {
            this._roundLenString = arg1;
            return;
        }

        public function get comment():String
        {
            return this._comment;
        }

        public function set comment(arg1:String):void
        {
            this._comment = arg1;
            return;
        }

        public function get title():String
        {
            return this._title;
        }

        public function set title(arg1:String):void
        {
            this._title = arg1;
            return;
        }

        public function get isCreator():Boolean
        {
            return this._isCreator;
        }

        public function set isCreator(arg1:Boolean):void
        {
            this._isCreator = arg1;
            return;
        }

        public function get canChangeArenaVOIP():Boolean
        {
            return this._canChangeArenaVOIP;
        }

        public function set canChangeArenaVOIP(arg1:Boolean):void
        {
            this._canChangeArenaVOIP = arg1;
            return;
        }

        public function get arenaVoipChannels():Number
        {
            return this._arenaVoipChannels;
        }

        public function set arenaVoipChannels(arg1:Number):void
        {
            this._arenaVoipChannels = arg1;
            return;
        }

        public function get description():String
        {
            return this._description;
        }

        public function set description(arg1:String):void
        {
            this._description = arg1;
            return;
        }

        public function get arenaTypeID():Number
        {
            return this._arenaTypeID;
        }

        public function set arenaTypeID(arg1:Number):void
        {
            this._arenaTypeID = arg1;
            return;
        }

        internal var _comment:String="";

        internal var _arenaName:String="";

        internal var _roundLenString:String="";

        internal var _maxPlayersCount:Number=0;

        internal var _arenaSubType:String="";

        internal var _creator:String="";

        internal var _arenaTypeID:Number=0;

        internal var _description:String="";

        internal var _title:String="";

        internal var _canChangeArenaVOIP:Boolean;

        internal var _arenaVoipChannels:Number=-1;

        internal var _isCreator:Boolean;
    }
}
