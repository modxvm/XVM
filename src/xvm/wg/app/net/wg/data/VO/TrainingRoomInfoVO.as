package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class TrainingRoomInfoVO extends DAAPIDataClass
   {
          
      public function TrainingRoomInfoVO(param1:Object) {
         super(param1);
      }

      private var _comment:String = "";

      private var _arenaName:String = "";

      private var _roundLenString:String = "";

      private var _maxPlayersCount:Number = 0;

      private var _arenaSubType:String = "";

      private var _creator:String = "";

      private var _arenaTypeID:Number = 0;

      private var _description:String = "";

      private var _title:String = "";

      private var _canChangeArenaVOIP:Boolean;

      private var _arenaVoipChannels:Number = -1;

      private var _isCreator:Boolean;

      public function get title() : String {
         return this._title;
      }

      public function set title(param1:String) : void {
         this._title = param1;
      }

      public function get isCreator() : Boolean {
         return this._isCreator;
      }

      public function set isCreator(param1:Boolean) : void {
         this._isCreator = param1;
      }

      public function get canChangeArenaVOIP() : Boolean {
         return this._canChangeArenaVOIP;
      }

      public function set canChangeArenaVOIP(param1:Boolean) : void {
         this._canChangeArenaVOIP = param1;
      }

      public function get arenaVoipChannels() : Number {
         return this._arenaVoipChannels;
      }

      public function set arenaVoipChannels(param1:Number) : void {
         this._arenaVoipChannels = param1;
      }

      public function get description() : String {
         return this._description;
      }

      public function set description(param1:String) : void {
         this._description = param1;
      }

      public function get arenaTypeID() : Number {
         return this._arenaTypeID;
      }

      public function set arenaTypeID(param1:Number) : void {
         this._arenaTypeID = param1;
      }

      public function get creator() : String {
         return this._creator;
      }

      public function set creator(param1:String) : void {
         this._creator = param1;
      }

      public function get arenaSubType() : String {
         return this._arenaSubType;
      }

      public function set arenaSubType(param1:String) : void {
         this._arenaSubType = param1;
      }

      public function get arenaName() : String {
         return this._arenaName;
      }

      public function set arenaName(param1:String) : void {
         this._arenaName = param1;
      }

      public function get maxPlayersCount() : Number {
         return this._maxPlayersCount;
      }

      public function set maxPlayersCount(param1:Number) : void {
         this._maxPlayersCount = param1;
      }

      public function get roundLenString() : String {
         return this._roundLenString;
      }

      public function set roundLenString(param1:String) : void {
         this._roundLenString = param1;
      }

      public function get comment() : String {
         return this._comment;
      }

      public function set comment(param1:String) : void {
         this._comment = param1;
      }
   }

}