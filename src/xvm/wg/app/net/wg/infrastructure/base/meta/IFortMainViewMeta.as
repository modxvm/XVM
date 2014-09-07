package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortMainViewMeta extends IEventDispatcher
    {
        
        function onStatsClickS() : void;
        
        function onClanClickS() : void;
        
        function onCalendarClickS() : void;
        
        function onSettingClickS() : void;
        
        function onCreateDirectionClickS(param1:uint) : void;
        
        function onEnterBuildDirectionClickS() : void;
        
        function onLeaveBuildDirectionClickS() : void;
        
        function onEnterTransportingClickS() : void;
        
        function onLeaveTransportingClickS() : void;
        
        function onIntelligenceClickS() : void;
        
        function onSortieClickS() : void;
        
        function onFirstTransportingStepS() : void;
        
        function onNextTransportingStepS() : void;
        
        function onViewReadyS() : void;
        
        function as_switchMode(param1:Object) : void;
        
        function as_toggleCommanderHelp(param1:Boolean) : void;
        
        function as_setMainData(param1:Object) : void;
        
        function as_setHeaderMessage(param1:String) : void;
        
        function as_setBattlesDirectionData(param1:Object) : void;
    }
}
