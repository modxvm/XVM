package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface ISquadViewMeta extends IEventDispatcher
    {
        
        function leaveSquadS() : void;
        
        function as_updateBattleType(param1:String) : void;
        
        function as_updateInviteBtnState(param1:Boolean) : void;
        
        function as_setCoolDownForReadyButton(param1:Number) : void;
    }
}
