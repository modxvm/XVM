package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IDestroyTimersPanelMeta extends IEventDispatcher
    {

        function as_show(param1:int, param2:int, param3:Boolean) : void;

        function as_hide(param1:int) : void;

        function as_setVerticalOffset(param1:int) : void;

        function as_setTimeInSeconds(param1:int, param2:int, param3:Number) : void;

        function as_setTimeSnapshot(param1:int, param2:int, param3:int) : void;

        function as_setSpeed(param1:Number) : void;

        function as_turnOnStackView(param1:Boolean) : void;

        function as_showSecondaryTimer(param1:int, param2:int, param3:Number, param4:Boolean) : void;

        function as_hideSecondaryTimer(param1:int) : void;

        function as_setSecondaryTimeSnapshot(param1:int, param2:int, param3:Number) : void;

        function as_setSecondaryTimerText(param1:int, param2:String) : void;
    }
}
