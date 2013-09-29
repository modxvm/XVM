package net.wg.gui.prebattle.meta 
{
    import flash.events.*;
    
    public interface IBattleSessionListMeta extends flash.events.IEventDispatcher
    {
        function requestToJoinTeamS(arg1:Number, arg2:Number):void;

        function getClientIDS():Number;

        function as_refreshList(arg1:Array):void;
    }
}
