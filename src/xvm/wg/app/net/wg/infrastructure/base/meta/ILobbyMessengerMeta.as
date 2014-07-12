package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface ILobbyMessengerMeta extends IEventDispatcher
    {
        
        function requestOnRefreshMemberListS() : void;
        
        function requestRolePlayerS() : void;
        
        function requestToReadyBtnS(param1:Boolean) : void;
        
        function requestToLeaveBtnS() : void;
        
        function showPrebattleSendInvitesWindowS() : void;
        
        function as_onRefreshMemberList(param1:Array) : void;
        
        function as_onRolePlayer(param1:Object) : void;
        
        function as_enableLeaveBtn(param1:Boolean) : void;
        
        function as_enableReadyBtn(param1:Boolean) : void;
        
        function as_coolDownForReadyButton(param1:uint) : void;
        
        function as_toggleReadyBtn(param1:Boolean) : void;
        
        function as_setPlayerState(param1:Number, param2:Number, param3:String, param4:String, param5:String) : void;
    }
}
