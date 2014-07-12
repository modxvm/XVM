package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class QuestRendererVO extends DAAPIDataClass
   {
      
      public function QuestRendererVO(param1:Object) {
         super(param1);
      }
      
      private var _isNew:Boolean = false;
      
      private var _status:String = "";
      
      private var _IGR:Boolean = false;
      
      private var _taskType:String = "";
      
      private var _description:String = "";
      
      private var _timerDescr:String = "";
      
      private var _tasksCount:int = 0;
      
      private var _progrBarType:String = "";
      
      private var _maxProgrVal:Number = 0;
      
      private var _currentProgrVal:Number = 0;
      
      private var _isLock:Boolean = false;
      
      private var _isLocked:Boolean = false;
      
      private var _questID:String = "";
      
      private var _progrTooltip:Object = null;
      
      private var _eventType:int = 0;
      
      public function get isNew() : Boolean {
         return this._isNew;
      }
      
      public function set isNew(param1:Boolean) : void {
         this._isNew = param1;
      }
      
      public function get IGR() : Boolean {
         return this._IGR;
      }
      
      public function set IGR(param1:Boolean) : void {
         this._IGR = param1;
      }
      
      public function get taskType() : String {
         return this._taskType;
      }
      
      public function set taskType(param1:String) : void {
         this._taskType = param1;
      }
      
      public function get description() : String {
         return this._description;
      }
      
      public function set description(param1:String) : void {
         this._description = param1;
      }
      
      public function get timerDescr() : String {
         return this._timerDescr;
      }
      
      public function set timerDescr(param1:String) : void {
         this._timerDescr = param1;
      }
      
      public function get tasksCount() : int {
         return this._tasksCount;
      }
      
      public function set tasksCount(param1:int) : void {
         this._tasksCount = param1;
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
      
      public function get progrBarType() : String {
         return this._progrBarType;
      }
      
      public function set progrBarType(param1:String) : void {
         this._progrBarType = param1;
      }
      
      public function get status() : String {
         return this._status;
      }
      
      public function set status(param1:String) : void {
         this._status = param1;
      }
      
      public function get isLock() : Boolean {
         return this._isLock;
      }
      
      public function set isLock(param1:Boolean) : void {
         this._isLock = param1;
      }
      
      public function get isLocked() : Boolean {
         return this._isLocked;
      }
      
      public function set isLocked(param1:Boolean) : void {
         this._isLocked = param1;
      }
      
      public function get questID() : String {
         return this._questID;
      }
      
      public function set questID(param1:String) : void {
         this._questID = param1;
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
   }
}
