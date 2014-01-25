package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class UnitCandidateVO extends DAAPIDataClass
   {
          
      public function UnitCandidateVO(param1:Object) {
         this._colors = [Number.NaN,Number.NaN];
         super(param1);
      }

      public var isInvite:Boolean = false;

      public var isSelf:Boolean = false;

      public var readyState:Boolean = false;

      public var chatRoster:Number = 0;

      public var isPlayerSpeaking:Boolean = false;

      public var igrType:int = 0;

      private var _isCommander:Boolean = false;

      private var _name:String = "";

      private var _clan:String = "";

      private var _region:String = "";

      private var _colors:Array;

      private var _rating:String = "";

      private var _databaseID:Number = 0;

      private var _isOffline:Boolean = false;

      public function getToolTip() : String {
         var _loc1_:String = this._name + (this._clan?"[" + this._clan + "]":"") + (this._region?" " + this._region:"");
         return _loc1_;
      }

      public function get himself() : Boolean {
         return this.isSelf;
      }

      public function get uid() : Number {
         return this._databaseID;
      }

      public function get userName() : String {
         return this._name;
      }

      public function get isCommander() : Boolean {
         return this._isCommander;
      }

      public function set isCommander(param1:Boolean) : void {
         this._isCommander = param1;
      }

      public function get name() : String {
         return this._name;
      }

      public function set name(param1:String) : void {
         this._name = param1;
      }

      public function get rating() : String {
         return this._rating;
      }

      public function set rating(param1:String) : void {
         this._rating = param1;
      }

      public function get databaseID() : Number {
         return this._databaseID;
      }

      public function get accID() : Number {
         return this._databaseID;
      }

      public function set databaseID(param1:Number) : void {
         this._databaseID = param1;
      }

      public function get clan() : String {
         return this._clan;
      }

      public function set clan(param1:String) : void {
         this._clan = param1;
      }

      public function get region() : String {
         return this._region;
      }

      public function set region(param1:String) : void {
         this._region = param1;
      }

      public function get colors() : Array {
         return this._colors;
      }

      public function set colors(param1:Array) : void {
         if((this._colors) && this._colors.length > 1)
         {
            this._colors = param1;
         }
      }

      public function get color() : Number {
         return this._colors[this._isOffline?1:0];
      }

      public function get isOffline() : Boolean {
         return this._isOffline;
      }

      public function set isOffline(param1:Boolean) : void {
         this._isOffline = param1;
      }

      public function isRatingAvailable() : Boolean {
         return !this.isInvite;
      }
   }

}