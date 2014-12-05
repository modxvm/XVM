package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IContextMenuManagerMeta extends IEventDispatcher
    {
        
        function requestOptionsS(param1:String, param2:String, param3:Object = null) : void;
        
        function onOptionSelectS(param1:String) : void;
        
        function onHideS() : void;
        
        function _getUserInfoS(param1:Number, param2:String) : Object;
        
        function _getDenunciationsS() : Number;
        
        function _isMoneyTransferS() : Boolean;
        
        function showUserInfoS(param1:Number, param2:String) : void;
        
        function showMoneyTransferS(param1:Number, param2:String) : void;
        
        function createPrivateChannelS(param1:Number, param2:String) : void;
        
        function addFriendS(param1:Number, param2:String) : void;
        
        function removeFriendS(param1:Number) : void;
        
        function setMutedS(param1:Number, param2:String) : void;
        
        function unsetMutedS(param1:Number) : void;
        
        function setIgnoredS(param1:Number, param2:String) : void;
        
        function unsetIgnoredS(param1:Number) : void;
        
        function appealS(param1:Number, param2:String, param3:String) : void;
        
        function copyToClipboardS(param1:String) : void;
        
        function kickPlayerFromPrebattleS(param1:Number) : void;
        
        function kickPlayerFromUnitS(param1:Number) : void;
        
        function giveLeadershipS(param1:Number) : void;
        
        function canGiveLeadershipS(param1:Number) : Boolean;
        
        function createSquadS(param1:Number) : void;
        
        function inviteS(param1:Number, param2:Object) : void;
        
        function canInviteS(param1:Number) : Boolean;
        
        function fortDirectionS() : void;
        
        function fortAssignPlayersS(param1:Object) : void;
        
        function fortModernizationS(param1:Object) : void;
        
        function fortDestroyS(param1:Object) : void;
        
        function fortPrepareOrderS(param1:Object) : void;
        
        function as_setOptions(param1:Object) : void;
    }
}
