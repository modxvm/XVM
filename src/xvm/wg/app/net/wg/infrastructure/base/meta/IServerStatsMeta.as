package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IServerStatsMeta extends IEventDispatcher
    {
        
        function getServersS() : Array;
        
        function reloginS(param1:int) : void;
        
        function isCSISUpdateOnRequestS() : Boolean;
        
        function startListenCsisUpdateS(param1:Boolean) : void;
        
        function as_setPeripheryChanging(param1:Boolean) : void;
        
        function as_setServersList(param1:Array) : void;
        
        function as_disableRoamingDD(param1:Boolean) : void;
        
        function as_setServerStats(param1:String, param2:String) : void;
        
        function as_setServerStatsInfo(param1:String) : void;
    }
}
