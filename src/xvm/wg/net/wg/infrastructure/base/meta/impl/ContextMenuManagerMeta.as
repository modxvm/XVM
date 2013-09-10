package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ContextMenuManagerMeta extends net.wg.infrastructure.base.BaseDAAPIModule
    {
        public function ContextMenuManagerMeta()
        {
            super();
            return;
        }

        public function getOptionsS(arg1:String, arg2:String, arg3:Number, arg4:Object):Array
        {
            App.utils.asserter.assertNotNull(this.getOptions, "getOptions" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getOptions(arg1, arg2, arg3, arg4);
        }

        public function _getUserInfoS(arg1:Number, arg2:String):Object
        {
            App.utils.asserter.assertNotNull(this._getUserInfo, "_getUserInfo" + net.wg.data.constants.Errors.CANT_NULL);
            return this._getUserInfo(arg1, arg2);
        }

        public function _getDenunciationsS():Number
        {
            App.utils.asserter.assertNotNull(this._getDenunciations, "_getDenunciations" + net.wg.data.constants.Errors.CANT_NULL);
            return this._getDenunciations();
        }

        public function _isMoneyTransferS():Boolean
        {
            App.utils.asserter.assertNotNull(this._isMoneyTransfer, "_isMoneyTransfer" + net.wg.data.constants.Errors.CANT_NULL);
            return this._isMoneyTransfer();
        }

        public function showUserInfoS(arg1:Number, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.showUserInfo, "showUserInfo" + net.wg.data.constants.Errors.CANT_NULL);
            this.showUserInfo(arg1, arg2);
            return;
        }

        public function showMoneyTransferS(arg1:Number, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.showMoneyTransfer, "showMoneyTransfer" + net.wg.data.constants.Errors.CANT_NULL);
            this.showMoneyTransfer(arg1, arg2);
            return;
        }

        public function createPrivateChannelS(arg1:Number, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.createPrivateChannel, "createPrivateChannel" + net.wg.data.constants.Errors.CANT_NULL);
            this.createPrivateChannel(arg1, arg2);
            return;
        }

        public function addFriendS(arg1:Number, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.addFriend, "addFriend" + net.wg.data.constants.Errors.CANT_NULL);
            this.addFriend(arg1, arg2);
            return;
        }

        public function removeFriendS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.removeFriend, "removeFriend" + net.wg.data.constants.Errors.CANT_NULL);
            this.removeFriend(arg1);
            return;
        }

        public function setMutedS(arg1:Number, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.setMuted, "setMuted" + net.wg.data.constants.Errors.CANT_NULL);
            this.setMuted(arg1, arg2);
            return;
        }

        public function unsetMutedS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.unsetMuted, "unsetMuted" + net.wg.data.constants.Errors.CANT_NULL);
            this.unsetMuted(arg1);
            return;
        }

        public function setIgnoredS(arg1:Number, arg2:String):void
        {
            App.utils.asserter.assertNotNull(this.setIgnored, "setIgnored" + net.wg.data.constants.Errors.CANT_NULL);
            this.setIgnored(arg1, arg2);
            return;
        }

        public function unsetIgnoredS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.unsetIgnored, "unsetIgnored" + net.wg.data.constants.Errors.CANT_NULL);
            this.unsetIgnored(arg1);
            return;
        }

        public function appealS(arg1:Number, arg2:String, arg3:String):void
        {
            App.utils.asserter.assertNotNull(this.appeal, "appeal" + net.wg.data.constants.Errors.CANT_NULL);
            this.appeal(arg1, arg2, arg3);
            return;
        }

        public function copyToClipboardS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.copyToClipboard, "copyToClipboard" + net.wg.data.constants.Errors.CANT_NULL);
            this.copyToClipboard(arg1);
            return;
        }

        public function kickPlayerS(arg1:Number):void
        {
            App.utils.asserter.assertNotNull(this.kickPlayer, "kickPlayer" + net.wg.data.constants.Errors.CANT_NULL);
            this.kickPlayer(arg1);
            return;
        }

        public var getOptions:Function=null;

        public var _getUserInfo:Function=null;

        public var _getDenunciations:Function=null;

        public var _isMoneyTransfer:Function=null;

        public var showUserInfo:Function=null;

        public var showMoneyTransfer:Function=null;

        public var createPrivateChannel:Function=null;

        public var addFriend:Function=null;

        public var removeFriend:Function=null;

        public var setMuted:Function=null;

        public var unsetMuted:Function=null;

        public var setIgnored:Function=null;

        public var unsetIgnored:Function=null;

        public var appeal:Function=null;

        public var copyToClipboard:Function=null;

        public var kickPlayer:Function=null;
    }
}
