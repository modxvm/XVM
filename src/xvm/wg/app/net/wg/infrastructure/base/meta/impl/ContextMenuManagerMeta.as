package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIModule;
    import net.wg.data.constants.Errors;
    import net.wg.data.daapi.ContextMenuOptionsVO;
    import net.wg.infrastructure.exceptions.AbstractException;
    
    public class ContextMenuManagerMeta extends BaseDAAPIModule
    {
        
        public function ContextMenuManagerMeta()
        {
            super();
        }
        
        public var requestOptions:Function = null;
        
        public var onOptionSelect:Function = null;
        
        public var onHide:Function = null;
        
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
        
        public var kickPlayerFromPrebattle:Function = null;
        
        public var kickPlayerFromUnit:Function = null;
        
        public var giveLeadership:Function = null;
        
        public var canGiveLeadership:Function = null;
        
        public var createSquad:Function = null;
        
        public var invite:Function = null;
        
        public var canInvite:Function = null;
        
        public var fortDirection:Function = null;
        
        public var fortAssignPlayers:Function = null;
        
        public var fortModernization:Function = null;
        
        public var fortDestroy:Function = null;
        
        public var fortPrepareOrder:Function = null;
        
        public function requestOptionsS(param1:String, param2:String, param3:Object = null) : void
        {
            App.utils.asserter.assertNotNull(this.requestOptions,"requestOptions" + Errors.CANT_NULL);
            this.requestOptions(param1,param2,param3);
        }
        
        public function onOptionSelectS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.onOptionSelect,"onOptionSelect" + Errors.CANT_NULL);
            this.onOptionSelect(param1);
        }
        
        public function onHideS() : void
        {
            App.utils.asserter.assertNotNull(this.onHide,"onHide" + Errors.CANT_NULL);
            this.onHide();
        }
        
        public function _getUserInfoS(param1:Number, param2:String) : Object
        {
            App.utils.asserter.assertNotNull(this._getUserInfo,"_getUserInfo" + Errors.CANT_NULL);
            return this._getUserInfo(param1,param2);
        }
        
        public function _getDenunciationsS() : Number
        {
            App.utils.asserter.assertNotNull(this._getDenunciations,"_getDenunciations" + Errors.CANT_NULL);
            return this._getDenunciations();
        }
        
        public function _isMoneyTransferS() : Boolean
        {
            App.utils.asserter.assertNotNull(this._isMoneyTransfer,"_isMoneyTransfer" + Errors.CANT_NULL);
            return this._isMoneyTransfer();
        }
        
        public function showUserInfoS(param1:Number, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.showUserInfo,"showUserInfo" + Errors.CANT_NULL);
            this.showUserInfo(param1,param2);
        }
        
        public function showMoneyTransferS(param1:Number, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.showMoneyTransfer,"showMoneyTransfer" + Errors.CANT_NULL);
            this.showMoneyTransfer(param1,param2);
        }
        
        public function createPrivateChannelS(param1:Number, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.createPrivateChannel,"createPrivateChannel" + Errors.CANT_NULL);
            this.createPrivateChannel(param1,param2);
        }
        
        public function addFriendS(param1:Number, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.addFriend,"addFriend" + Errors.CANT_NULL);
            this.addFriend(param1,param2);
        }
        
        public function removeFriendS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.removeFriend,"removeFriend" + Errors.CANT_NULL);
            this.removeFriend(param1);
        }
        
        public function setMutedS(param1:Number, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.setMuted,"setMuted" + Errors.CANT_NULL);
            this.setMuted(param1,param2);
        }
        
        public function unsetMutedS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.unsetMuted,"unsetMuted" + Errors.CANT_NULL);
            this.unsetMuted(param1);
        }
        
        public function setIgnoredS(param1:Number, param2:String) : void
        {
            App.utils.asserter.assertNotNull(this.setIgnored,"setIgnored" + Errors.CANT_NULL);
            this.setIgnored(param1,param2);
        }
        
        public function unsetIgnoredS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.unsetIgnored,"unsetIgnored" + Errors.CANT_NULL);
            this.unsetIgnored(param1);
        }
        
        public function appealS(param1:Number, param2:String, param3:String) : void
        {
            App.utils.asserter.assertNotNull(this.appeal,"appeal" + Errors.CANT_NULL);
            this.appeal(param1,param2,param3);
        }
        
        public function copyToClipboardS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.copyToClipboard,"copyToClipboard" + Errors.CANT_NULL);
            this.copyToClipboard(param1);
        }
        
        public function kickPlayerFromPrebattleS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.kickPlayerFromPrebattle,"kickPlayerFromPrebattle" + Errors.CANT_NULL);
            this.kickPlayerFromPrebattle(param1);
        }
        
        public function kickPlayerFromUnitS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.kickPlayerFromUnit,"kickPlayerFromUnit" + Errors.CANT_NULL);
            this.kickPlayerFromUnit(param1);
        }
        
        public function giveLeadershipS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.giveLeadership,"giveLeadership" + Errors.CANT_NULL);
            this.giveLeadership(param1);
        }
        
        public function canGiveLeadershipS(param1:Number) : Boolean
        {
            App.utils.asserter.assertNotNull(this.canGiveLeadership,"canGiveLeadership" + Errors.CANT_NULL);
            return this.canGiveLeadership(param1);
        }
        
        public function createSquadS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.createSquad,"createSquad" + Errors.CANT_NULL);
            this.createSquad(param1);
        }
        
        public function inviteS(param1:Number, param2:Object) : void
        {
            App.utils.asserter.assertNotNull(this.invite,"invite" + Errors.CANT_NULL);
            this.invite(param1,param2);
        }
        
        public function canInviteS(param1:Number) : Boolean
        {
            App.utils.asserter.assertNotNull(this.canInvite,"canInvite" + Errors.CANT_NULL);
            return this.canInvite(param1);
        }
        
        public function fortDirectionS() : void
        {
            App.utils.asserter.assertNotNull(this.fortDirection,"fortDirection" + Errors.CANT_NULL);
            this.fortDirection();
        }
        
        public function fortAssignPlayersS(param1:Object) : void
        {
            App.utils.asserter.assertNotNull(this.fortAssignPlayers,"fortAssignPlayers" + Errors.CANT_NULL);
            this.fortAssignPlayers(param1);
        }
        
        public function fortModernizationS(param1:Object) : void
        {
            App.utils.asserter.assertNotNull(this.fortModernization,"fortModernization" + Errors.CANT_NULL);
            this.fortModernization(param1);
        }
        
        public function fortDestroyS(param1:Object) : void
        {
            App.utils.asserter.assertNotNull(this.fortDestroy,"fortDestroy" + Errors.CANT_NULL);
            this.fortDestroy(param1);
        }
        
        public function fortPrepareOrderS(param1:Object) : void
        {
            App.utils.asserter.assertNotNull(this.fortPrepareOrder,"fortPrepareOrder" + Errors.CANT_NULL);
            this.fortPrepareOrder(param1);
        }
        
        public function as_setOptions(param1:Object) : void
        {
            var _loc2_:ContextMenuOptionsVO = new ContextMenuOptionsVO(param1);
            this.setOptions(_loc2_);
        }
        
        protected function setOptions(param1:ContextMenuOptionsVO) : void
        {
            var _loc2_:String = "as_setOptions" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
