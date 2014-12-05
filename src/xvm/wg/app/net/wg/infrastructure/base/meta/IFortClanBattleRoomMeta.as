package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortClanBattleRoomMeta extends IEventDispatcher
    {
        
        function onTimerAlertS() : void;
        
        function as_updateTeamHeaderText(param1:String) : void;
        
        function as_setBattleRoomData(param1:Object) : void;
        
        function as_updateReadyStatus(param1:Boolean, param2:Boolean) : void;
        
        function as_setTimerDelta(param1:Object) : void;
        
        function as_updateDirections(param1:Object) : void;
        
        function as_setMineClanIcon(param1:String) : void;
        
        function as_setEnemyClanIcon(param1:String) : void;
    }
}
