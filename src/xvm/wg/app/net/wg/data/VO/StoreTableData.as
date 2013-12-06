package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.data.constants.Errors;


   public class StoreTableData extends DAAPIDataClass
   {
          
      public function StoreTableData(param1:Object) {
         super(param1);
      }

      private var _extraModuleInfo:String = "";

      private var _id:String = "";

      private var _requestType:String = "";

      private var _name:String = "";

      private var _desc:String = "";

      private var _inventoryId:Number = 0;

      private var _inventoryCount:int = 0;

      private var _vehicleCount:int = 0;

      private var _credits:int = 0;

      private var _gold:int = 0;

      private var _price:Array = null;

      private var _defPrice:Array = null;

      private var _currency:String = "";

      private var _level:int = 0;

      private var _nation:int = 0;

      private var _type:String = "";

      private var _disabled:String = "";

      private var _statusLevel:String = "";

      private var _removable:Boolean = false;

      private var _tankType:String = "";

      private var _isPremium:Boolean = false;

      private var _isElite:Boolean = false;

      private var _itemTypeName:String = "";

      private var _goldShellsForCredits:Boolean = false;

      private var _goldEqsForCredits:Boolean = false;

      private var _actionPrc:Number = 0;

      private var _tableVO:StoreTableVO = null;

      public function get goldEqsForCredits() : Boolean {
         return this._goldEqsForCredits;
      }

      public function set goldEqsForCredits(param1:Boolean) : void {
         this._goldEqsForCredits = param1;
      }

      public function get id() : String {
         return this._id;
      }

      public function set id(param1:String) : void {
         this._id = param1;
      }

      public function get requestType() : String {
         return this._requestType;
      }

      public function set requestType(param1:String) : void {
         this._requestType = param1;
      }

      public function get name() : String {
         return this._name;
      }

      public function set name(param1:String) : void {
         this._name = param1;
      }

      public function get desc() : String {
         return this._desc;
      }

      public function set desc(param1:String) : void {
         this._desc = param1;
      }

      public function get inventoryId() : Number {
         return this._inventoryId;
      }

      public function set inventoryId(param1:Number) : void {
         this._inventoryId = param1;
      }

      public function get inventoryCount() : int {
         return this._inventoryCount;
      }

      public function set inventoryCount(param1:int) : void {
         this._inventoryCount = param1;
      }

      public function get vehicleCount() : int {
         return this._vehicleCount;
      }

      public function set vehicleCount(param1:int) : void {
         this._vehicleCount = param1;
      }

      public function get credits() : int {
         return this._credits;
      }

      public function set credits(param1:int) : void {
         this._credits = param1;
      }

      public function get gold() : int {
         return this._gold;
      }

      public function set gold(param1:int) : void {
         this._gold = param1;
      }

      public function get price() : Array {
         return this._price;
      }

      public function set price(param1:Array) : void {
         this._price = param1;
      }

      public function get defPrice() : Array {
         return this._defPrice;
      }

      public function set defPrice(param1:Array) : void {
         this._defPrice = param1;
      }

      public function get currency() : String {
         return this._currency;
      }

      public function set currency(param1:String) : void {
         this._currency = param1;
      }

      public function get level() : int {
         return this._level;
      }

      public function set level(param1:int) : void {
         this._level = param1;
      }

      public function get nation() : int {
         return this._nation;
      }

      public function set nation(param1:int) : void {
         this._nation = param1;
      }

      public function get type() : String {
         return this._type;
      }

      public function set type(param1:String) : void {
         this._type = param1;
      }

      public function get disabled() : String {
         return this._disabled;
      }

      public function set disabled(param1:String) : void {
         this._disabled = param1;
      }

      public function get statusLevel() : String {
         return this._statusLevel;
      }

      public function set statusLevel(param1:String) : void {
         this._statusLevel = param1;
      }

      public function get removable() : Boolean {
         return this._removable;
      }

      public function set removable(param1:Boolean) : void {
         this._removable = param1;
      }

      public function get tankType() : String {
         return this._tankType;
      }

      public function set tankType(param1:String) : void {
         this._tankType = param1;
      }

      public function get isPremium() : Boolean {
         return this._isPremium;
      }

      public function set isPremium(param1:Boolean) : void {
         this._isPremium = param1;
      }

      public function get isElite() : Boolean {
         return this._isElite;
      }

      public function set isElite(param1:Boolean) : void {
         this._isElite = param1;
      }

      public function get itemTypeName() : String {
         return this._itemTypeName;
      }

      public function set itemTypeName(param1:String) : void {
         this._itemTypeName = param1;
      }

      public function get goldShellsForCredits() : Boolean {
         return this._goldShellsForCredits;
      }

      public function set goldShellsForCredits(param1:Boolean) : void {
         this._goldShellsForCredits = param1;
      }

      public function get actionPrc() : Number {
         return this._actionPrc;
      }

      public function set actionPrc(param1:Number) : void {
         this._actionPrc = param1;
      }

      public function get tableVO() : StoreTableVO {
         return this._tableVO;
      }

      public function set tableVO(param1:StoreTableVO) : void {
         if(App.instance)
         {
            App.utils.asserter.assertNotNull(param1,"tableVO argument " + Errors.CANT_NULL);
            this._tableVO = param1;
         }
      }

      public function get extraModuleInfo() : String {
         return this._extraModuleInfo;
      }

      public function set extraModuleInfo(param1:String) : void {
         this._extraModuleInfo = param1;
      }
   }

}