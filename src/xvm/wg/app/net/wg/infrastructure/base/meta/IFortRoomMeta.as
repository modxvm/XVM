package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortRoomMeta extends IEventDispatcher
    {
        
        function showChangeDivisionWindowS() : void;
        
        function as_showLegionariesCount(param1:Boolean, param2:String) : void;
        
        function as_showLegionariesToolTip(param1:Boolean) : void;
    }
}
