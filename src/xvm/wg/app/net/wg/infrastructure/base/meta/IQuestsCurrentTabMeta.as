package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IQuestsCurrentTabMeta extends IEventDispatcher
    {
        
        function sortS(param1:int, param2:Boolean) : void;
        
        function getQuestInfoS(param1:String) : Object;
        
        function getSortedTableDataS(param1:Object) : Array;
        
        function as_setQuestsData(param1:Array, param2:Number) : void;
        
        function as_setSelectedQuest(param1:String) : void;
    }
}
