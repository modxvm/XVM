package net.wg.gui.lobby.questsWindow.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class HeaderDataVO extends DAAPIDataClass
    {
        
        public function HeaderDataVO(param1:Object) {
            super(param1);
        }
        
        private var _title:String = "";
        
        private var _date:String = "";
        
        private var _type:String = "";
        
        private var _impDescr:String = "";
        
        private var _status:String = "";
        
        private var _statusDescription:String = "";
        
        private var _progrBarType:String = "";
        
        private var _eventType:int = 0;
        
        private var _maxProgrVal:Number = 0;
        
        private var _currentProgrVal:Number = 0;
        
        private var _tasksCount:int = 0;
        
        private var _progrTooltip:Object = null;
        
        public var hasConditions:Boolean = true;
        
        public var hasRequirements:Boolean = true;
        
        override protected function onDispose() : void {
            this._progrTooltip = null;
            super.onDispose();
        }
        
        public function get title() : String {
            return this._title;
        }
        
        public function set title(param1:String) : void {
            this._title = param1;
        }
        
        public function get date() : String {
            return this._date;
        }
        
        public function set date(param1:String) : void {
            this._date = param1;
        }
        
        public function get type() : String {
            return this._type;
        }
        
        public function set type(param1:String) : void {
            this._type = param1;
        }
        
        public function get impDescr() : String {
            return this._impDescr;
        }
        
        public function set impDescr(param1:String) : void {
            this._impDescr = param1;
        }
        
        public function get status() : String {
            return this._status;
        }
        
        public function set status(param1:String) : void {
            this._status = param1;
        }
        
        public function get progrBarType() : String {
            return this._progrBarType;
        }
        
        public function set progrBarType(param1:String) : void {
            this._progrBarType = param1;
        }
        
        public function get maxProgrVal() : Number {
            return this._maxProgrVal;
        }
        
        public function set maxProgrVal(param1:Number) : void {
            this._maxProgrVal = param1;
        }
        
        public function get currentProgrVal() : Number {
            return this._currentProgrVal;
        }
        
        public function set currentProgrVal(param1:Number) : void {
            this._currentProgrVal = param1;
        }
        
        public function get tasksCount() : int {
            return this._tasksCount;
        }
        
        public function set tasksCount(param1:int) : void {
            this._tasksCount = param1;
        }
        
        public function get progrTooltip() : Object {
            return this._progrTooltip;
        }
        
        public function set progrTooltip(param1:Object) : void {
            this._progrTooltip = param1;
        }
        
        public function get eventType() : int {
            return this._eventType;
        }
        
        public function set eventType(param1:int) : void {
            this._eventType = param1;
        }
        
        public function get statusDescription() : String {
            return this._statusDescription;
        }
        
        public function set statusDescription(param1:String) : void {
            this._statusDescription = param1;
        }
    }
}
