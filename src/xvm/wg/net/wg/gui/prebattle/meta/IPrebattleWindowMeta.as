package net.wg.gui.prebattle.meta 
{
    import flash.events.*;
    
    public interface IPrebattleWindowMeta extends flash.events.IEventDispatcher
    {
        function requestToReadyS(arg1:Boolean):void;

        function requestToLeaveS():void;

        function showPrebattleSendInvitesWindowS():void;

        function showFAQWindowS():void;

        function canSendInviteS():Boolean;

        function canKickPlayerS():Boolean;

        function isPlayerReadyS():Boolean;

        function isPlayerCreatorS():Boolean;

        function isReadyBtnEnabledS():Boolean;

        function isLeaveBtnEnabledS():Boolean;

        function getClientIDS():Number;

        function as_setRosterList(arg1:int, arg2:Boolean, arg3:Array):void;

        function as_setPlayerState(arg1:int, arg2:Boolean, arg3:Object):void;

        function as_enableLeaveBtn(arg1:Boolean):void;

        function as_enableReadyBtn(arg1:Boolean):void;

        function as_setCoolDownForReadyButton(arg1:uint):void;

        function as_toggleReadyBtn(arg1:Boolean):void;

        function as_refreshPermissions():void;
    }
}
