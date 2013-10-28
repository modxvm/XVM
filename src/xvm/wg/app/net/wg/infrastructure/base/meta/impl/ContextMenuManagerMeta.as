package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.data.constants.Errors;


   public class ContextMenuManagerMeta extends BaseDAAPIModule
   {
          
      public function ContextMenuManagerMeta() {
         super();
      }

      public var getOptions:Function = null;

      public var _getUserInfo:Function = null;

      public var _getDenunciations:Function = null;

      public var _isMoneyTransfer:Function = null;

      public var showUserInfo:Function = null;

      public var showMoneyTransfer:Function = null;

      public var createPrivateChannel:Function = null;

      public var addFriend:Function = null;

      public var removeFriend:Function = null;

      public var setMuted:Function = null;

      public var unsetMuted:Function = null;

      public var setIgnored:Function = null;

      public var unsetIgnored:Function = null;

      public var appeal:Function = null;

      public var copyToClipboard:Function = null;

      public var kickPlayer:Function = null;

      public function getOptionsS(param1:String, param2:String, param3:Number, param4:Object) : Array {
         App.utils.asserter.assertNotNull(this.getOptions,"getOptions" + Errors.CANT_NULL);
         return this.getOptions(param1,param2,param3,param4);
      }

      public function _getUserInfoS(param1:Number, param2:String) : Object {
         App.utils.asserter.assertNotNull(this._getUserInfo,"_getUserInfo" + Errors.CANT_NULL);
         return this._getUserInfo(param1,param2);
      }

      public function _getDenunciationsS() : Number {
         App.utils.asserter.assertNotNull(this._getDenunciations,"_getDenunciations" + Errors.CANT_NULL);
         return this._getDenunciations();
      }

      public function _isMoneyTransferS() : Boolean {
         App.utils.asserter.assertNotNull(this._isMoneyTransfer,"_isMoneyTransfer" + Errors.CANT_NULL);
         return this._isMoneyTransfer();
      }

      public function showUserInfoS(param1:Number, param2:String) : void {
         App.utils.asserter.assertNotNull(this.showUserInfo,"showUserInfo" + Errors.CANT_NULL);
         this.showUserInfo(param1,param2);
      }

      public function showMoneyTransferS(param1:Number, param2:String) : void {
         App.utils.asserter.assertNotNull(this.showMoneyTransfer,"showMoneyTransfer" + Errors.CANT_NULL);
         this.showMoneyTransfer(param1,param2);
      }

      public function createPrivateChannelS(param1:Number, param2:String) : void {
         App.utils.asserter.assertNotNull(this.createPrivateChannel,"createPrivateChannel" + Errors.CANT_NULL);
         this.createPrivateChannel(param1,param2);
      }

      public function addFriendS(param1:Number, param2:String) : void {
         App.utils.asserter.assertNotNull(this.addFriend,"addFriend" + Errors.CANT_NULL);
         this.addFriend(param1,param2);
      }

      public function removeFriendS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.removeFriend,"removeFriend" + Errors.CANT_NULL);
         this.removeFriend(param1);
      }

      public function setMutedS(param1:Number, param2:String) : void {
         App.utils.asserter.assertNotNull(this.setMuted,"setMuted" + Errors.CANT_NULL);
         this.setMuted(param1,param2);
      }

      public function unsetMutedS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.unsetMuted,"unsetMuted" + Errors.CANT_NULL);
         this.unsetMuted(param1);
      }

      public function setIgnoredS(param1:Number, param2:String) : void {
         App.utils.asserter.assertNotNull(this.setIgnored,"setIgnored" + Errors.CANT_NULL);
         this.setIgnored(param1,param2);
      }

      public function unsetIgnoredS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.unsetIgnored,"unsetIgnored" + Errors.CANT_NULL);
         this.unsetIgnored(param1);
      }

      public function appealS(param1:Number, param2:String, param3:String) : void {
         App.utils.asserter.assertNotNull(this.appeal,"appeal" + Errors.CANT_NULL);
         this.appeal(param1,param2,param3);
      }

      public function copyToClipboardS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.copyToClipboard,"copyToClipboard" + Errors.CANT_NULL);
         this.copyToClipboard(param1);
      }

      public function kickPlayerS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.kickPlayer,"kickPlayer" + Errors.CANT_NULL);
         this.kickPlayer(param1);
      }
   }

}