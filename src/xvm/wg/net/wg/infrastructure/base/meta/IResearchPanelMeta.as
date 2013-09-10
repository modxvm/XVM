package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IResearchPanelMeta extends flash.events.IEventDispatcher
    {
        function goToResearchS():void;

        function as_setEarnedXP(arg1:Number):void;

        function as_setElite(arg1:Boolean):void;
    }
}
