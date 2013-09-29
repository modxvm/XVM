package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ILobbyMenuMeta extends flash.events.IEventDispatcher
    {
        function settingsClickS():void;

        function cancelClickS():void;

        function refuseTrainingS():void;

        function logoffClickS():void;

        function quitClickS():void;
    }
}
