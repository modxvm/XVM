package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class CSCommandVO extends DAAPIDataClass
   {
          
      public function CSCommandVO(param1:Object) {
         this._vehicles = [];
         super(param1);
      }

      private var _creator:String = "";

      private var _vehicles:Array;

      private var _cfdUnitID:Number = 0;

      private var _unitMgrID:Number = 0;

      private var _specialState:String = "";

      private var _inBattle:Boolean = false;

      private var _commandSize:Number = 7;

      private var _playersCount:Number = 0;

      private var _rating:Number = 0;

      private var _isFreezed:Boolean = false;

      private var _isRestricted:Boolean = false;

      private var _server:String = "";

      public var navigationConfig:NavigationBlockVO = null;

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         if(param1 == "navigationBlock")
         {
            this.navigationConfig = new NavigationBlockVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }

      public function get isLoadMoreState() : Boolean {
         return !(this.navigationConfig == null);
      }

      public function get creator() : String {
         return this._creator;
      }

      public function set creator(param1:String) : void {
         this._creator = param1;
      }

      public function get vehicles() : Array {
         return this._vehicles;
      }

      public function set vehicles(param1:Array) : void {
         this._vehicles = param1;
      }

      public function get specialState() : String {
         return this._specialState;
      }

      public function set specialState(param1:String) : void {
         this._specialState = param1;
      }

      public function get inBattle() : Boolean {
         return this._inBattle;
      }

      public function set inBattle(param1:Boolean) : void {
         this._inBattle = param1;
      }

      public function get commandSize() : Number {
         return this._commandSize;
      }

      public function set commandSize(param1:Number) : void {
         this._commandSize = param1;
      }

      public function get playersCount() : Number {
         return this._playersCount;
      }

      public function set playersCount(param1:Number) : void {
         this._playersCount = param1;
      }

      public function get rating() : Number {
         return this._rating;
      }

      public function set rating(param1:Number) : void {
         this._rating = param1;
      }

      public function get cfdUnitID() : Number {
         return this._cfdUnitID;
      }

      public function set cfdUnitID(param1:Number) : void {
         this._cfdUnitID = param1;
      }

      public function get unitMgrID() : Number {
         return this._unitMgrID;
      }

      public function set unitMgrID(param1:Number) : void {
         this._unitMgrID = param1;
      }

      public function get isFreezed() : Boolean {
         return this._isFreezed;
      }

      public function set isFreezed(param1:Boolean) : void {
         this._isFreezed = param1;
      }

      public function get isRestricted() : Boolean {
         return this._isRestricted;
      }

      public function set isRestricted(param1:Boolean) : void {
         this._isRestricted = param1;
      }

      public function get server() : String {
         return this._server;
      }

      public function set server(param1:String) : void {
         this._server = param1;
      }
   }

}