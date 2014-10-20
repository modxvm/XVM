package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortIntelligenceClanDescriptionMeta extends IEventDispatcher
    {
        
        function onOpenCalendarS() : void;
        
        function onOpenClanListS() : void;
        
        function onOpenClanStatisticsS() : void;
        
        function onOpenClanCardS() : void;
        
        function onAddRemoveFavoriteS(param1:Boolean) : void;
        
        function onAttackDirectionS(param1:int) : void;
        
        function onHoverDirectionS() : void;
        
        function as_setData(param1:Object) : void;
        
        function as_updateBookMark(param1:Boolean) : void;
    }
}
