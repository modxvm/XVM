package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface ILobbyMenuMeta extends IEventDispatcher
    {

        function settingsClickS() : void;

        function cancelClickS() : void;

        function refuseTrainingS() : void;

        function logoffClickS() : void;

        function quitClickS() : void;

        function postClickS() : void;

        function onCounterNeedUpdateS() : void;

        function bootcampClickS() : void;

        function onEscapePressS() : void;

        function manualClickS() : void;

        function as_setVersionMessage(param1:String) : void;

        function as_setCounter(param1:Array) : void;

        function as_removeCounter(param1:Array) : void;

        function as_setBootcampButtonLabel(param1:String, param2:String) : void;

        function as_setPostButtonIcons(param1:String, param2:String) : void;

        function as_setPostButtonVisible(param1:Boolean) : void;

        function as_showBootcampButton(param1:Boolean) : void;

        function as_showManualButton(param1:Boolean) : void;

        function as_setMenuState(param1:String) : void;
    }
}
