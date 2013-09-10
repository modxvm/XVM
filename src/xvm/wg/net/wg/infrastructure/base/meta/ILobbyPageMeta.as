package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ILobbyPageMeta extends flash.events.IEventDispatcher
    {
        function moveSpaceS(arg1:Number, arg2:Number, arg3:Number):void;

        function as_showHelpLayout():void;

        function as_closeHelpLayout():void;
    }
}
