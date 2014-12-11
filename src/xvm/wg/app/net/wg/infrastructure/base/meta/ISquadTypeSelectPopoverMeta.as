package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface ISquadTypeSelectPopoverMeta extends IEventDispatcher
    {
        
        function selectFightS(param1:String) : void;
        
        function getTooltipDataS(param1:String) : String;
        
        function as_update(param1:Array) : void;
    }
}
