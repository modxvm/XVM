package net.wg.data.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class PlayerInfo extends DAAPIDataClass
   {
          
      public function PlayerInfo(param1:Object) {
         super(param1);
      }

      private var _isFriend:Boolean;

      private var _isIgnored:Boolean;

      private var _isMuted:Boolean;

      private var _displayName:String = "";

      private var _isEnabledInRoaming:Boolean = true;

      public function get displayName() : String {
         return this._displayName;
      }

      public function set displayName(param1:String) : void {
         this._displayName = param1;
      }

      public function get isMuted() : Boolean {
         return this._isMuted;
      }

      public function set isMuted(param1:Boolean) : void {
         this._isMuted = param1;
      }

      public function get isIgnored() : Boolean {
         return this._isIgnored;
      }

      public function set isIgnored(param1:Boolean) : void {
         this._isIgnored = param1;
      }

      public function get isFriend() : Boolean {
         return this._isFriend;
      }

      public function set isFriend(param1:Boolean) : void {
         this._isFriend = param1;
      }

      public function get isEnabledInRoaming() : Boolean {
         return this._isEnabledInRoaming;
      }

      public function set isEnabledInRoaming(param1:Boolean) : void {
         this._isEnabledInRoaming = param1;
      }
   }

}