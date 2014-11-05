package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortSettingsWindowMeta extends IEventDispatcher
    {
        
        function activateDefencePeriodS() : void;
        
        function disableDefencePeriodS() : void;
        
        function cancelDisableDefencePeriodS() : void;
        
        function as_setFortClanInfo(param1:Object) : void;
        
        function as_setMainStatus(param1:String, param2:String, param3:String) : void;
        
        function as_setView(param1:String) : void;
        
        function as_setDataForActivated(param1:Object) : void;
        
        function as_setCanDisableDefencePeriod(param1:Boolean) : void;
        
        function as_setDataForNotActivated(param1:Object) : void;
    }
}
