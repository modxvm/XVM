package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IQuestsCurrentTabMeta extends flash.events.IEventDispatcher
    {
        function sortS(arg1:int, arg2:Boolean):void;

        function getQuestInfoS(arg1:String):Object;

        function as_setQuestsData(arg1:Array, arg2:Number):void;

        function as_setSelectedQuest(arg1:String):void;
    }
}
