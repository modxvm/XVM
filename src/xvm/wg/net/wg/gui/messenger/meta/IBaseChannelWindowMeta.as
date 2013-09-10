package net.wg.gui.messenger.meta 
{
    import flash.events.*;
    
    public interface IBaseChannelWindowMeta extends flash.events.IEventDispatcher
    {
        function showFAQWindowS():void;

        function getClientIDS():Number;

        function as_setTitle(arg1:String):void;

        function as_setCloseEnabled(arg1:Boolean):void;
    }
}
