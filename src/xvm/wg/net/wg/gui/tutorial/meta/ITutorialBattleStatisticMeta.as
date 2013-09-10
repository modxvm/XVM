package net.wg.gui.tutorial.meta 
{
    import flash.events.*;
    
    public interface ITutorialBattleStatisticMeta extends flash.events.IEventDispatcher
    {
        function restartS():void;

        function showVideoDialogS():void;

        function as_setData(arg1:Object):void;
    }
}
