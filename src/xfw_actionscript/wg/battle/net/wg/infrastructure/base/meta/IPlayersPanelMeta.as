package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IPlayersPanelMeta extends IEventDispatcher
    {

        function tryToSetPanelModeByMouseS(param1:int) : void;

        function switchToOtherPlayerS(param1:Number) : void;

        function as_setPanelMode(param1:int) : void;

        function as_setChatCommandsVisibility(param1:Boolean) : void;
    }
}
