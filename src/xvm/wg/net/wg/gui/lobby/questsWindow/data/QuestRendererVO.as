package net.wg.gui.lobby.questsWindow.data 
{
    import net.wg.data.daapi.base.*;
    
    public class QuestRendererVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function QuestRendererVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function set maxProgrVal(arg1:Number):void
        {
            this._maxProgrVal = arg1;
            return;
        }

        public function get currentProgrVal():Number
        {
            return this._currentProgrVal;
        }

        public function set currentProgrVal(arg1:Number):void
        {
            this._currentProgrVal = arg1;
            return;
        }

        public function get progrBarType():String
        {
            return this._progrBarType;
        }

        public function set progrBarType(arg1:String):void
        {
            this._progrBarType = arg1;
            return;
        }

        public function get status():String
        {
            return this._status;
        }

        public function set status(arg1:String):void
        {
            this._status = arg1;
            return;
        }

        public function get isLock():Boolean
        {
            return this._isLock;
        }

        public function set isLock(arg1:Boolean):void
        {
            this._isLock = arg1;
            return;
        }

        public function get isLocked():Boolean
        {
            return this._isLocked;
        }

        public function set isLocked(arg1:Boolean):void
        {
            this._isLocked = arg1;
            return;
        }

        public function get questID():String
        {
            return this._questID;
        }

        public function set questID(arg1:String):void
        {
            this._questID = arg1;
            return;
        }

        public function get isNew():Boolean
        {
            return this._isNew;
        }

        public function set isNew(arg1:Boolean):void
        {
            this._isNew = arg1;
            return;
        }

        public function get IGR():Boolean
        {
            return this._IGR;
        }

        public function set IGR(arg1:Boolean):void
        {
            this._IGR = arg1;
            return;
        }

        public function get taskType():String
        {
            return this._taskType;
        }

        public function set taskType(arg1:String):void
        {
            this._taskType = arg1;
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

        public function get timerDescr():String
        {
            return this._timerDescr;
        }

        public function set timerDescr(arg1:String):void
        {
            this._timerDescr = arg1;
            return;
        }

        public function get tasksCount():int
        {
            return this._tasksCount;
        }

        public function set tasksCount(arg1:int):void
        {
            this._tasksCount = arg1;
            return;
        }

        public function get maxProgrVal():Number
        {
            return this._maxProgrVal;
        }

        internal var _isNew:Boolean=false;

        internal var _status:String="";

        internal var _IGR:Boolean=false;

        internal var _taskType:String="";

        internal var _description:String="";

        internal var _timerDescr:String="";

        internal var _tasksCount:int=0;

        internal var _progrBarType:String="";

        internal var _maxProgrVal:Number=0;

        internal var _currentProgrVal:Number=0;

        internal var _isLock:Boolean=false;

        internal var _isLocked:Boolean=false;

        internal var _questID:String="";
    }
}
