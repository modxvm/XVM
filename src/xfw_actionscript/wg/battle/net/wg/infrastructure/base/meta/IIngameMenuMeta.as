package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IIngameMenuMeta extends IEventDispatcher
    {

        function quitBattleClickS() : void;

        function settingsClickS() : void;

        function helpClickS() : void;

        function cancelClickS() : void;

        function onCounterNeedUpdateS() : void;

        function bootcampClickS() : void;

        function as_setServerSetting(param1:String, param2:String, param3:int) : void;

        function as_setServerStats(param1:String, param2:String) : void;

        function as_setCounter(param1:Array) : void;

        function as_removeCounter(param1:Array) : void;

        function as_setMenuButtonsLabels(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void;

        function as_showQuitButton(param1:Boolean) : void;

        function as_showBootcampButton(param1:Boolean) : void;

        function as_showHelpButton(param1:Boolean) : void;
    }
}
