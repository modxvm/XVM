package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IBattleResultsMeta extends flash.events.IEventDispatcher
    {
        function saveSortingS(arg1:String, arg2:String):void;

        function showQuestsWindowS(arg1:String):void;

        function as_setData(arg1:Object):void;
    }
}
