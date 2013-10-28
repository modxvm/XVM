package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class UnitCandidateVO extends DAAPIDataClass
   {
          
      public function UnitCandidateVO(param1:Object) {
         super(param1);
      }

      public var isInvite:Boolean = false;

      public var isSelf:Boolean = false;

      public var readyState:Boolean = false;

      public var chatRoster:Number = 0;

      public var isPlayerSpeaking:Boolean = false;

      private var _isCommander:Boolean = false;

      private var _name:String = "";

      private var _rating:Number = 0;

      private var _databaseID:Number = 0;

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

      public function get rating() : Number {
         return this._rating;
      }

      public function set rating(param1:Number) : void {
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
   }

}