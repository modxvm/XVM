package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IStoreTableMeta extends flash.events.IEventDispatcher
    {
        function as_setTable(arg1:Array):void;

        function as_scrollToFirst(arg1:Number, arg2:String, arg3:String):void;

        function as_setGold(arg1:Number):void;

        function as_setCredits(arg1:Number):void;
    }
}
