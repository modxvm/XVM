package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortBattleResultsWindowMeta extends IEventDispatcher
    {
        
        function getMoreInfoS(param1:int) : void;
        
        function getClanEmblemS() : void;
        
        function as_setData(param1:Object) : void;
        
        function as_notAvailableInfo(param1:int) : void;
        
        function as_setClanEmblem(param1:String) : void;
    }
}
