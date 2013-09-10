package net.wg.gui.lobby.questsWindow.data 
{
    import net.wg.data.daapi.base.*;
    
    public class HeaderDataVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function HeaderDataVO(arg1:Object)
        {
            super(arg1);
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

        public function get date():String
        {
            return this._date;
        }

        public function set date(arg1:String):void
        {
            this._date = arg1;
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            this._type = arg1;
            return;
        }

        public function get impDescr():String
        {
            return this._impDescr;
        }

        public function set impDescr(arg1:String):void
        {
            this._impDescr = arg1;
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

        public function get progrBarType():String
        {
            return this._progrBarType;
        }

        public function set progrBarType(arg1:String):void
        {
            this._progrBarType = arg1;
            return;
        }

        public function get maxProgrVal():Number
        {
            return this._maxProgrVal;
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

        public function get tasksCount():int
        {
            return this._tasksCount;
        }

        public function set tasksCount(arg1:int):void
        {
            this._tasksCount = arg1;
            return;
        }

        public function get progrTooltip():Object
        {
            return this._progrTooltip;
        }

        public function set progrTooltip(arg1:Object):void
        {
            this._progrTooltip = arg1;
            return;
        }

        internal var _title:String="";

        internal var _date:String="";

        internal var _type:String="";

        internal var _impDescr:String="";

        internal var _status:String="";

        internal var _progrBarType:String="";

        internal var _maxProgrVal:Number=0;

        internal var _currentProgrVal:Number=0;

        internal var _tasksCount:int=0;

        internal var _progrTooltip:Object=null;
    }
}
