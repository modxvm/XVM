package net.wg.gui.tutorial.meta 
{
    import flash.events.*;
    
    public interface ITutorialDialogMeta extends flash.events.IEventDispatcher
    {
        function submitS():void;

        function cancelS():void;

        function as_setContent(arg1:Object):void;

        function as_updateContent(arg1:Object):void;
    }
}
