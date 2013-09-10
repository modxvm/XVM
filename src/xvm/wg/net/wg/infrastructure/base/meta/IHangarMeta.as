package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IHangarMeta extends flash.events.IEventDispatcher
    {
        function onEscapeS():void;

        function checkMoneyS():void;

        function showHelpLayoutS():void;

        function closeHelpLayoutS():void;

        function as_readyToFight(arg1:Boolean, arg2:String, arg3:String, arg4:Boolean, arg5:Boolean, arg6:Boolean, arg7:Boolean, arg8:Boolean):void;

        function as_showHelpLayout():void;

        function as_closeHelpLayout():void;

        function as_setIsIGR(arg1:Boolean):void;
    }
}
